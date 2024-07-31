import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mastermold/core/commn/date/date_cubit.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/services/apiservice.dart';
import 'package:mastermold/features/actions/data/repo/actionrepoimp.dart';
import 'package:mastermold/features/actions/presentation/viewmodel/cubit/clientactions_cubit.dart';
import 'package:mastermold/features/auth/data/repos/authrepoimp.dart';
import 'package:mastermold/features/auth/presentation/view/login.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';
import 'package:mastermold/features/clients/data/repo/clientrepoimp.dart';
import 'package:mastermold/features/clients/presentation/viewmodel/client/client_cubit.dart';
import 'package:mastermold/features/employees/data/model/repos/emoloyeesrepoimp.dart';
import 'package:mastermold/features/employees/presentation/viewmodel/employee/employee_cubit.dart';
import 'package:mastermold/features/home/presentation/view/home.dart';
import 'package:mastermold/features/managers/data/model/repos/emoloyeesrepoimp.dart';
import 'package:mastermold/features/managers/presentation/viewmodel/employee/employee_cubit.dart';
import 'package:mastermold/features/splash/splash.dart';
import 'package:mastermold/firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cashhelper.initcashhelper();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Apiservice.initdio();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("11bed588-849f-432c-9b87-8d70ea9b6d9e");
  OneSignal.Notifications.requestPermission(true);

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
          BlocProvider(
            create: (context) => ClientCubit(Clientrepoimp()),
          ),
          BlocProvider(
            create: (context) => ClientactionsCubit(Actionrepoimp()),
          ),
          BlocProvider(
            create: (context) => DateCubit(),
          ),
          BlocProvider(
            create: (context) => EmployeeCubit(Emoloyeesrepoimp()),
          ),
          BlocProvider(
            create: (context) =>
                EmployeeCubitmanager(Emoloyeesrepoimpmangaer()),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                localizationsDelegates: const [
                  GlobalCupertinoLocalizations.delegate, // Here !
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar'), // Arabic

                  Locale('en'), // English
                ],
                home: splash(),
              );
            }));
  }
}
