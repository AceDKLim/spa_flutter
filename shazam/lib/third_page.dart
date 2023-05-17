import 'package:flutter/material.dart';

// 세번째 페이지
class ThirdTab extends StatelessWidget {
  const ThirdTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const chartData = {
      'korea': [
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
      ],
      'global': [
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
      ],
      'newyork': [
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
      ],
    };
    var country = chartData.keys.toList();
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            "차트",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              Container(
                color: Colors.deepPurple,
                height: 240,
              ),
              Positioned(
                top: 70,
                right: 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  height: 50,
                  width: 400,
                  child: Center(
                    child: Text(
                      "국가 및 도시별 차트",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: 210,
                child: Text(
                  "전 세계",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 10,
            color: Colors.grey[500],
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: chartData.length,
              itemBuilder: (context, index_1) {
                return SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              country[index_1] == 'korea'
                                  ? "대한민국차트"
                                  : country[index_1] == 'global'
                                      ? "글로벌 차트"
                                      : "뉴욕 차트",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '모두 보기',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: chartData[country[index_1]]!.length,
                          itemBuilder: (BuildContext context, int index_2) {
                            return SizedBox(
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    (chartData[country[index_1]]?[index_2]
                                        ['imageUrl'])!,
                                    width: 140,
                                  ),
                                  Text(
                                    (chartData[country[index_1]]?[index_2]
                                        ['name'])!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    (chartData[country[index_1]]?[index_2]
                                        ['artist'])!,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            endIndent: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[400],
                height: 1,
                thickness: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
