import 'package:get/get.dart';
import 'package:tutor_kit/screens/controller/authentication_repository.dart';

import '../../const/consts.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final phoneNo = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final dop = TextEditingController();
  final department = TextEditingController();
  final institute = TextEditingController();
  final Class = TextEditingController();
  final subject = TextEditingController();

}