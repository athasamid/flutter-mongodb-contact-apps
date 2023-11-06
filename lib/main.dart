import 'package:demo_kontak_mongodb/models/database.dart';
import 'package:demo_kontak_mongodb/pages/detail_kontak_page.dart';
import 'package:demo_kontak_mongodb/pages/form_kontak_page.dart';
import 'package:demo_kontak_mongodb/pages/list_kontak_page.dart';
import 'package:flutter/material.dart';

void main() async {
  await Database().openConnection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: ListKontakPage.routeName,
      routes: {
        DetailKontakPage.routeName: (context) => DetailKontakPage(),
        ListKontakPage.routeName: (context) => ListKontakPage(),
        FormKontakPage.routeName: (context) => FormKontakPage(),
      },
    );
  }
}
