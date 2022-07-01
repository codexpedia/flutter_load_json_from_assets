import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemons',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  PokemonsState createState() => PokemonsState();
}

class PokemonsState extends State<HomePage> {
  List _pokemons = [];

  // Read content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data/pokemon_names.json');
    final Map<String, dynamic> data = await json.decode(response);
    List pokemons = [];
    data.forEach((final String key, final value) {
      //print("Key: {{$key}} -> value: ${value}");
      pokemons.add(value);
    });

    //print(pokemons);
    setState(() {
      _pokemons = pokemons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Load json data',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Load pokemons'),
              onPressed: readJson,
            ),

            // Display the data loaded from pokemon_names.json
            _pokemons.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _pokemons.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Text(_pokemons[index]["id"].toString()),
                      title: Text(_pokemons[index]["name"]),
                    ),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
