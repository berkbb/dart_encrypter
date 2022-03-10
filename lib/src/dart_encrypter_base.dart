import 'dart:math';
import 'package:encrypt/encrypt.dart';
import 'package:logbox_color/extensions.dart';
import 'package:logbox_color/logbox_color.dart';

///Security class.

class Security {
  ///* Info: Generate password.
  ///* Params: [isNumberActive] determines access code will include number 0-9 or not, [isSpecialCharacherActive] enables / disables special character, [isUpperCaseActive] enables / disables uppercase letters, [isLowerCaseActive] enables / disables lowercase letters, [length] is access code length.
  ///* Returns: String?
  ///* Notes:
  static String? generatePassword(
      bool isNumberActive,
      bool isSpecialCharacherActive,
      bool isUpperCaseActive,
      bool isLowerCaseActive,
      int length) {
    try {
//ASCII bounds.
      int minUpperLetter = 65;
      int maxUpperLetter = 90;

      int minLowerLetter = 97;
      int maxLowerLetter = 122;

      var specialChars = ["!", "#", "\$", "%", "&", "@", "*", "^"];

      StringBuffer sb = StringBuffer(); // String builder.
      Random rng = Random(); // Random number generator

      for (int i = 0; i < length; i++) {
        int choice;

        choice = rng.nextInt(
            4); // Four status available: * Uppercase letter, Lowerccase letter, number, special character

        if (choice == 0 && isLowerCaseActive) // If 0 comes. lover a-z.
        {
          int rangeLower = minLowerLetter +
              rng.nextInt((maxLowerLetter - minLowerLetter) + 1);
          sb.writeCharCode(rangeLower);
        } else if (choice == 1 && isUpperCaseActive) // 1 comes, upper A-Z.
        {
          int rangeUpper = minUpperLetter +
              rng.nextInt((maxUpperLetter - minUpperLetter) + 1);
          sb.writeCharCode(rangeUpper);
        } else if (choice == 2 && isNumberActive) // 2 comes. a number 0-9.
        {
          sb.write(rng.nextInt(10));
        } else // 3 comes. special characters.
        {
          var selectID = rng.nextInt(specialChars.length);
          sb.write(specialChars[selectID]);
        }
      }

      return sb.toString();
    } catch (e) {
      return null;
    }
  }

  ///* Info: Generate password with prefix. return password like "XXXXy'generatedpassword'". XXXX is prefix, y is delimiter.
  ///* Params:[password] is password,  [prefix] is prefix, [prefixDelimiter] is delimiter for prefix;
  ///* Returns: String?
  ///* Notes:
  static String? generatePasswordwithPrefix(
      String password, String prefix, String prefixDelimiter) {
    try {
      return "$prefix$prefixDelimiter$password";
    } catch (e) {
      printLog(e.toString(), LogLevel.error);
      return null;
    }
  }
}

/// Encryption string extension.
extension Encryption on String {
  ///* Info: Encyrpting the data.
  ///* Params:  [_key] is is Key String, [iv] is IV String.
  ///* Returns: String?
  ///* Notes: Key length must be == 32 , IV length must be == 16.
  String? encryptMyData(String _key, String iv) {
    try {
      if (_key.length == 32 && iv.length == 16) {
        final e = Encrypter(
            AES(Key.fromUtf8(_key), mode: AESMode.ctr, padding: null));
        final encryptedData = e.encrypt(this, iv: IV.fromUtf8(iv));
        String urlEncData = Uri.encodeComponent(encryptedData.base64);
        return urlEncData;
      } else {
        throw Exception("Length error. Check Key and IV Length.");
      }
    } catch (e) {
      printLog(e.toString(), LogLevel.error);
      return null;
    }
  }

  ///* Info: Decrypting the data.
  ///* Params:  [_key] is is Key String, [iv] is IV String.
  ///* Returns: String?
  ///*  Notes: Key length must be == 32 , IV length must be == 16.
  String? decryptMyData(String _key, String iv) {
    try {
      if (_key.length == 32 && iv.length == 16) {
        String urlDec = Uri.decodeComponent(this);
        final e = Encrypter(
            AES(Key.fromUtf8(_key), mode: AESMode.ctr, padding: null));
        final decryptedData =
            e.decrypt(Encrypted.fromBase64(urlDec), iv: IV.fromUtf8(iv));

        return decryptedData;
      } else {
        throw Exception("Length error. Check Key and IV Length.");
      }
    } catch (e) {
      printLog(e.toString(), LogLevel.error);
      return null;
    }
  }
}
