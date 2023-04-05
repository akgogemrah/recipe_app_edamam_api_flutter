import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled9/Screens/SearchScreen.dart';
import '../Model/DatabaseHelper.dart';
import '../Model/Receipt.dart';
class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);
  @override
  State<FavoriteList> createState() => _FavoriteListState();
}
class _FavoriteListState extends State<FavoriteList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: Icon(Icons.favorite,color: Colors.red,),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
              child: Icon(Icons.receipt_long,color: Colors.black),
            ),
          ],
          title: Text('Favorite Recipes')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Receipt>>(
              future: Provider.of<DatabaseHelper3>(context, listen: false).getReceipts(),
              builder: (BuildContext context, AsyncSnapshot<List<Receipt>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("Loading"));
                }
                List<Receipt> receiptList = snapshot.data!;
                if (receiptList.isEmpty) {
                  return Center(
                    child: Text(
                      'No favorite receipts in the list',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: receiptList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Receipt receipt = receiptList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),border: Border.all(color: Colors.indigo,width: 3)),
                          child: Dismissible(
                            key: Key(receipt.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              child: Center(child: Icon(Icons.delete)),
                            ),
                            onDismissed: (direction) async {
                              await Provider.of<DatabaseHelper3>(context, listen: false).remove(receipt.id!);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Recipe has been deleted')),
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(receipt.Name.toString()),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.share,color: Colors.lightBlueAccent),
                                        onPressed: ()async{
                                          await Share.share('${receipt.Name}\n${receipt.ingredients.toString().replaceAll('[', '   ').toString().replaceAll(']', '')}');
                                        },
                                      ),
                                      tileColor: Colors.black,
                                      textColor: Colors.yellow,
                                      contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      minVerticalPadding: 8.0,
                                    ),
                                  ),
                                ),
                                Image.network(receipt.urlImage.toString()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    receipt.ingredients.toString().substring(1, receipt.ingredients!.length - 1),
                                    style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: FractionallySizedBox(widthFactor: 0.5,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push<SearchScreen>(
                    MaterialPageRoute<SearchScreen>(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.indigo, width: 3),
                ),
                child: Row(
                  children: [
                    Text(
                      "Search Recipe",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.search,color: Colors.deepOrange),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
