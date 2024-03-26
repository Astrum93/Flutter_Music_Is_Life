import 'package:flutter/material.dart';

import '../../../../common/widget/width_height_widget.dart';
import '../data/search_data.dart';

class SearchResultContents extends StatelessWidget with SearchDataProvider {
  SearchResultContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: ListView.builder(
          itemCount: searchData.contents.length,
          itemBuilder: (context, index) => Column(
            children: [
              const Height(10),
              Row(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      child: Image.network(
                        searchData.contents[index].get('contentsImage'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  const Width(15),
                  Text(
                    searchData.contents[index].get('title').toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Height(10),
            ],
          ),
        ),
      ),
    );
  }
}
