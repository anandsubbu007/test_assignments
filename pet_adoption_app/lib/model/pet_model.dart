// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Pet model
class PetModel extends Equatable {
  String image;
  String name;
  String description;
  double rate;
  String price;
  String id;
  String color;
  String age;
  String sex;
  PetModel({
    required this.image,
    required this.name,
    required this.description,
    required this.rate,
    required this.price,
    required this.id,
    required this.color,
    required this.age,
    required this.sex,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'description': description,
      'rate': rate,
      'price': price,
      'id': id,
      'color': color,
      'age': age,
      'sex': sex,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      image: map['image'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      rate: double.tryParse(map['rate'].toString()) ?? 0,
      price: map['price'].toString(),
      id: map['id'] as String,
      color: map['color'] as String,
      age: map['age'] as String,
      sex: map['sex'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PetModel.fromJson(String source) =>
      PetModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  List<Object> get props => [id];
}
