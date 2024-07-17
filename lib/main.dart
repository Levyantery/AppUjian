import 'package:flutter/material.dart';
import 'package:app_ujian/url_input_page.dart';
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
        title: const Text('MASUK',
        style : TextStyle (color: Colors.red),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset('assets/browser.png', height: 50),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 255, 250, 250), Color.fromARGB(255, 51, 232, 121)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'WELCOME TO MY APP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 222, 39, 39),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('CEK'),
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.blue, 
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Perizinan'),
                        content: const Text( 'Tekan allow jika anda mengizinkan aplikasi'),
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
            ],
          ),
        ),
      ),
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