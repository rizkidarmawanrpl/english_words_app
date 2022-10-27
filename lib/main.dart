import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Words',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final suggestions = <WordPair>[];
  final saved       = <WordPair>{};
  final biggerFont  = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title  : const Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: pushSaved,
            icon     : const Icon(Icons.list)
          )
        ],
      ),
      body: ListView.builder(
        padding    : const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final int index = i ~/ 2;

          if (index >= suggestions.length) {
            suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = saved.contains(suggestions[index]);

          return ListTile(
            title: Text(
              "${suggestions[index].asPascalCase} - ${i.toString()} - ${index.toString()}",
              style: biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  saved.remove(suggestions[index]);
                } else {
                  saved.add(suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = saved.map((pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: biggerFont,
          ),
        );
      });

      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(context: context, tiles: tiles).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}
