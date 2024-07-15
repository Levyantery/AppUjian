import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LockedScaffold extends StatefulWidget {
  final Widget child;

  const LockedScaffold({Key? key, required this.child}) : super(key: key);

  @override
  _LockedScaffoldState createState() => _LockedScaffoldState();
}

class _LockedScaffoldState extends State<LockedScaffold> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lockApp();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _lockApp();
    }
  }

  void _lockApp() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: widget.child,
    );
  }
}