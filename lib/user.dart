import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, this.id = "1"}) : super(key: key);
  final String id;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  Map<String, dynamic>? _userData;

  Future getUser() async {
    String base = "";
    if (Platform.isAndroid) {
      base = "http://10.0.2.2:8000/";
    } else {
      base = "http://127.0.0.1:8000/";
    }
    http.Response response = await http.get(Uri.parse(base + "users/" + widget.id));
    if (response.statusCode == 200) {
      setState(() {
        _userData = jsonDecode(response.body);
      });
    }
  }

  Future postItem(String id, String title, String description) async {
    String base = "";
    if (Platform.isAndroid) {
      base = "http://10.0.2.2:8000/";
    } else {
      base = "http://127.0.0.1:8000/";
    }
    String url = base + "users/" + id + "/items";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var param = {
      "title": title,
      "description": description,
    };
    http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(param));
    if (response.statusCode == 200) {
      getUser();
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {

    String? title;
    String? description;

    return Scaffold(
      appBar: AppBar(
          title: const Text("User")
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Text(
                "UserID:" + widget.id,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 28),
              ),
            ),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(0.4),
                1: FlexColumnWidth(1.5),
                3: FlexColumnWidth(),
              },
              children: [
                const TableRow(
                  children: <Widget>[
                    Center(child: Text("user.id", style: TextStyle(fontSize: 20),),),
                    Center(child: Text("user.email", style: TextStyle(fontSize: 20),),),
                    Center(child: Text("user.is_active", style: TextStyle(fontSize: 20),),),
                  ],
                ),
                if (_userData != null)
                  TableRow(
                    children: <Widget> [
                      Text(_userData!["id"].toString(), style: const TextStyle(fontSize: 20),),
                      Text(_userData!["email"], style: const TextStyle(fontSize: 20),),
                      Text(_userData!["is_active"].toString(), style: const TextStyle(fontSize: 20),),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 20,), // 空白行
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Item Index",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 28),
              ),
            ),
            Table(
              border: TableBorder.all(),
              children: [
                const TableRow(
                  children: <Widget>[
                    Center(child: Text("item.id", style: TextStyle(fontSize: 20),),),
                    Center(child: Text("item.owner_id", style: TextStyle(fontSize: 20),),),
                    Center(child: Text("item.title", style: TextStyle(fontSize: 20),),),
                    Center(child: Text("item.description", style: TextStyle(fontSize: 20),),),
                  ],
                ),
                if (_userData != null)
                  for (var itemData in _userData!["items"])
                    TableRow(
                      children: <Widget> [
                        Text(itemData["id"].toString(), style: const TextStyle(fontSize: 20),),
                        Text(itemData["owner_id"].toString(), style: const TextStyle(fontSize: 20),),
                        Text(itemData["title"], style: const TextStyle(fontSize: 20),),
                        Text(itemData["description"], style: const TextStyle(fontSize: 20),),
                      ],
                    ),
              ],
            ),
            const SizedBox(height: 20,), // 空白行
            const SizedBox(
              width: double.infinity,
              child: Text(
                "メソッド一覧",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 20,), // 空白行
            const SizedBox(
              width: double.infinity,
              child: Text(
                "post items",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 28),
              ),
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "title",
                          hintText: "hello"
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "description",
                        hintText: "world",
                      ),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ),
                  TextButton(
                    child: const Text("送信"),
                    onPressed: () {
                      if (title != null && description != null) {
                        postItem(widget.id, title!, description!);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}