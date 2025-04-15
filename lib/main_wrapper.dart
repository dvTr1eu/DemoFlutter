import 'package:demo_bottomtab_tabbar/controller/main_wrapper_controller.dart';
import 'package:demo_bottomtab_tabbar/view/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'utils/color_constants.dart';
import 'view/cart_tab.dart';
import 'view/profile/profile_tab.dart';
import 'view/statistics_tab.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final MainWrapperController controller = Get.put(MainWrapperController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        title:Text(
          'Main Wrapper',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: PageView(
        onPageChanged: controller.animateToTab,
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          HomeTab(),
          CartTab(),
          StatisticsTab(),
          ProfileTab()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomAppBarItem(
                  context, 
                  icon: IconlyLight.home, 
                  page: 0, 
                  label: "Home"
                ),
                _bottomAppBarItem(
                  context, 
                  icon: IconlyLight.wallet, 
                  page: 1, 
                  label: "Cart"
                ),
                _bottomAppBarItem(
                  context, 
                  icon: IconlyLight.chart, 
                  page: 2, 
                  label: "Stats"
                ),
                _bottomAppBarItem(
                  context, 
                  icon: IconlyLight.profile, 
                  page: 3, 
                  label: "Profile"
                ),
              ],
            ),
          )
        )
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
    {required icon, required page, required label}){
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: controller.currentPage.value == page ? ColorConstants.appColors : Colors.black,
            ),
            Text(
              label, 
              style: TextStyle(
                color: controller.currentPage.value == page ? ColorConstants.appColors : Colors.black,
                fontSize: 13,
                fontWeight: controller.currentPage.value == page ? FontWeight.w600 : null,
              )
            )
          ],
        ),
      ),
    );
  }
}

