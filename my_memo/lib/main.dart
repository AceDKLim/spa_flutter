import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_memo/memo_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MemoService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        List<Memo> memoList = memoService.memoList;
        return Scaffold(
          appBar: AppBar(
            title: Text("My Memo"),
          ),
          body: memoList.isEmpty
              ? Center(child: Text("메모를 작성해주세요"))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index];
                    return ListTile(
                      // 메모 고정 아이콘
                      leading: IconButton(
                        icon: memoService.memoList[index].pin == false
                            ? Icon(CupertinoIcons.pin)
                            : Icon(CupertinoIcons.pin_fill),
                        onPressed: () {
                          memoService.clickPin(index: index);
                        },
                      ),
                      // 메모 내용(최대 3줄)
                      title: Text(
                        memo.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        memo.time,
                        maxLines: 1,
                      ),
                      onTap: () async {
                        // 아이템 클릭시
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              index: index,
                            ),
                          ),
                        );
                        if (memoList[index].content == '') {
                          memoService.deleteMemo(index: index);
                        }
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              // + 버튼 클릭시 메모 생성 및 수정 페이지로 이동
              memoService.createMemo(content: '');
              int newIndex = memoService.memoList.length - 1;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    index: newIndex,
                  ),
                ),
              );
              if (memoList[newIndex].content == '') {
                memoService.deleteMemo(index: newIndex);
              }
            },
          ),
        );
      },
    );
  }
}

// 메모 생성 및 수정 페이지
// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.index});

  final int index;

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();

    Memo memo = memoService.memoList[index];

    contentController.text = memo.content;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDeleteDialog(context, memoService);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: contentController,
          decoration: InputDecoration(
            hintText: "메모를 입력하세요",
            border: InputBorder.none,
          ),
          autofocus: true,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          onChanged: (value) {
            // 텍스트필드 안의 값이 변할 때
            memoService.updateMemo(index: index, content: value);
          },
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, MemoService memoService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // 삭제 버튼 클릭시
          title: Text("정말로 삭제하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                memoService.deleteMemo(index: index);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                '확인',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}
