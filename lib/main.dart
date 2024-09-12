import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klontong_project/features/bloc/product_bloc/product_bloc.dart';
import 'package:klontong_project/features/common/app_theme.dart';
import 'package:klontong_project/features/route/app_router.dart';
import 'package:klontong_project/features/route/routes.dart';
import 'di/injection.dart' as di;
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT INJECTABLE GET IT
  await di.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const KlontongApp());
}

class KlontongApp extends StatefulWidget {
  const KlontongApp({super.key});

  @override
  State<KlontongApp> createState() => _KlontongAppState();
}

class _KlontongAppState extends State<KlontongApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => di.locator<ProductBloc>(),
            ),
          ],
          child: MaterialApp(
            title: 'Klontong App',
            supportedLocales: Internationalization.supportByApp,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.theme(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter().generateRoute,
            initialRoute: Routes.mainRoute,
          ),
        );
      },
    );
  }
}
