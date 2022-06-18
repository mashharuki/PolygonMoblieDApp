/**
 * データモデル、コントラクト関数、UIを更新するためのファイル
 */

// 必要なパッケージをインポートする。
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

/**
 * TodoListModelクラス
 * ChangeNotifierクラスを継承
 */
class TodoListModel extends ChangeNotifier {
    // 各種変数を定義
    List<Task> todos = [];
    bool isLoading = true;
    int? taskCount;
    final String _rpcUrl = "http://127.0.0.1:7545/";
    final String _wsUrl = "ws://127.0.0.1:7545/";

    // ウォレットの秘密鍵
    final String _privateKey = "88ee8a7767583634961245b09c15cd0dd421d954fc7d03f71b85985432f8ed4b";

    Web3Client? _client;
    String? _abiCode;
    // コントラクトの情報用の変数
    Credentials? _credentials;
    EthereumAddress? _contractAddress;
    EthereumAddress? _ownAddress;
    DeployedContract? _contract;
    // コントラクトの変数およびメソッド用の変数
    ContractFunction? _taskCount;
    ContractFunction? _todos;
    ContractFunction? _createTask;
    ContractFunction? _updateTask;
    ContractFunction? _deleteTask;
    ContractFunction? _toggleComplete;

    // コンストラクター
    TodoListModel() {
        init();
    }

    /**
     * 初期化関数
     */
    Future<void> init() async {
        _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
            return IOWebSocketChannel.connect(_wsUrl).cast<String>();
        });
        // 各種メソッドを呼び出す。 
        await getAbi();
        await getCredentials();
        await getDeployedContract();
    }

    /**
     * スマートコントラクトのABIを取得するメソッド
     */
    Future<void> getAbi() async {
        // jsonファイルの読み取り
        String abiStringFile = await rootBundle.loadString("smartcontract/TodoContract.json");
        var jsonAbi = jsonDecode(abiStringFile);
        // ABIを取得する。
        _abiCode = jsonEncode(jsonAbi["abi"]);
        // アドレスを取得する。
        _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    }

    /**
     * クレデンシャルオブジェクトを生成するメソッド
     */
    Future<void> getCredentials() async {
        _credentials = await _client!.credentialsFromPrivateKey(_privateKey);
        _ownAddress = await _credentials!.extractAddress();
    }

    /**
     * スマートコントラクトのインスタンスを生成するメソッド
     */
    Future<void> getDeployedContract() async {
        // コントラクトのデータを取得する。　
        _contract = DeployedContract(ContractAbi.fromJson(_abiCode!, "TodoList"), _contractAddress!);
        // 各種メソッドを定義する。
        _taskCount = _contract!.function("taskCount");
        _updateTask = _contract!.function("updateTask");
        _createTask = _contract!.function("createTask");
        _deleteTask = _contract!.function("deleteTask");
        _toggleComplete = _contract!.function("toggleComplete");
        _todos = _contract!.function("todos");
        // getTodosメソッドを呼び出す。
        await getTodos();
    }

    /**
     * 全てのTodoのデータを取得するメソッド
     */
    getTodos() async {

        List totalTaskList = await _client!.call(contract: _contract!, function: _taskCount!, params: []);

        BigInt totalTask = totalTaskList[0];
        taskCount = totalTask.toInt();
        todos.clear();
        
        for (var i = 0; i < totalTask.toInt(); i++) {
            var temp = await _client!.call(contract: _contract!, function: _todos!, params: [BigInt.from(i)]);
            
            if (temp[1] != "")
                todos.add(
                    Task(
                        id: (temp[0] as BigInt).toInt(),
                        taskName: temp[1],
                        isCompleted: temp[2],
                    ),
            );
        }

        isLoading = false;
        todos = todos.reversed.toList();

        // notifyListeners();
    }

    /**
     * Todoを追加するためのメソッド
     */
    addTask(String taskNameData) async {
        isLoading = true;
        //notifyListeners();
        // createTodoメソッドを呼び出す。
        await _client!.sendTransaction(
            _credentials!,
            Transaction.callContract(
                contract: _contract!,
                function: _createTask!,
                parameters: [taskNameData],
            ),
        );
        // 全件検索
        await getTodos();
    }

    /**
     * Todoを更新するメソッド
     */
    updateTask(int id, String taskNameData) async {
        isLoading = true;
        //notifyListeners();
        // updateTaskメソッドを呼び出す。
        await _client!.sendTransaction(
            _credentials!,
            Transaction.callContract(
                contract: _contract!,
                function: _updateTask!,
                parameters: [BigInt.from(id), taskNameData],
            ),
        );
        // 全件検索
        await getTodos();
    }

    /**
     * タスクの完了状態を更新するメソッド
     */
    toggleComplete(int id) async {
        isLoading = true;
        //notifyListeners();
        // toggleCompleteメソッドを呼び出す。
        await _client!.sendTransaction(
            _credentials!,
            Transaction.callContract(
                contract: _contract!,
                function: _toggleComplete!,
                parameters: [BigInt.from(id)],
            ),
        );
        // 全件検索
        await getTodos();
    }

    /**
     * タスクを削除するためのメソッド
     */
    deleteTask(int id) async {
        isLoading = true;
        //notifyListeners();
        // deleteTaskメソッドを呼び出す。
        await _client!.sendTransaction(
            _credentials!,
            Transaction.callContract(
                contract: _contract!,
                function: _deleteTask!,
                parameters: [BigInt.from(id)],
            ),
        );
        // 全件検索
        await getTodos();
    }
}

/**
 * タスク用のクラス
 */
class Task {
    final int? id;
    final String? taskName;
    final bool? isCompleted;
    Task({this.id, this.taskName, this.isCompleted});
}