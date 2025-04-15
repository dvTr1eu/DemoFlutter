import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../services/home_services.dart';

class MainWrapperController extends GetxController {
  late PageController pageController;
  RxList<dynamic> users = <dynamic>[].obs;
  RxBool isLoading = false.obs;

  RxInt currentPage = 0.obs;

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    fetchUsers();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void fetchUsers() async {
    try {
      isLoading.value = true;
      final result = await HomeService.fetchUser();
      users.assignAll(result);
      print("Fetching done: ${users.length} users loaded.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
