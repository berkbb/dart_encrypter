import 'package:dart_encrypter/dart_encrypter.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final _key =
        Security.generatePassword(true, true, true, true, 32); //32 chars
    final iv =
        Security.generatePassword(true, true, true, true, 16); // 16 chars.
    String? item;
    setUp(() {
      // Additional setup goes here.
      item = "Hello my dear !".encryptMyData(_key!, iv!); //Example text.
    });

    test('Encryption test', () {
      expect(item, isNotNull);
      expect(item?.decryptMyData(_key!, iv!), isNotNull);
    });
    test('Create password test', () {
      expect(Security.generatePassword(true, true, true, true, 16)?.length, 16);
      expect(
          Security.generatePassword(false, true, false, true, 12)?.length, 12);
      expect(
          Security.generatePassword(true, true, false, false, 25)?.length, 25);
    });
  });
}
