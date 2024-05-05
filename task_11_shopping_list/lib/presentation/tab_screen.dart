import 'package:flutter/material.dart';

import 'package:task_11_shopping_list/assets/colors/app_colors.dart';
import 'package:task_11_shopping_list/assets/res/app_strings.dart';
import 'cheque_screen.dart';
import 'empty_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedIndex = 3;
  final List<Widget> widgetOptions = <Widget>[
    const EmptyScreen(
      title: AppStrings.catalog,
    ),
    const EmptyScreen(
      title: AppStrings.search,
    ),
    const EmptyScreen(
      title: AppStrings.cart,
    ),
    const ChequeScreen(),
  ];

  void onItemTapped(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.lightGrey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.darkGrey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.article_outlined,
              ),
              label: AppStrings.catalog,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: AppStrings.search,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_mall_outlined,
              ),
              label: AppStrings.cart,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: AppStrings.personal,
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
