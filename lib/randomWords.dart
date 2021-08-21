import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final randWp = <WordPair>[];
  final savedWP = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, item) {
        if (item.isOdd) {
          return Divider();
        } else {
          final index = item;
          if (index >= randWp.length) {
            randWp.addAll(generateWordPairs().take(10));
          }
          return buildRow(randWp[index]);
        }
      },
    );
  }

  Widget buildRow(WordPair wp) {
    final alreadySaved = savedWP.contains(wp);
    return ListTile(
      title: Text(wp.asPascalCase),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_outline,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            savedWP.remove(wp);
          } else {
            savedWP.add(wp);
          }
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = savedWP.map((item) {
        return ListTile(
            title: Text(
          item.asPascalCase,
        ));
      });
      final List<Widget> divider =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text("saved words"),
        ),
        body: ListView(
          children: divider,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("word generator"),
        actions: [IconButton(onPressed: pushSaved, icon: Icon(Icons.list))],
      ),
      body: _buildList(),
    );
  }
}
