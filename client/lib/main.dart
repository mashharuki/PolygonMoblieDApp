import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/TodoList.dart';
import 'package:client/TodoListModel.dart';

/**
 * mainメソッド
 */
void main() {
  runApp(const MyApp());
}

/**
 * MyAppクラス
 * StatelessWidgetクラスを継承する。
 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: const MaterialApp(
        title: 'Polygon ToDo DApp',
        home: TodoList(),
      ),
    );
  }
}