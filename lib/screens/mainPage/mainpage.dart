import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/Constants/AppColors.dart';
import 'package:karaz_driver/tabs/earningsTab/earningstab.dart';
import 'package:karaz_driver/tabs/homeTab/hometab.dart';
import 'package:karaz_driver/tabs/profile/profiletab.dart';
import 'package:karaz_driver/tabs/ratings/ratingstab.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';

  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selecetdIndex = 0;

  void onItemClicked(int index) {
    setState(() {
      selecetdIndex = index;
      tabController!.index = selecetdIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const <Widget>[
          HomeTabView(),
          EarningsView(),
          RatingsTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.credit_card),
            label: 'Earnings'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: 'rated'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'profile'.tr,
          ),
        ],
        currentIndex: selecetdIndex,
        unselectedItemColor: AppColors.colorIcon,
        selectedItemColor: AppColors.colorAccent1,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onItemClicked,
      ),
    );
  }
}
