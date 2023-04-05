import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled9/Model/DatabaseHelper.dart';
import 'package:untitled9/Screens/FavoriteList.dart';
import 'package:untitled9/Model/Receipt.dart';
import 'package:untitled9/Services/EdamamApiService.dart';
import 'package:share_plus/share_plus.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}TextEditingController textEditingController=TextEditingController();
class _SearchScreenState extends State<SearchScreen> {
TextEditingController textEditingController=TextEditingController();
EdamamApiService edamamApi=EdamamApiService();
  List<dynamic> recipes = [];

static List<String> searchQueries = ['pasta', 'chicken', 'soup', 'vegan', 'dessert','meat','fish','cake','kofte','egg','cheese','salad','tomato','burger','pizza','patato'];




  Future<void> fetchRecipes() async {
    final response = await http.get(Uri.parse(edamamApi.url));
    final json = jsonDecode(response.body);
    setState(() {
      recipes = json['hits'].map((hit) => hit['recipe']).toList();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRecipes();
  }
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/recipeApi.png"),fit: BoxFit.cover)),
          child: Scaffold(backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(cursorColor: Colors.white,
                      onChanged: (value)async{
                    await fetchRecipes();
                    setState(() {
                      edamamApi.query=value;
                    });

                  },  decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15.0)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(15.0)),
                      label: Row(
                        children: [
                          Text(' Tap to here for search  recipes', style: TextStyle(color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.search,color: Colors.white),
                          ),
                        ],
                      ),
                      suffix: IconButton(onPressed: () async{
                    setState(() {
                      edamamApi.query=textEditingController.text;
                    });
                    await fetchRecipes();
                    textEditingController.clear();
                    },
                    icon: Icon(Icons.search,
                        color: Colors.white
                    ),
                  )
                  ),controller: textEditingController,style: TextStyle(color: Colors.white)),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    OutlinedButton(onPressed: (){
                      setState(() {
                        int randomIndex = Random().nextInt(searchQueries.length);
                        edamamApi.query = searchQueries[randomIndex];
                        fetchRecipes();
                      });

                    }, child: Text("Random Recipe")),
                   Icon(Icons.fastfood_rounded,color: Colors.deepOrange,size: 45),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(height: MediaQuery.of(context).size.height*0.6,
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        List<Color> buttonColors = List.filled(recipes.length, Colors.indigo);
                        final recipe = recipes[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTile(
                             subtitle: Text(recipe['calories'].toString().substring(0,7)+" kcal ",
                                 style: TextStyle(color: Colors.blue)),
                            title: Text(recipe['label'].toString(),style: titleApiCardStyle),children: [
                             Card(color: Colors.white70,  child: Column(
                                children: [
                                  ListTile(
                                    trailing:IconButton(onPressed: () async{
                                      await Provider.of<DatabaseHelper3>
                                        (context, listen: false).add(
                                          Receipt(
                                          Name: recipe['label'],
                                          ingredients: recipe['ingredientLines'].toString(),
                                          urlImage: recipe['image'].toString()
                                          ));
                                     setState(() {
                                        buttonColors[index]=Colors.pink;
                                      });
                                    }, icon: Icon(Icons.add,color:buttonColors[index]),)
                                    ,title: Text(recipe['label']),
                                     subtitle: Text(recipe['source']),

                                  ),
Column(
  children: [


                          Image.network(recipe['image']),
    Text("Ingredients",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                          ListView.builder(
                          shrinkWrap: true,
                          itemCount: recipe['ingredientLines'].length,
                          itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(' - ' + recipe['ingredientLines'][index],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          );
                          },
                          ),

    Text('Insructions',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(alignment: Alignment.bottomRight,
        child: IconButton(onPressed: ()async{
          await Share.share('${recipe['label']}\n${recipe['ingredientLines'].toString().replaceAll('[', '   ').toString().replaceAll(']', '')}');
        }, icon: Icon(Icons.share,color: Colors.indigo,size: 35,)
        ),
      ),
    )
  ],
),
                                ],
                              ),
                            ),
                          ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 8,top: 3),
                  child: Align(alignment: Alignment.bottomLeft,
                    child: FractionallySizedBox(
                      widthFactor: 0.3,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => FavoriteList()));
                          textEditingController.clear();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: BorderSide(width: 3.0,color: Colors.indigo)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.favorite, color: Colors.red, size: 35),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text("See your favorites", style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      )

                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      );
    }
  }
  TextStyle titleApiCardStyle=TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white);