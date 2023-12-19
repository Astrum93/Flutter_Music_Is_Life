import 'package:flutter/material.dart';
import 'package:naspace/Widget/HashTagWidget.dart';

class InvisibleBoxHot extends StatelessWidget {
  const InvisibleBoxHot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData(textTheme: const TextTheme());
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 350,
              height: 400,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 7,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: 325,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage('lib/Image/Thumb/Thumb_Test.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Text(''),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Let Me Leave You',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '그루비룸 (GroovyRoom), GEMINI (제미나이)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                    'lib/Image/profile/pikachu.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Pikachu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '10.3k',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              color: Colors.white,
                              iconSize: 25,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '19650',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const Row(
          children: [
            HashTagWidget(tagname: '기분좋음'),
            SizedBox(width: 8),
            HashTagWidget(tagname: '신남'),
            SizedBox(width: 8),
            HashTagWidget(tagname: '쇼미11'),
            SizedBox(width: 8),
            HashTagWidget(tagname: 'GEMINI'),
          ],
        ),
      ],
    );
  }
}
