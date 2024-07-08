import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/services/apiservice.dart';
import 'package:mastermold/features/auth/data/repos/authrepoimp.dart';
import 'package:mastermold/features/auth/presentation/view/login.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';
import 'package:mastermold/features/home/presentation/view/home.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cashhelper.initcashhelper();
  /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  await Apiservice.initdio();
  OneSignal.initialize("11bed588-849f-432c-9b87-8d70ea9b6d9e");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(Authrepoimp()),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: home(),
        ));
  }
}
