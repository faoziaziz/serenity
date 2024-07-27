//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
//import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addvideo extends StatefulWidget {
  const Addvideo({super.key});

  @override
  State<Addvideo> createState() => _AddvideoState();
}

class _AddvideoState extends State<Addvideo> {
  /* text controller */
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  /* add video */
  Future<void> _addVideo({
    required String category,
    required String title,
    required String desc,
    required String url,
    required String user
  }) async {
    return FirebaseFirestore.instance
        .collection("videos")
        .add({
          'category': category,
          'description': desc,
          'title': title,
          'url': url,
          'users': user
        })
        .then((value) => print("video Added"))
        .catchError((onError) => print("faild add audio : ${onError}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambahkan Video"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: "Judul Video"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _descController,
                decoration:
                    const InputDecoration(hintText: "Description Video"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _categoryController,
                decoration: const InputDecoration(hintText: "Category"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(hintText: "Url"),
              ),
            ),
            ElevatedButton(onPressed: () {
              _addVideo(category: _categoryController.text, title: _titleController.text, desc: _descController.text, url: _urlController.text, user: "diamonrose144@gmail.com");
            }, child: Text("Tambahkan Video")),
          ],
        ),
      ),
    );
  }
}
