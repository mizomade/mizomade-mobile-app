import 'package:flutter/services.dart';
import 'package:mizomade/utils/States.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mizomade/screens/accounts/Login.dart';
import 'package:mizomade/screens/pages/MainPage.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  return runApp(

        ChangeNotifierProvider<Profile>(
          create: (BuildContext context) =>Profile(),
          child: MyApp(),

        )


  );
}


class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(
    create: (context) => ThemeProvider(),

      builder:(context,_) {
      final themeProvider =Provider.of<ThemeProvider>(context);
        return MaterialApp(
          color: Colors.white,
          title: 'MizoMade',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          // theme: ThemeData(
          //   primarySwatch: Colors.deepPurple,
          // ),
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: MyHomePage(title: 'MizoMade'),
        );
      },
  );

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



Future<bool> _onWillPop() async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: Text('Are you sure you want to exit?' ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
        // content Text('Do you want to exit the App'),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text('No'),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text('Yes'),
      ),
    ],
  ),
  )) ??
  false;
}
var storage = FlutterSecureStorage();

void checkToken() async{
  String key = await storage.read(key: 'skey');
  if(key.length > 10){
    setState(() {
      Provider.of<Profile>(context, listen: false)
          .setAuthenticated = true;
    });
  }
  else{
    setState(() {
      Provider.of<Profile>(context, listen: false)
          .setAuthenticated = false;

    });
  }

}

@override
void initState(){
  super.initState();
  checkToken();


}
@override
  Widget build(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
  return Consumer<Profile>(
    builder: (context,provider,child){
      return WillPopScope(
          onWillPop: ()=> _onWillPop(),
          child: provider.isAuthenticated == false ? LoginPage() : MainPage());
    }

  );

  }
}
