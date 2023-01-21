import 'package:firstproject/presentation/main/pages/home/view/home_page.dart';
import 'package:firstproject/presentation/main/pages/notification/notification.dart';
import 'package:firstproject/presentation/main/pages/search/search_page.dart';
import 'package:firstproject/presentation/main/pages/settings/settings.dart';
import 'package:firstproject/presentation/resources/color_manager.dart';
import 'package:firstproject/presentation/resources/string_manager.dart';
import 'package:firstproject/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage(),
  ];
  List<String> titles = [
    AppString.home,
    AppString.search,
    AppString.notifications,
    AppString.settings,
  ];
  var _title = AppString.home;
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        _title,
        style: Theme.of(context).textTheme.titleSmall,
      )),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.lightGrey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: AppString.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppString.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: AppString.notifications),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppString.settings),
          ],
          onTap: ontap,
          currentIndex: _currentIndex,
        ),
      ),
    );
  }

  ontap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
