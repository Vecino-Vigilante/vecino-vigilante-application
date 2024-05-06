import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:vecino_vigilante/configurations/router.dart';

class VecinoVigilanteApplication extends StatelessWidget {
  const VecinoVigilanteApplication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      routerConfig: router,
      supportedLocales: const [
        Locale('es'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(75, 123, 236, 1),
        ),
        useMaterial3: true,
      ),
      title: "Vecino Vigilante",
    );
  }
}
