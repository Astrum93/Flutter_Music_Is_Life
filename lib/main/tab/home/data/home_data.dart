import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:music_is_life/data/memory/firebase/firestore/fire_store_data_util.dart';

abstract mixin class HomeDataProvider {
  /// late 키워드를 사용하는 이유는 state 생성이 initState보다 빠르기 때문
  late final homeData = Get.find<HomeData>();
}

class HomeData extends GetxController {
  List homeUserInfoData = [];
  List homeContentsData = [];
  RxList userInfo = [].obs;
  RxList contents = [].obs;
  RxMap loggedUser = {}.obs;

  @override
  void onInit() {
    FireStoreDataUtil.getUserInfoDoc();
    FireStoreDataUtil.getContentsDoc();
    FireStoreDataUtil.getUserPlayListDoc();
    FireStoreDataUtil.currentUserDoc();
    super.onInit();
  }

  Future<void> docsProvider() async {
    final loggedUserDoc = await FireStoreDataUtil.currentUserDoc();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loggedUser = loggedUserDoc.toRxMap();
      } else {
        loggedUser.clear();
      }
    });
    loggedUser = loggedUserDoc.toRxMap();
  }
}
