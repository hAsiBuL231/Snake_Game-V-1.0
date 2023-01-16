import 'package:SnakeHost/internal/info.dart';
import 'package:SnakeHost/internal/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Func extends StatefulWidget {
  const Func({Key? key}) : super(key: key);

  @override
  State<Func> createState() => _FuncState();
}

class _FuncState extends State<Func> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            color: Colors.lightBlue,
            height: 100,
            child: const Text(
              "Welcome to Drawer",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Flexible(
            child: ListView(children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.info_outline),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const InfoPage();
                    }));
                  },
                  title: const Text("Info")), // Drawer : Info
              const ListTile(
                  leading: Icon(Icons.leaderboard),
                  title:
                      TextButton(onPressed: null, child: Text("Leaderboard"))),
              const ListTile(
                  leading: Icon(Icons.help_outline),
                  title: TextButton(
                      onPressed: null,
                      child:
                          Text("Help & Support"))), // Drawer : help & support
              const ListTile(
                  leading: Icon(Icons.feedback_outlined),
                  title: TextButton(
                      onPressed: null,
                      child: Text("Feedback"))), // Drawer : feedback
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const SettingPage();
                  }));
                },
              ), // Drawer : settings
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Exit'),
                onTap: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
