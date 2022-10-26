import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:personajes_star_war/utils/image_assets.dart';

part 'people.g.dart';

@HiveType(typeId: 0)
class People {
  People({
    required this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });
  @HiveField(0)
  final String name;
  final String? height;
  final String? mass;
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? birthYear;
  @HiveField(1)
  final String? gender;
  final String? homeworld;
  final List<String>? films;
  final List<dynamic>? species;
  final List<dynamic>? vehicles;
  final List<String>? starships;

  final DateTime? created;
  @HiveField(2)
  final DateTime? edited;
  final String? url;

  factory People.fromJson(Map<String, dynamic> json) => People(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: json["gender"],
        homeworld: json["homeworld"],
        films: List<String>.from(json["films"].map((x) => x)),
        species: List<dynamic>.from(json["species"].map((x) => x)),
        vehicles: List<dynamic>.from(json["vehicles"].map((x) => x)),
        starships: List<String>.from(json["starships"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "mass": mass,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "gender": gender,
        "homeworld": homeworld,
        "films": List<dynamic>.from(films!.map((x) => x)),
        "species": List<dynamic>.from(species!.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles!.map((x) => x)),
        "starships": List<dynamic>.from(starships!.map((x) => x)),
        "created": created != null ? created!.toIso8601String() : "",
        "edited": edited != null ? edited!.toIso8601String() : "",
        "url": url,
      };

  Widget imageGender(String? gender) {
    switch (gender) {
      case "male":
        return const ImageAsset(asset: "male");

      case "female":
        return const ImageAsset(asset: "female");

      default:
        return const ImageAsset(asset: "other");
    }
  }
}
