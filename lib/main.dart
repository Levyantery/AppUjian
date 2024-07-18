import 'package:app_ujian/model/theme.dart';
import 'package:app_ujian/ui/izin_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Ujian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBiruMuda,
        title: const Text(
          'WELCOME',
          style: TextStyle(
            color: kPutih,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset('assets/bendera.jpg', height: 40, width: 100),
          ),
        ],
      ),
      body: Container(
        height: 2000,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kPutih,
              kPutih,
              kBiruMuda,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IzinApp(),
            ]
          ),
        ),
      )
    );
  }
}

class LockedScaffold extends StatelessWidget {
  final Widget child;

  const LockedScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: child,
      ),
    );
  }
}