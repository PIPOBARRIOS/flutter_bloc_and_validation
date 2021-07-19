import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import '../utility/utility.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)  //(explicitToJson) para que genere en toJson objetos anidados
class ModelSaleOffer extends Object
{

  /// Desripción de la oferta a publicar
  String note;
  /// Dirección de residencia del proponente
  String address;
  /// Precio o valor de la oferta
  double price;

  ModelSaleOffer({
    this.note: '',
    this.address: '',
    this.price: 0,
  });

  /// Devolver un JSON en formato string
  String toJsonString()
  {
    return json.encode(this.toJson()).toString();
  }
  //---------------------------------------------------------
  // Gestion para serializar cuando se requiera
  //---------------------------------------------------------
  /// Cargar datos desde Json 
  factory ModelSaleOffer.fromJSON(Map<String, dynamic> json) => _$ModelSaleOfferFromJson(json);

  /// Exportar datos en formato Json - Todos los datos
  Map<String, dynamic> toJson() => _$ModelSaleOfferToJson(this);
}

/// Cargar desde Json
ModelSaleOffer _$ModelSaleOfferFromJson(Map<String, dynamic> json) {

  return ModelSaleOffer(

    note: json['note'] as String,
    address: json['address'] as String,
    price: fdoSisParseDouble(json['price']),
  );
}

/// Exportar a formato Json
Map<String, dynamic> _$ModelSaleOfferToJson(
  ModelSaleOffer instance) => <String, dynamic> {

    'note': instance.note,
    'address': instance.address,
    'price': instance.price.toString(),
};
