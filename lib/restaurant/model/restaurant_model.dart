import 'package:actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part "restaurant_model.g.dart";

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final String name;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.thumbUrl,
    required this.name,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // RestaurantModel.fromJson(
  //   Map<String, dynamic> json,
  // )   : id = json["id"],
  //       thumbUrl = "http://$ip${json["thumbUrl"]}",
  //       name = json["name"],
  //       tags = List<String>.from(json["tags"]),
  //       priceRange = RestaurantPriceRange.values
  //           .firstWhere((e) => e.name == json["priceRange"]),
  //       ratings = json["ratings"],
  //       ratingsCount = json["ratingsCount"],
  //       deliveryTime = json["deliveryTime"],
  //       deliveryFee = json["deliveryFee"];
}
