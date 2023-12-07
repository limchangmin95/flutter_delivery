import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int idx = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      idx = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "창민 딜리버리",
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        onTap: (int idx) {
          controller.animateTo(idx);
        },
        currentIndex: idx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: "음식",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: "주문",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "프로필",
          ),
        ],
      ),
      child: Center(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            const RestaurantScreen(),
            Center(
              child: Container(
                child: const Text(
                  "음식",
                ),
              ),
            ),
            Center(
              child: Container(
                child: const Text(
                  "주문",
                ),
              ),
            ),
            Center(
              child: Container(
                child: const Text(
                  "프로필",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
