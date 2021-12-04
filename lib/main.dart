import 'package:flutter/material.dart';
import 'package:flutter_fastapi_sql_app/user.dart';
import 'package:flutter_fastapi_sql_app/users.dart';

import 'items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _userSkip = "0";
    String _userLimit = "100";
    String _userId = "1";
    String _itemSkip = "0";
    String _itemLimit = "100";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Index"),
      ),
      body: Center(
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(0.5),
            1: FlexColumnWidth(),
          },
          children: [
            const TableRow(
              children: <Widget>[
                Center(child: Text("メソッド名", style: TextStyle(fontSize: 24),),),
                Center(child: Text("パラメータ", style: TextStyle(fontSize: 24),),),
              ],
            ),
            TableRow(
              children: <Widget>[
                const Center(child:
                  Text(
                    "get users",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Center(
                  child:Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "skip",
                            ),
                            initialValue: _userSkip,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _userSkip = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "limit",
                            ),
                            initialValue: _userLimit,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _userLimit = value;
                            },
                          ),
                        ),
                        TextButton(
                          child: const Text("送信"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UsersPage(skip: _userSkip, limit: _userLimit,),)
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                const Center(
                  child: Text(
                    "get user",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "user_id",
                          ),
                          initialValue: _userId,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _userId = value;
                          },
                        ),
                      ),
                      TextButton(
                        child: const Text("送信"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserPage(id: _userId),)
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                const Center(
                  child: Text(
                    "get items",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "skip",
                          ),
                          initialValue: _itemSkip,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _itemSkip = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "limit",
                          ),
                          initialValue: _itemLimit,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _itemLimit = value;
                          },
                        ),
                      ),
                      TextButton(
                        child: const Text("送信"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItemsPage(skip: _itemSkip, limit: _itemLimit,),)
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}