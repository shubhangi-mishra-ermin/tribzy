import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class CommunityController extends GetxController {
  var communityList = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadCommunityData();
  }

  void loadCommunityData() async {
    String data = await DefaultAssetBundle.of(Get.context!).loadString("data/community_list.json");
    final jsonResult = json.decode(data);
    communityList.value = jsonResult['communities'];
  }
}

