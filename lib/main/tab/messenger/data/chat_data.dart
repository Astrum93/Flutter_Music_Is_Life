import 'package:get/get.dart';

abstract mixin class ChatDataProvider {
  late final chatData = Get.find<ChatData>();
}

class ChatData extends GetxController {
  RxString chatImage = "".obs;
  RxString chatName = "".obs;
  RxList member = [].obs;
  RxList likedMember = [].obs;
  RxInt memberCount = 0.obs;
}
