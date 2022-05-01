import 'package:flutter/material.dart';

class CreateComment extends StatefulWidget {
  const CreateComment({Key key}) : super(key: key);

  @override
  _CreateCommentState createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(children: [
        ListTile(
          title: Text("Hmangaiha"),
          leading: Icon(Icons.account_circle_outlined),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(labelText: "Enter your comment ... "),
          ),
        ),
      ]),
    );
  }
}
