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
          primarySwatch: Colors.blue,
        ),
        home: const RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final List suggestions = [];
    final saved = <dynamic>{};
    const TextStyle biggerFont = TextStyle(fontSize: 16);

    Widget buildSuggestions() {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return const Divider();
          }

          final int index = i ~/ 2;

          if (index >= suggestions.length) {
            suggestions.addAll(generateWordPairs().take(10));
          }

          Widget buildRow(WordPair pair) {
            final alreadySaved = saved.contains(pair);

            return ListTile(
              title: Text(
                "${pair.asPascalCase} - ${i.toString()} - ${index.toString()}",
                style: biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    saved.remove(pair);
                  } else {
                    saved.add(pair);
                  }
                });
              },
            );
          }

          return buildRow(suggestions[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: buildSuggestions(),
    );
  }
}
