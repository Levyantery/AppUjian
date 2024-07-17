import 'package:app_ujian/lock_task_manager.dart';
import 'package:app_ujian/main.dart';
import 'package:app_ujian/model/theme.dart';
import 'package:app_ujian/url_input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IzinApp extends StatelessWidget {
  const IzinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
            width: double.infinity, // Mengatur lebar sesuai dengan parent widget
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Membuat widget berada di tengah
                children: [
                  Text(
                    'Penyematan',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10), // Memberikan jarak vertikal antara judul dan kata-kata
                  Text(
                    'Aplikasi yang terkunci atau disematkan adalah aplikasi yang dipilih untuk tetap berada di layar utama perangkat, baik itu ponsel pintar, tablet, atau komputer, dan tidak dapat ditutup atau diminimalkan dengan mudah. Fungsi ini umumnya dirancang untuk memberikan akses cepat dan mudah ke aplikasi tertentu yang dianggap penting atau sering digunakan oleh pengguna. Selain itu, aplikasi yang disematkan dapat menghindari gangguan dari notifikasi atau aplikasi lain yang berjalan di latar belakang.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Container( // Add a Container widget to wrap the text in a blue background
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:kBiruMuda,
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
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Perizinan'),
                    content: const Text('Tekan allow jika anda mengizinkan aplikasi untuk disematkan'),
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
                            // ignore: use_build_context_synchronously
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
      )
    );
  }
}