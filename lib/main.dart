import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/services/apiservice.dart';
import 'package:mastermold/features/auth/data/repos/authrepoimp.dart';
import 'package:mastermold/features/auth/presentation/view/login.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';
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
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Login(),
        ));
  }
}
