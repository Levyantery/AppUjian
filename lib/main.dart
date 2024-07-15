import 'package:flutter/material.dart';
import 'package:app_ujian/url_input_page.dart';
import 'package:app_ujian/locked_scaffold.dart';
import 'package:app_ujian/lock_task_manager.dart';
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
        title: const Text('MASUK'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: ElevatedButton(
            child: const Text('CEK'),
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Perizinan'),
                    content: const Text('Apakah Anda mengizinkan aplikasi ini?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Decline'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          SystemNavigator.pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Allow'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await LockTaskManager.startLockTask();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LockedScaffold(
                                child: UrlInputPage(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}