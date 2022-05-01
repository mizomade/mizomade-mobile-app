import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mizomade/screens/pages/MainPage.dart';
import 'package:mizomade/screens/pages/Tabs/Home.dart';
import 'package:mizomade/utils/Network.dart';

class CreateAddMeta extends StatefulWidget {
  // const CreateAddMeta({Key key}) : super(key: key);


  @override
  State<CreateAddMeta> createState() => _CreateAddMetaState();
  // String contents;
  String id;

  CreateAddMeta({ this.id});
}


class _CreateAddMetaState extends State<CreateAddMeta> {
  TextEditingController _title = TextEditingController();

  TextEditingController _tags = TextEditingController();

  // TextEditingController _coverphotoLink = TextEditingController();
  String categorydropdownValue = 'Eisiam';


  File coverPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black38,
        backgroundColor: Colors.white,
        title: Text("Finalize Post"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: TextFormField(
                controller: _title,

                decoration: InputDecoration(
                    focusColor: Colors.white,
                    fillColor: Colors.grey.shade200,
                    // labelText: "Title",
                    label: Text("Title"),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                   ),

              ),
            ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
       child:     Text("Category:"),
      ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200
              ),
              child: DropdownButton<String>(
                value: categorydropdownValue,
                hint: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Select Category")),

                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 0,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    categorydropdownValue = newValue;
                  });
                },
                items: <String>['Eisiam', 'Infiamna', 'Gospel', 'Zirna']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(

                    value: value,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(value)),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: TextFormField(
                controller: _tags,

                decoration: InputDecoration(
                  focusColor: Colors.white,
                  fillColor: Colors.grey.shade200,
                  // labelText: "Title",
                  label: Text("Tags (separated by commas ) "),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),

              ),
            ),


            Container(
              padding: EdgeInsets.only(bottom: 4),
              child: coverPhoto == null ?Text("No cover photo selected yet!"):
              Image.file(coverPhoto,fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
            ),
            TextButton(onPressed: (){
              _getCoverFromGallery();
            }, child: Text("Update Cover Photo")),
            
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              child: FloatingActionButton(onPressed: (){
                // print("ID" +widget.id+  _title.text + categorydropdownValue.toString() + coverPhoto.path + _tags.text);
                publishPost(widget.id.toString(), _title.text, categorydropdownValue.toString(),coverPhoto.path, _tags.text);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainPage()), (route) => false);
                },
              child: Text("Post"),),
            )

          ],
        ),
      ),
    );



}
  _getCoverFromGallery() async {
  XFile photo;
  final ImagePicker _picker = ImagePicker();
  photo = await _picker.pickImage(
  source: ImageSource.gallery,
  maxWidth: 1800,
  maxHeight: 1800,
  );
  _cropCoverImage(photo.path);
  }
  _cropCoverImage(filePath) async {
    File croppedImage = (await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.black,
          toolbarColor: Colors.white,
          toolbarTitle: "Crop",
          toolbarWidgetColor: Colors.black,
          hideBottomControls: true
      ),
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio7x5
      ],
    ));
    if (croppedImage != null) {
      coverPhoto = croppedImage;
      // updateCoverPhoto(coverPhoto.path);
      setState(() {});
    }
  }

  @override
  void dispose(){
    // coverPhoto.delete();
    super.dispose();
  }
}