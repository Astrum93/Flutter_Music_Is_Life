import 'package:MusicIsLife/data/memory/firebase/firestore/fire_store_data_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract mixin class MessengerProvider {
  late final messengerData = Get.find<MessengerData>();
}

class MessengerData extends GetxController {
  @override
  void onInit() {
    FireStoreDataUtil.currentUserFriendsDoc();
    super.onInit();
  }

  void getFriendsUserInfo() async {
    final DocumentSnapshot currentUserFriendsDoc =
        await FireStoreDataUtil.currentUserFriendsDoc();
  }
}
