import 'package:MusicIsLife/data/memory/firebase/firestore/fire_store_data_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract mixin class MessengerDataProvider {
  late final messengerData = Get.find<MessengerData>();
}

class MessengerData extends GetxController {
  RxList friendsUserInfoDocs = [].obs;
  RxList chatRooms = [].obs;

  @override
  void onInit() {
    FireStoreDataUtil.currentUserFriendsDoc();
    FireStoreDataUtil.getUserChats();
    super.onInit();
  }

  void getFriendsUserInfo() async {
    List friendsId = [];
    final DocumentSnapshot currentUserFriendsDoc =
        await FireStoreDataUtil.currentUserFriendsDoc();
    friendsId = currentUserFriendsDoc.get('friends');
    for (dynamic id in friendsId) {
      friendsUserInfoDocs.add(await FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(id)
          .get());
    }
  }

  void getUserChatRooms() async {
    chatRooms.value = await FireStoreDataUtil.getUserChats();
  }
}
