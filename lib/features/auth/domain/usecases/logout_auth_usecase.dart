import 'package:mi_fortitu/core/utils/secure_storage_helper.dart';


class LogoutAuthUsecase {

  void call() {
    SecureStorageHelper.deleteSupabaseTokens();
  }
}