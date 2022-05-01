import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:mizomade/screens/Action/CreatePost/CreateAddMeta.dart';
import 'package:mizomade/utils/CustomUtils.dart';
import 'package:mizomade/utils/Network.dart';
import 'dart:io';

class CreatePost extends StatefulWidget {
  const CreatePost({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  QuillController _controller = QuillController.basic();
  TextEditingController texts = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.

    Future<bool> _drafting() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Save as draft before exit?',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              // content Text('Do you want to exit the App'),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                ElevatedButton(

                  style: ElevatedButton.styleFrom(primary: Colors.grey.shade100,
                  elevation: 0,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("No, don't save",style: TextStyle(color: Colors.black38),),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.purple.shade400,elevation: 0),
                  onPressed: () async {
                    texts.text =
                        _controller.document.toDelta().toJson().toString();
                    var json = _controller.document.toDelta().toJson();
                    var draft = await createPost(json.toString());
                    print(draft);
                    CustomUtils.infoSnackBar(context, "Saved on Drafts!");
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes! Save'),
                ),
              ],
            ),
          )) ??
          false;
    }

    var toolbar = QuillToolbar.basic(
      controller: _controller,
      // provide a callback to enable picking images from device.
      // if omit, "image" button only allows adding images from url.
      // same goes for videos.
      onImagePickCallback: _onImagePickCallback,


      // uncomment to provide a custom "pick from" dialog.
      // mediaPickSettingSelector: _selectMediaPickSetting,
      multiRowsDisplay: false,
      showUndo: false,
      showRedo: false,
      showCameraButton: false,
      showColorButton: false,
      showJustifyAlignment: false,
      showBackgroundColorButton: false,
      showStrikeThrough: false,
      showClearFormat: false,
      showIndent: false,
      showListCheck: false,
      showHeaderStyle: true,
    );
    return WillPopScope(
        onWillPop: () => _drafting(),
        child: Scaffold(
          body: Hero(
            tag: 'create',
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 40,
                  ),
                  Container(
                    child: toolbar,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      // padding: EdgeInsets.only(bottom: 20),
                      child: QuillEditor.basic(
                        controller: _controller,
                        readOnly: false,

                        // true for view only mode
                      ),
                    ),
                  ),
                  // Container(height: 40,child: Text(texts.text)),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              texts.text = _controller.document.toDelta().toJson().toString();
              var json = jsonEncode(_controller.document.toDelta().toJson());
              var draft = await createPost(json.toString());
              print(draft.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateAddMeta(
                            id: draft.toString(),
                          )));
            },
            isExtended: true,
            label: Text("Post"),
          ),
        ));
  }

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final fileUrl = await imageUpload(file.path);
    // final appDocDir = await getApplicationDocumentsDirectory();
    // final copiedFile =
        // await file.copy('${appDocDir.path}/${basename(file.path)}');
    // return copiedFile.path.toString();
    print("FILEURL" + fileUrl.toString());
    return fileUrl.toString();
  }
}
