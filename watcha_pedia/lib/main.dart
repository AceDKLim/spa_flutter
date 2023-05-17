import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'book.dart';
import 'book_service.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        SearchPage(),
        LikedBookPage(),
      ].elementAt(bottomNavIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            bottomNavIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '좋아요',
          ),
        ],
        currentIndex: bottomNavIndex,
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 80,
              title: TextField(
                onSubmitted: (value) {
                  bookService.search(value);
                },
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "작품, 감독, 배우, 컬렉션, 유저 등",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  if (bookService.bookList.isEmpty) return SizedBox();
                  Book book = bookService.bookList.elementAt(index);
                  return BookTile(book: book);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: bookService.bookList.length,
              ),
            ));
      },
    );
  }
}

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    BookService bookService = context.read<BookService>();
    //subtile은 빈 문자열 저자가 1명이면 첫 번째 저자만 저장 2개 이상이면 ,로 분리
    String st = '';
    if (book.authors.length == 1) {
      st = book.authors[0];
    } else if (book.authors.length < 2) {
      for (int i = 0; i < book.authors.length; i++) {
        st += book.authors[i] + ',';
      }
    }
    //마지막에 띄어쓰고 날짜 삽입
    st += '\n';
    st += book.publishedDate;
    return ListTile(
      isThreeLine: true,
      dense: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(
              url: book.previewLink.replaceFirst("http", "https"),
            ),
          ),
        );
      },
      leading: Image.network(
        book.thumbnail,
        fit: BoxFit.fitHeight,
      ),
      title: Text(
        book.title,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        st,
        style: TextStyle(color: Colors.grey),
      ),
      trailing: IconButton(
        onPressed: () {
          bookService.toggleLikeBook(book: book);
        },
        icon: bookService.likedBookList.map((book) => book.id).contains(book.id)
            ? Icon(
                Icons.star,
                color: Colors.amber,
              )
            : Icon(Icons.star_border),
      ),
    );
  }
}

class LikedBookPage extends StatelessWidget {
  const LikedBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) {
              if (bookService.likedBookList.isEmpty) return SizedBox();
              Book book = bookService.likedBookList.elementAt(index);
              return BookTile(book: book);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: bookService.likedBookList.length,
          ),
        );
      },
    );
  }
}

class WebViewPage extends StatelessWidget {
  WebViewPage({super.key, required this.url});

  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(url),
      ),
      body: WebView(initialUrl: url),
    );
  }
}
