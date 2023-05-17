// 두번째 페이지
import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[300]!,
            Colors.blue[900]!,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    DefaultTabController.of(context).index = 0;
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        "라이브러리",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    DefaultTabController.of(context).index = 2;
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.show_chart,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        "차트",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 110,
            ),
            Text(
              "Shazam하려면 탭하세요",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.blue[300],
                  size: 300,
                ),
                Positioned(
                  left: 60,
                  top: 60,
                  child: Image(
                    image: AssetImage('assets/image/shazam.png'),
                    color: Colors.white,
                    width: 180,
                    height: 180,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Stack(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.blue[300],
                  size: 80,
                ),
                Positioned(
                  left: 20,
                  top: 20,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
