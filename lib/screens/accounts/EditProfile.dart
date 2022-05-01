import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mizomade/utils/API.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _username = TextEditingController();
  TextEditingController _first_name = TextEditingController();
  TextEditingController _last_name = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _coverphotoLink = TextEditingController();
  TextEditingController _profilephotoLink = TextEditingController();

  bool usernamevalid = true;
  File profilePhoto;
  File coverPhoto;

  void initFetch() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      _username.text = prefs.getString('username').toString();
      _first_name.text = prefs.getString('first_name');
      _last_name.text = prefs.getString('last_name');

      _bio.text = prefs.getString('bio');
      _coverphotoLink.text = prefs.getString('coverphoto');
      _profilephotoLink.text = prefs.getString('profilephoto');
    });
  }

  @override
  void initState() {
    super.initState();
    initFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 2,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                    child: profilePhoto == null
                        ? Image.network(
                            _profilephotoLink.text,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            profilePhoto,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )),
                backgroundColor: Colors.transparent,
              ),
              TextButton(
                  onPressed: () {
                    _getProfileFromGallery();
                  },
                  child: Text("Update Profile Photo")),
              SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: usernamevalid,
                  child: Text("Choose another username")),
              TextFormField(
                controller: _username,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.alternate_email_outlined,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          // color: usernamevalid == true ? Colors.green : Colors.red,
                          )),
                  labelText: "Username",
                ),
                onChanged: (value) async {
                  bool result = await checkUsername(_username.text);
                  print("RESULT" + result.toString());
                  if (result) {
                    print("TRUEEEE");
                    setState(() {
                      usernamevalid = true;
                    });
                  } else
                    print("FALSEESE");
                  setState(() {
                    usernamevalid = false;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _first_name,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.person_outlined,
                  ),
                  border: OutlineInputBorder(),
                  labelText: "First Name",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _last_name,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.person_outlined,
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Lastname",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _bio,
                maxLines: 3,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.format_quote_outlined,
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Bio",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 4),
                child: coverPhoto == null
                    ? Image.network(_coverphotoLink.text)
                    : Image.file(
                        coverPhoto,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      ),
              ),
              TextButton(
                  onPressed: () {
                    _getCoverFromGallery();
                  },
                  child: Text("Update Cover Photo")),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        updateProfile(_username.text, _first_name.text,
                            _last_name.text, _bio.text);
                      },
                      child: Text("Save")))
            ],
          ),
        ),
      ),
    );
  }

  _getProfileFromGallery() async {
    XFile photo;
    final ImagePicker _picker = ImagePicker();
    photo = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropProfileImage(photo.path);
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

  /// Crop Image
  _cropProfileImage(filePath) async {
    File croppedImage = (await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.black,
          toolbarColor: Colors.white,
          toolbarTitle: "Crop",
          toolbarWidgetColor: Colors.black,
          hideBottomControls: true),
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    ));
    if (croppedImage != null) {
      profilePhoto = croppedImage;
      updateProfilephoto(profilePhoto.path);
      setState(() {});
    }
  }

  _cropCoverImage(filePath) async {
    File croppedImage = (await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.black,
          toolbarColor: Colors.white,
          toolbarTitle: "Crop",
          toolbarWidgetColor: Colors.black,
          hideBottomControls: true),
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatioPresets: [CropAspectRatioPreset.ratio7x5],
    ));
    if (croppedImage != null) {
      coverPhoto = croppedImage;
      updateCoverPhoto(coverPhoto.path);
      setState(() {});
    }
  }
}
