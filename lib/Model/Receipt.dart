import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Receipt with ChangeNotifier{
  final int? id;
  final String? Name;
  final String? ingredients;
  final String? urlImage;
  Receipt({this.id,this.Name,this.ingredients,this.urlImage});
  factory Receipt.fromMap(Map<String,dynamic>json)=>Receipt(
    id: json['id'],
    Name: json['Name'],
    ingredients: json['ingredients'],
    urlImage: json['urlImage']
  );
  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'Name':Name,
      'ingredients':ingredients,
      'urlImage':urlImage
    };
  }
}