import 'package:flutter/material.dart';
import 'package:mizomade/screens/pages/Comment/CommentList.dart';
import 'package:mizomade/utils/CustomUtils.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDialogue extends StatefulWidget {
  // const CreateDialogue({Key key}) : super(key: key);
  String id;
  String comment_id;
  String username;
  String content;
EditDialogue({this.id, this.comment_id,this.username,this.content});
  @override
  _EditDialogueState createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {

  String profilephoto ;

  void getuservalues()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      comment.text = widget.content.toString();

      profilephoto = prefs.getString('profilephoto');
    });

  }


TextEditingController comment = TextEditingController();

@override
void initState(){
  super.initState();
  getuservalues();

}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 90),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),

                Text('Comment',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ListTile(
                  title: Text(widget.username.toString()),
                  leading: CircleAvatar(

                    child: ClipOval(
                      child: Image.network(profilephoto,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: comment,

                    maxLines: null,
                    decoration: InputDecoration(
labelText: "Enter comment.."
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade200,
                            elevation: 0,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel',style: TextStyle(color: Colors.black38),),
                        ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple.shade600,
                        elevation: 0,
                      ),
                          onPressed: () async{

                         bool result = await editComment(widget.comment_id, comment.text);
                         if(result == true){
                           CustomUtils.infoSnackBar(context, "Commented!");
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
                          child: Text('Send'),
                        ),
                  ],
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),

          // actions: [
          //   FlatButton(
          //     textColor: Color(0xFF6200EE),
          //     onPressed: () => Navigator.pop(context),
          //     child: Text('CANCEL'),
          //   ),
          //   FlatButton(
          //     textColor: Color(0xFF6200EE),
          //     onPressed: () => Navigator.pop(context),
          //     child: Text('YES'),
          //   ),
          // ],
        ),
      ),
    );
  }
}
