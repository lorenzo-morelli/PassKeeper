import 'package:encrypt/encrypt.dart';
import 'package:passkeeper/services/encryption/encryption_contract.dart';

class EncryptionService implements IEncryption {

  final Encrypter _encrypter;
  final _iv = IV.fromLength(16);
  EncryptionService(this._encrypter);

  @override
  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  @override
  String encrypt(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }
}