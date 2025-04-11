import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:registration_app/pages/main_page.dart';  // Убедитесь, что импорт правильный

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ru'),
      ],
      path: 'assets/translations', // Путь к файлам локализации
      fallbackLocale: Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        EasyLocalization.of(context)!.delegate, // Получаем делегат локализации через контекст
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ru'),
      ],
      locale: context.locale, // Устанавливаем локаль
      home: const MainPage(), // Переключитесь на MainPage (или на ваш основной виджет)
    );
  }
}
