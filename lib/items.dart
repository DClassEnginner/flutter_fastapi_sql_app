import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key, this.skip = "0", this.limit = "100"}) : super(key: key);
  final String skip;
  final String limit;

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {

  List? _itemsData;

  Future getUser() async {
    String base = "";
    if (Platform.isAndroid) {
      base = "http://10.0.2.2:8000/";
    } else {
      base = "http://127.0.0.1:8000/";
    }
    http.Response response = await http.get(Uri.parse(base + "items/?skip=" + widget.skip + "&limit=" + widget.limit));
    if (response.statusCode == 200) {
        setState(() {
        _itemsData = jsonDecode(response.body);
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

    String? id;
    String? title;
    String? description;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Items")
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                if (_itemsData != null)
                  for (var itemData in _itemsData!)
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