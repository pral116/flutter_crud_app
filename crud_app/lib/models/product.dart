import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{
  @JsonKey(name: "_id")
  String id;
  String title;
  String description;
  bool is_completed;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.is_completed
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

}