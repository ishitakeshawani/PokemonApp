import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/pokedetail.dart';
import 'package:pokemonapp/pokemon.dart';

void main() => runApp(
  MaterialApp(
    title: "pokemon app",
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";
  Pokehub pokehub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async{
    var res = await http.get(url);
    var decodevalue = jsonDecode(res.body);

    pokehub = Pokehub.fromJson(decodevalue);
    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Pokemon App'
        ),
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(),
      body: pokehub == null ? Center(child: CircularProgressIndicator(),) : GridView.count(
        crossAxisCount: 2,
          children: pokehub.pokemon.map((Pokemon poke) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => PokeDetail(
                  pokemon: poke,
                )));
              },
              child: Card(
           // elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: poke.img,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(poke.img)
                          )
                        ),
                      ),
                    ),
                    Text(poke.name,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
            ),
          )).toList(),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Colors.cyan,
        onPressed: (){
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
