import 'package:get/get.dart';
import 'package:todo_list_getx/app/modules/login/login_controller.dart';



class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
