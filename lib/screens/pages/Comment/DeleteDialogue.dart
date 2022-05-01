import 'package:flutter/material.dart';
import 'package:mizomade/utils/Network.dart';

import '../../../utils/CustomUtils.dart';
import 'CommentList.dart';

class DeleteDialogue extends StatefulWidget {
  // const DeleteDialogue({Key key}) : super(key: key);
  String comment_id;
String id;
DeleteDialogue({this.comment_id,this.id});
  @override
  _DeleteDialogueState createState() => _DeleteDialogueState();
}

class _DeleteDialogueState extends State<DeleteDialogue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Delete comment?'),
        content: Text('Are you sure you want to delete your comment?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.grey.shade200,
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',style: TextStyle(color: Colors.black38),),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.deepPurple.shade600,
              elevation: 0,
            ),
            onPressed: () async{

              bool result = await deleteComment(widget.comment_id.toString());
              if(result == true){
                CustomUtils.infoSnackBar(context, "Comment Deleted!");
                Navigator.pop(context);
                showModalBottomSheet(context: context,
                    isScrollControlled: true,
                    builder: (context) => CommentList(id: widget.id,));

              }
              // Navigator.pop(context);
              // showModalBottomSheet(context: context,
              //     isScrollControlled: true,
              //     builder: (context) => CommentList());


            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
