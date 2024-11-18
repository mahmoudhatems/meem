import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meem/core/cached/cached_secure.dart';
import 'package:meem/core/utils/constant.dart';
import 'package:meem/core/utils/di/di.dart';
import 'package:meem/core/utils/observer.dart';
import 'package:meem/meem_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Constants.tokenBox);
  await CachedSecure.init();
  setUp();
  Bloc.observer = MyBlocObserver();
  runApp(const MeemApp());
  
}
