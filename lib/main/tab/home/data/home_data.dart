import 'package:MusicIsLife/data/memory/firebase/firestore/fire_store_data_util.dart';
import 'package:get/get.dart';

abstract mixin class HomeDataProvider {
  /// late 키워드를 사용하는 이유는 state생성이 initState보다 빠르기 때문
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
    FireStoreDataUtil.loggedUserDoc();
    super.onInit();
  }

  void docsProvider() async {
    // if () {
    //   userInfo.clear();
    //   contents.clear();
    //   return;
    // }

    final loggedUserDoc = await FireStoreDataUtil.loggedUserDoc();

    loggedUser = loggedUserDoc;
  }
}
