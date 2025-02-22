import 'package:mi_fortitu/core/utils/secure_storage_helper.dart';


class LogoutIntraUsecase {

  void call() {
    SecureStorageHelper.deleteIntra42Tokens();
  }
}