// To parse this JSON data, do
//
//     final catalogueResponseModel = catalogueResponseModelFromJson(jsonString);

import 'dart:convert';

CatalogueResponseModel catalogueResponseModelFromJson(String str) => CatalogueResponseModel.fromJson(json.decode(str));

String catalogueResponseModelToJson(CatalogueResponseModel data) => json.encode(data.toJson());

class CatalogueResponseModel {
  bool? status;
  CatalogueDetails? catalogueDetails;
  ProductDetails? productDetails;

  CatalogueResponseModel({this.status, this.catalogueDetails, this.productDetails});

  factory CatalogueResponseModel.fromJson(Map<String, dynamic> json) => CatalogueResponseModel(
    status: json["status"],
    catalogueDetails: json["catalogueDetails"] == null ? null : CatalogueDetails.fromJson(json["catalogueDetails"]),
    productDetails: json["productDetails"] == null ? null : ProductDetails.fromJson(json["productDetails"]),
  );

  Map<String, dynamic> toJson() => {"status": status, "catalogueDetails": catalogueDetails?.toJson(), "productDetails": productDetails?.toJson()};
}

class CatalogueDetails {
  List<CatalogueDetailsDatum>? data;

  CatalogueDetails({this.data});

  factory CatalogueDetails.fromJson(Map<String, dynamic> json) =>
      CatalogueDetails(data: json["data"] == null ? [] : List<CatalogueDetailsDatum>.from(json["data"]!.map((x) => CatalogueDetailsDatum.fromJson(x))));

  Map<String, dynamic> toJson() => {"data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson()))};
}

class CatalogueDetailsDatum {
  String? id;
  String? name;

  CatalogueDetailsDatum({this.id, this.name});

  factory CatalogueDetailsDatum.fromJson(Map<String, dynamic> json) => CatalogueDetailsDatum(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProductDetails {
  List<ProductDetailsDatum>? data;

  ProductDetails({this.data});

  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      ProductDetails(data: json["data"] == null ? [] : List<ProductDetailsDatum>.from(json["data"]!.map((x) => ProductDetailsDatum.fromJson(x))));

  Map<String, dynamic> toJson() => {"data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson()))};
}

class ProductDetailsDatum {
  String? id;
  String? name;
  String? description;
  String? price;
  String? currency;
  String? availability;
  String? imageUrl;
  String? url;
  String? retailerId;

  ProductDetailsDatum({this.id, this.name, this.description, this.price, this.currency, this.availability, this.imageUrl, this.url, this.retailerId});

  factory ProductDetailsDatum.fromJson(Map<String, dynamic> json) => ProductDetailsDatum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    currency: json["currency"],
    availability: json["availability"],
    imageUrl: json["image_url"],
    url: json["url"],
    retailerId: json["retailer_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "currency": currency,
    "availability": availability,
    "image_url": imageUrl,
    "url": url,
    "retailer_id": retailerId,
  };
}
