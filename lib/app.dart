// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen_quiz/pages/home.dart';
import 'package:remote_kitchen_quiz/providers/item_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemBloc>(create: (context) => ItemBloc()),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}
