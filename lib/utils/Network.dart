import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'API.dart';
import 'package:shared_preferences/shared_preferences.dart';


var storage = FlutterSecureStorage();

Future<bool> register1(String username, String password,String phone) async {
  print("STARTING Registration 1 ATTEMPT");
  var response = await http.post(Uri.parse(HOST_URL + '/api/user/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password1': password,'phone':phone,'email':''}));
  if (response.statusCode == 200) {
    var vals = jsonDecode(response.body);

    print("VALS" + vals.toString());
    storage.write(key: 'username', value: vals['username'].toString());
    storage.write(key: 'session', value: vals['status'].toString());

    String uname = await storage.read(key: 'username');
    String sess =  await storage.read(key: 'session');
    print(uname.toString() + sess.toString());

    // return vals['key'].toString();
    return Future<bool>.value(true);
  } else
  {
    return Future<bool>.value(false);

  }

}


Future<bool> otpVerification(String otp) async {

  String username = await storage.read(key: 'username');
  String session =  await storage.read(key: 'session');
  print("STARTING OTP VERIFICATION ATTEMPT");
  var response = await http.post(Uri.parse(HOST_URL + '/api/user/otpverification/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'otp': otp,'session':session}));
  if (response.statusCode == 200) {
    var vals = jsonDecode(response.body);

    print("VALS" + vals.toString());
    // storage.write(key: 'username', value: vals['username'].toString());
    // storage.write(key: 'session', value: vals['status'].toString());
    //
    // String uname = await storage.read(key: 'username');
    // String sess =  await storage.read(key: 'session');
    // print(uname.toString() + sess.toString());

    // return vals['key'].toString();
    return Future<bool>.value(true);
  } else
  {
    return Future<bool>.value(false);

  }

}

Future<bool> attemptLogin(String username, String password) async {
  print("STARTING LOGIN ATTEMPT");
  var response = await http.post(Uri.parse(HOST_URL + '/dj-rest-auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}));
  if (response.statusCode == 200) {
    var vals = jsonDecode(response.body);

    print("VALS" + vals.toString());
    storage.write(key: 'username', value: username);

    storage.write(key: 'skey', value: vals['key']);
    // return vals['key'].toString();
    return Future<bool>.value(true);
  } else
    {
      return Future<bool>.value(false);

    }

}

Future getMyProfile() async {
  final prefs = await SharedPreferences.getInstance();
  print("STARTING get Profile ATTEMPT");
  String key = await storage.read(key: 'skey');
  print("KEY" + key.toString());
  var response = await http.post(
    Uri.parse(HOST_URL + '/api/user/getmyprofile/'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $key'
    },
  );
  if (response.statusCode == 200) {
    var vals = jsonDecode(response.body);
    print(vals);
    String id = vals[0]['id'].toString();
    storage.write(key: 'user_id', value: id);

    // if(prefs.getString('username') == null) {
    
    prefs.setString('username', vals[0]['username'].toString());
    prefs.setString('first_name', vals[0]['first_name'].toString());
    prefs.setString('last_name', vals[0]['last_name'].toString());
    prefs.setString('bio', vals[1]['bio'].toString());
    prefs.setString('coverphoto', vals[1]['coverphoto'].toString());
    prefs.setString('profilephoto', vals[1]['profilephoto'].toString());
    // print("USERNAME:" + prefs.getString('username').toString());
    // print(prefs.getString('coverphoto'));
    // }
    // else
    //   print("Already exist");

    // storage.write(key: 'skey', value: vals['key']);
    return vals;
  } else
    return "";
}

Future updateProfilephoto(String filename) async {
  String id = await storage.read(key: 'user_id');
  final prefs = await SharedPreferences.getInstance();
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };
  print("STORAGE" +storage.read(key: 'user_id').toString());
  var request = http.MultipartRequest(
      'PUT', Uri.parse(HOST_URL + '/api/user/profile/update/profilephoto/' + id));
  request.fields['username'] = prefs.getString('username');
  request.headers.addAll(headers);
  print(request.headers);
  print(filename);
  request.files
      .add(await http.MultipartFile.fromPath('profilephoto', filename));

  var res = await request.send();
  if (res.statusCode == 500) {
    getMyProfile();
    print("RESPONSE" + res.statusCode.toString());
  }
}

Future updateCoverPhoto(String filename) async {
  String id = await storage.read(key: 'user_id');
  final prefs = await SharedPreferences.getInstance();
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };
  print("STORAGE" + storage.read(key: 'user_id').toString());
  var request = http.MultipartRequest(
      'PUT', Uri.parse(HOST_URL + '/api/user/profile/update/coverphoto/' + id));
  request.fields['username'] = prefs.getString('username');
  request.headers.addAll(headers);
  print(request.headers);
  print(filename);
  request.files.add(await http.MultipartFile.fromPath('coverphoto', filename));

  var res = await request.send();
  if (res.statusCode == 500) {
    getMyProfile();
    print("RESPONSE" + res.statusCode.toString());
  }
}

Future<bool> checkUsername(String username) async {
  // final prefs = await SharedPreferences.getInstance();
  print("STARTING Username Change ATTEMPT");
  String key = await storage.read(key: 'skey');

  var response = await http.get(
    Uri.parse(HOST_URL + '/api/user/profile/usernamevalidation/' + username),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $key'
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    var vals = jsonDecode(response.body);
    print("VALUES" + vals.toString());
    // if(prefs.getString('username') == null) {
    // prefs.setString('username', vals[0]['username'].toString());

    // }
    // else
    //   print("Already exist");

    // storage.write(key: 'skey', value: vals['key']);
    if (vals[0] == 1) {
      print(vals[0]);
      return Future<bool>.value(true);
    } else
      return Future<bool>.value(false);
  } else
    return Future<bool>.value(false);
}

Future updateProfile(
    String username, String firstName, String lastName, String bio) async {
  String id = await storage.read(key: 'user_id');
  // final prefs = await SharedPreferences.getInstance();
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  Map<String, String> body = {
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "bio": bio
  };

  print("STORAGE" +  storage.read(key: 'user_id').toString());
  var res = await http.put(Uri.parse(HOST_URL + '/api/user/profile/update/' + id),
      headers: headers, body: jsonEncode(body));

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else
    return "";
}


Future fetchPostDetail(String slug) async {
  var response = await http.get(Uri.parse(API_URL + 'posts/' + slug));
  print("RESPONES" + json.decode(response.body).toString());

  if (response.statusCode == 200) {

    print("True");
    // tags = jsonDecode(response.body)['post']['tags'];
    return jsonDecode(response.body);
  } else {
    print("Error");
  }
}

Future<String> like(String id) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/posts/like/' + id.toString()),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("LIKED or Unliked");
    print(jsonDecode(res.body)['status'].toString());
    return jsonDecode(res.body)['status'].toString();
  } else
    return "Error";
}

Future checkLikeStatus(String id) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/posts/likeinfo/' + id.toString()),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("LIKE Status");
    print(res.body);
    // print(jsonDecode(res.body)['status'].toString());
    // return jsonDecode(res.body)['status'];
    var likevalue = jsonDecode(res.body);
    if (likevalue['mylike'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }
}

Future<String> bookmark(String id) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/posts/bookmark/' + id.toString()),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("Bookmarked or Removed");
    print(jsonDecode(res.body)['bookmarked'].toString());
    return jsonDecode(res.body)['bookmarked'].toString();
  } else
    return "Error";
}

Future checkBookmarkStatus(String id) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/posts/bookmarkinfo/' + id.toString()),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("Bookmark Status");
    print(res.body);
    // print(jsonDecode(res.body)['status'].toString());
    // return jsonDecode(res.body)['status'];
    var bookmarkvalue = jsonDecode(res.body);
    if (bookmarkvalue['bookmarked'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }
}

Future bookmarkList() async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/bookmarkedlist/' ),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("SAVED" + res.body);
    return jsonDecode(res.body);
  }
}


Future categoryList() async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/categories/' ),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("Categories" + res.body);
    return jsonDecode(res.body);
  }
}

Future featuredPosts() async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/posts/featured/' ),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("featured" + res.body);
    return jsonDecode(res.body);
  }
}

Future search(String query) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.post(
    Uri.parse(HOST_URL + '/api/searching/' ),
    headers: headers,
    body: jsonEncode({
      'q':query
    })
  );

  if (res.statusCode == 200) {
    print("Searched" + res.body);
    return jsonDecode(res.body);
  }
}

Future userDetail(String username) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.get(
    Uri.parse(HOST_URL + '/api/user/profile/'+username ),
    headers: headers,
  );

  if (res.statusCode == 200) {
    print("USERDETAILS" + res.body);
    return jsonDecode(res.body);
  }
}



Future tagList(String tag) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.post(
    Uri.parse(HOST_URL + '/api/tags/' ),
    headers: headers,
    body:jsonEncode({
      'name':tag
    })
  );

  if (res.statusCode == 200) {
    print("Tags" + res.body);
    return jsonDecode(res.body);
  }
}


Future createPost(String content ) async {
  // String id = await storage.read(key: 'user_id');
  // final prefs = await SharedPreferences.getInstance();
  // Map<String, String> headers = {
  //   "content-type": "application/json",
  //   "Authorization": "Token " + await storage.read(key: 'skey')
  // };
  // print("STORAGE" + await storage.read(key: 'user_id').toString());
  // var request = http.MultipartRequest(
  //     'PUT', Uri.parse(HOST_URL + '/api/posts/create/'));
  //
  // request.fields['content'] = content;
  // // request.fields['coverimage'] = content;
  //
  // request.headers.addAll(headers);
  // print(request.headers);
  //
  // // request.files.add(await http.MultipartFile.fromPath('coverimage', "test.png"));
  //
  // var res = await request.send();
  // if (res.statusCode == 500) {
  //   // getMyProfile();
  //   print("RESPONSE" + res.statusCode.toString());
  // }

  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };

  var res = await http.post(
      Uri.parse(HOST_URL + '/api/posts/createdraft/' ),
      headers: headers,
      body:jsonEncode({

        'content':content
      })
  );

  if (res.statusCode == 201) {
    print("Content Draft" + res.body);
    return jsonDecode(res.body)['id'];
  }
}

Future fetchDraftDetail(String id) async {
  var response = await http.get(Uri.parse(API_URL + 'drafts/' + id));
  print("RESPONES" + json.decode(response.body).toString());

  if (response.statusCode == 200) {

    print("True");
    // tags = jsonDecode(response.body)['post']['tags'];
    return jsonDecode(response.body);
  } else {
    print("Error");
  }
}



Future publishPost(String ids,String title,String category,String coverimage,String tags ) async {
  print("PUBLISH" + ids.toString() +title.toString() + category.toString() + coverimage.toString() + tags.toString());
  // String id = await storage.read(key: 'user_id');
  // final prefs = await SharedPreferences.getInstance();
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };
  print("STORAGE" +  storage.read(key: 'user_id').toString());
  var request = http.MultipartRequest(
      'PATCH', Uri.parse(HOST_URL + '/api/posts/create/'));
  // request.fields['username'] = prefs.getString('username');

  request.fields['title'] = title;
  request.fields['id'] = ids;
  request.fields['category'] = category;
  request.fields['tags'] = tags;


  request.headers.addAll(headers);
  print(request.headers);
  print(coverimage);
  request.files.add(await http.MultipartFile.fromPath('coverimage', coverimage));

  var res = await request.send();
  if (res.statusCode == 500) {
    getMyProfile();
    print("RESPONSE" + res.statusCode.toString());
  }
}


Future fetchComments(String id) async {
  print("INITILIZING COMMENTS");

  var response = await http.get(Uri.parse(API_URL + 'posts/commentlist/' + id));
  print("response");
  print("RESPONES" + json.decode(response.body).toString());

  if (response.statusCode == 200) {

    print("True");
    return jsonDecode(response.body);
  } else {
    print("Error");
  }
}


Future<bool> addComments(String id,String comment) async {
  print("INITILIZING COMMENTS");
  String key = await storage.read(key: 'skey');

  var response = await http.post(Uri.parse(API_URL + 'posts/commentlist/' + id),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $key'
    },
    body: jsonEncode({'comment':comment})
  );
  print("response");

  if (response.statusCode == 200) {

    print("True");
    return Future<bool>.value(true);
  } else {
    print("Error");
    return Future<bool>.value(false);
  }
}

Future<bool> editComment(String id,String comment) async {
  print("INITILIZING COMMENTS");
  String key = await storage.read(key: 'skey');

  var response = await http.put(Uri.parse(API_URL + 'posts/commentdetail/' + id),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $key'
      },
      body: jsonEncode({'comment':comment})
  );
  print("response");

  if (response.statusCode == 200) {

    print("True");
    return Future<bool>.value(true);
  } else {
    print("Error");
    return Future<bool>.value(false);
  }
}

Future<bool> deleteComment(String id) async {
  print("INITILIZING COMMENTS");
  String key = await storage.read(key: 'skey');

  var response = await http.delete(Uri.parse(API_URL + 'posts/commentdetail/' + id),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $key'
      },

  );
  print("response");

  if (response.statusCode == 200) {

    print("True");
    return Future<bool>.value(true);
  } else {
    print("Error");
    return Future<bool>.value(false);
  }
}


Future imageUpload(String filename) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "Authorization": "Token " + await storage.read(key: 'skey')
  };
  print("STORAGE" +  storage.read(key: 'user_id').toString());
  var request = http.MultipartRequest(
      'POST', Uri.parse(HOST_URL + '/api/posts/imageupload/'));
  // request.fields['username'] = prefs.getString('username');
  request.headers.addAll(headers);
  print(request.headers);
  print(filename);
  request.files.add(await http.MultipartFile.fromPath('image', filename));

  var res = await request.send();
  if (res.statusCode == 200) {
    print("RESPONSE" + res.statusCode.toString() + res.reasonPhrase.toString());
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    print(result['image']);
    return result['image'];


  }
}