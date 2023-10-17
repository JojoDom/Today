import 'package:flutter/material.dart';
import 'package:today/config/provider_config.dart';
import 'package:today/model/all_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:today/pages/home/splash_page.dart';
import 'package:today/utils/theme_util.dart';

import 'i10n/localization_intl.dart';

void main() {
  runApp(
    ProviderConfig.getInstance().getGlobal(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context)..setContext(context);

    return MaterialApp(
      title: model.appName,
      localizationsDelegates: const[
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DemoLocalizationsDelegate()
      ],
      supportedLocales: const[
         Locale('en', 'US'), // 美国英语
         Locale('zh', 'CN'), // 中文简体
      ],
      
      locale: model.currentLocale,
      theme: ThemeUtil.getInstance().getTheme(model.currentThemeBean),
      home: getHomePage(model.goToLogin, model.enableSplashAnimation),
    );
  }

  Widget getHomePage(bool goToLogin, bool enableSplashAnimation){
    if(goToLogin == null) return Container();
    if(enableSplashAnimation) return  SplashPage();
    return goToLogin ? ProviderConfig.getInstance().getLoginPage(isFirst: true)
        : ProviderConfig.getInstance().getMainPage();
  }

}
