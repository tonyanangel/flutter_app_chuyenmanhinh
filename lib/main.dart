import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(title: 'Diary', home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final words = <WordPair>[];
  final Set<WordPair> saved = new Set<WordPair>();
  final A = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: pushSaved)
        ],
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          if (index >= words.length) {
            words.addAll(generateWordPairs().take(10));
          }
          return buildRow(words[index]);
        }),
      ),
//      floatingActionButton: FloatingActionButton(
//        child: IconButton(icon: Icon(Icons.add)),
//        tooltip: ' add',
//        onPressed: null,
//      ),
    );
  }

  Widget buildRow(WordPair wordPair) {
    final bool alreadySaved = saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asCamelCase,
        style: A,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          //thay doi trang thai cua 1 bien
          if (alreadySaved) {
            saved.remove(wordPair);
          } else {
            saved.add(wordPair);
          }
        });
      }, // su kien tuong tac
    );
  }
  void pushSaved(){
   Navigator.of(context).push(
     new MaterialPageRoute(builder: (BuildContext context){
       final Iterable<ListTile> tiles = saved.map((WordPair pair){// map wordpair sang tiles
         return new  ListTile(
           title: new Text(
             pair.asCamelCase,
             style: A,

           ),
         );
       });
       final List<Widget> divided = ListTile.divideTiles(tiles: tiles, context: context).toList();
       return new Scaffold(
         appBar: new AppBar(
           title: const Text("Saved list"),
         ),
         body: new ListView(children:divided,
         )
       );
     })

   );

  }
}
