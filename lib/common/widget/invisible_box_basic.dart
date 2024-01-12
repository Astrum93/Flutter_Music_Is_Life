import 'package:flutter/material.dart';

class InvisibleBoxBasic extends StatelessWidget {
  const InvisibleBoxBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 380,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 7,
          )
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '음악 검색',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
