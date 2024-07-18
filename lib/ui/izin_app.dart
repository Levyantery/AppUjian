import 'package:app_ujian/lock_task_manager.dart';
import 'package:app_ujian/main.dart';
import 'package:app_ujian/model/theme.dart';
import 'package:app_ujian/ui/url_input_page.dart';
import 'package:flutter/material.dart';

class IzinApp extends StatefulWidget {
  const IzinApp({Key? key}) : super(key: key);

  @override
  _IzinAppState createState() => _IzinAppState();
}

class _IzinAppState extends State<IzinApp> {
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PENYEMATAN',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'aplikasi yang terkunci atau disematkan adalah aplikasi yang dipilih untuk tetap berada di layar utama perangkat, baik itu ponsel pintar, tablet, atau komputer, dan tidak dapat ditutup atau diminimalkan dengan mudah. Fungsi ini umumnya dirancang untuk memberikan akses cepat dan mudah ke aplikasi tertentu yang dianggap penting atau sering digunakan oleh pengguna. Selain itu, aplikasi yang disematkan dapat menghindari gangguan dari notifikasi atau aplikasi lain yang berjalan di latar belakang.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kBiruMuda,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'IZIN APLIKASI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(),
          ElevatedButton(
            child: const Text('CEK'),
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.blue,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () async {
              await LockTaskManager.startLockTask();
              setState(() {
                isLocked = true;
              });
            },
          ),
          if (isLocked)
            ElevatedButton(
              child: const Text('LANJUTKAN'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.blue,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LockedScaffold(
                      child: UrlInputPage(),
                    ),
                  ),
                );
                setState(() {
                  isLocked = false;
                });
              },
            ),
        ],
      ),
    );
  }
}