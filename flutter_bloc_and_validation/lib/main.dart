import 'package:flutter/material.dart';

import 'view/page_saleOffer_form.dart';

void main() {
  runApp(MyApp());
}

/// Ejemplo de como usar Bloc, BlocProvider y validar TextField
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc y Validación TextField',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormSaleOffer(),
    );
  }
}