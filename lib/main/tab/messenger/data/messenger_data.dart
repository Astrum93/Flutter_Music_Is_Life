import 'package:MusicIsLife/data/memory/firebase/firestore/fire_store_data_util.dart';
import 'package:get/get.dart';

abstract mixin class MessengerDataProvider {
  late final messengerData = Get.find<MessengerData>();
}

class MessengerData extends GetxController {
  RxList chatRooms = [].obs;

  @override
  void onInit() {
    FireStoreDataUtil.getUserChats();
    super.onInit();
  }

  void getUserChatRooms() async {
    chatRooms.value = await FireStoreDataUtil.getUserChats();
  }
}
