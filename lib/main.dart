import 'package:flutter/material.dart';
import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() async {
  var result = await Process.run('kubectl', ['config','view']);
  var kubeContext = loadYaml(result.stdout)['contexts'];
  print(kubeContext);

  runApp(const Kview());
}


class Kview extends StatelessWidget {
  const Kview({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Kubernetes View',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          const Text('A random idea:'),
          Text(appState.current.asLowerCase),
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
            },
            child: const Text('Next'),
          ),

        ],
      ),
    );
  }
}