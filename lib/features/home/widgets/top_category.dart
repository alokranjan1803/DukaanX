import 'package:dukaanx/constraints/global_variables.dart';
import 'package:dukaanx/features/home/screens/category_deal_screen.dart';
import 'package:flutter/material.dart';

class TopCategory extends StatelessWidget {
  const TopCategory({super.key});

  void navigateCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 80,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigateCategoryPage(
                  context, GlobalVariables.categoryImages[index]['title']!),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
