import 'package:hive_flutter/hive_flutter.dart';
import 'package:meem/core/utils/constant.dart';

Future changeTokenState({required String? value}) async {
  await Hive.box(Constants.tokenBox).put(Constants.tokenKey, value);
}
