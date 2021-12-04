import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, this.skip = "0", this.limit = "100"}) : super(key: key);
  final String skip;
  final String limit;

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  List? _usersData;

  Future getUser() async {
    String base = "";
    if (Platform.isAndroid) {
      base = "http://10.0.2.2:8000/";
    } else {
      base = "http://127.0.0.1:8000/";
    }
    http.Response response = await http.get(Uri.parse(base + "users/?skip=" + widget.skip + "&limit=" + widget.limit));
    if (response.statusCode == 200) {
      setState(() {
        _usersData = jsonDecode(response.body);
      });
    }
  }

  Future postUser(String email, String password) async {
    String base = "";
    if (Platform.isAndroid) {
      base = "http://10.0.2.2:8000/";
    } else {
      base = "http://127.0.0.1:8000/";
    }
    String url = base + "users/";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var param = {
      "email": email,
      "password": password,
    };
    http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(param));
    if (response.statusCode == 200) {
      getUser();
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

    String? email;
    String? password;

    String? id;
    String? title;
    String? description;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users")
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Index",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 28),
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
                if (_usersData != null)
                  for (var userData in _usersData!)
                    TableRow(
                      children: <Widget> [
                        Text(userData["id"].toString(), style: const TextStyle(fontSize: 20),),
                        Text(userData["email"], style: const TextStyle(fontSize: 20),),
                        Text(userData["is_active"].toString(), style: const TextStyle(fontSize: 20),),
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
                if (_usersData != null)
                  for (var userData in _usersData!)
                    for (var itemData in userData["items"])
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
                "post users",
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
                          labelText: "email",
                          hintText: "reimu@example.com"
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "password",
                        hintText: "reimu",
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  TextButton(
                    child: const Text("送信"),
                    onPressed: () {
                      if (email != null && password != null) {
                        postUser(email!, password!);
                      }
                    },
                  ),
                ],
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
                        labelText: "user_id",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        id = value;
                      },
                    ),
                  ),
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
                      if (id != null && title != null && description != null) {
                        postItem(id!, title!, description!);
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