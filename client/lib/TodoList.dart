/**
 * フロントのメインとなるファイル
 */

// 必要なモジュールをインポートする
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/TodoBottomSheet.dart';
import 'package:client/TodoListModel.dart';

/**
 * TodoListクラス
 * StatelessWidgetクラスを継承する。
 */
class TodoList extends StatelessWidget {
    // Todoの情報を格納する配列
    const TodoList({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        var listModel = Provider.of<TodoListModel>(context, listen: true);

        return Scaffold(
            appBar: AppBar(
                title: const Text("My Polygon Todo Dapp"),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    // showTodoBottomSheetメソッドを呼び出す。
                    showTodoBottomSheet(context);
                },
                child: const Icon(Icons.add),
            ),
            body: listModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                        const SizedBox(height: 16),
                        Expanded(
                            child: ListView.builder(
                                itemCount: listModel.todos.length,
                                itemBuilder: (context, index) => ListTile(
                                    title: InkWell(
                                        onTap: () {
                                            showTodoBottomSheet(
                                                context,
                                                task: listModel.todos[index],
                                            );
                                        },
                                        child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 12,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                            children: [
                                            //チェックボックス
                                            Checkbox(
                                                value: listModel.todos[index].isCompleted,
                                                onChanged: (val) {
                                                    // toggleCompleteメソッドを呼び出す。
                                                    listModel.toggleComplete(listModel.todos[index].id!);
                                                },
                                            ),
                                            //タスク名
                                            Text(listModel.todos[index].taskName!),
                                            ],
                                        ),
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ],
                ),
        );
    }
}