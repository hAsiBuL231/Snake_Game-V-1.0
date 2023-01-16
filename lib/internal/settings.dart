import 'package:flutter/material.dart';
import 'globals.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double level = 6 - (gLevel / 50);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    gColumn += 2;
                    setState(() {});
                  },
                  child: Text(
                      "Increase Grid Column Number\nColumn Num:$gColumn",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    gColumn -= 2;
                    setState(() {});
                  },
                  child: Text(
                      "Decrease Grid Column Number\nColumn Num:$gColumn",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    gLevel -= 50;
                    setState(() => level = 6 - (gLevel / 50));
                  },
                  child: Text("Increase Game Level\nLevel:$level",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    gLevel += 50;
                    setState(() => level = 6 - (gLevel / 50));
                  },
                  child: Text("Decrease Game Level\nLevel:$level",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    if (gBox == 'Closed') {
                      gBox = 'Opened';
                    } else {
                      gBox = 'Closed';
                    }
                    setState(() {});
                  },
                  child: Text("Change Game Mode\nCurrent Mode: $gBox Box",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.indigoAccent,
    );
  }
}
