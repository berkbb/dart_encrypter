import 'package:dart_encrypter/dart_encrypter.dart';
import 'package:logbox_color/extensions.dart';
import 'package:logbox_color/logbox_color.dart';

void main() {
  final _key = Security.generatePassword(true, true, true, true, 32); //32 chars
  final iv = Security.generatePassword(true, true, true, true, 16); // 16 chars.

  printLog("Key: $_key", LogLevel.verbose); // Print key.

  printLog("IV: $iv", LogLevel.verbose); // Print IV.

  var item = "Hello my dear !".encryptMyData(_key!, iv!); //Example text.

  if (item != null) {
    // If item is not null.
    printLog("Encrypted text: $item", LogLevel.info); // Print encrypted text.
    var deItem = item.decryptMyData(_key, iv); // decrypt text.
    printLog("Decrypted text: $deItem", LogLevel.info); // Print decrypted text.
  }

  printLog(
      "Password 1: ${Security.generatePassword(true, true, true, true, 16)}",
      LogLevel.debug); // Length 16 password.
  printLog(
      "Password 2: ${Security.generatePassword(false, true, false, true, 12)}",
      LogLevel.debug); // Length 12 password.
  printLog(
      "Password 3: ${Security.generatePassword(true, true, false, false, 25)}",
      LogLevel.debug); // Length 25 password.

  printLog(
      "Password with prefix: ${Security.generatePasswordwithPrefix(Security.generatePassword(true, true, false, false, 25)!, "xert", "_")}",
      LogLevel.debug); // Length 25 password with prefix.
}
