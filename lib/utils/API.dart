import 'package:intl/intl.dart';

const String S3_Host = "https://mizomade-media-buckets.s3.ap-south-1.amazonaws.com/";
//
const String API_URL="http://192.168.43.242:8000/api/";
const String API_MEDIA_URL="http://192.168.43.242:8000/media/";
const String HOST_URL="http://192.168.43.242:8000";

// //
// const String API_URL="http://192.168.1.11:8000/api/";
// const String API_MEDIA_URL="http://192.168.1.11:8000/media/";
// const String HOST_URL="http://192.168.1.11:8000";


// const String API_URL="http://192.168.0.14:8000/api/";
// const String API_MEDIA_URL="http://192.168.0.14:8000/media/";
// const String HOST_URL="http://192.168.0.14:8000";

String dateFormat(String date){
  String dateFormatted = DateFormat("dd MMM yyyy").format(DateTime.parse(date));
  return dateFormatted;
}



