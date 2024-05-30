import 'dart:convert';
import 'package:crypto/crypto.dart';

String calculateMD5(String input) {
  List<int> bytes = utf8.encode(input);
  Digest digest = md5.convert(bytes);
  String md5Hash = digest.toString();
  return md5Hash;
}