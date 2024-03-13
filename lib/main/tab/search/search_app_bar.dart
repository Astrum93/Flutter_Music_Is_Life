import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: TextFormField(
              cursorColor: Colors.grey,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.amber),
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(15),
                //   ),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.grey),
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(15),
                //   ),
                // ),
                hintText: '검색어를 입력 해주세요.',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 56.0);
}
