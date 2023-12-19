import 'package:flutter/material.dart';

class music_player extends StatelessWidget {
  const music_player({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('lib/Image/Thumb/Thumb_Test.jpeg'),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let Me Leave You',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '그루비룸 (GroovyRoom), GEMINI (제미나이)',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_circle_outline_rounded,
                color: Colors.grey,
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
