import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../utility/utility.dart';
import '../models/model_saleoffer.dart';
import 'bloc_saleoffer_behavior_validator.dart';

///
///  GESTION VALIDACION PARA FORMULARIO CAPTURA DE DATOS PARTICIPANTES EN UNA OFERTA
///
class SaleOfferFormBloc extends Object with ValidSaleOffer implements BlocBase
{
  /// Registro dado desde temporal que viene desde la base de datos
  ModelSaleOffer lobRecord = new ModelSaleOffer();

  //------------------------------------------------
  // Declaración controladores
  //------------------------------------------------

  /// Descripcion de la oferta
  final BehaviorSubject<String> _g1noteController = BehaviorSubject<String>.seeded("3");
  /// Dirección residencia 
  final BehaviorSubject<String> _g1addressController = BehaviorSubject<String>.seeded("");
  /// Precio o valor economico 
  final BehaviorSubject<String> _g1priceController = BehaviorSubject<String>.seeded("0");

  //------------------------------------------------
  // Flujo de datos y pasan a validacion
  //------------------------------------------------

  Stream<String> get g1note => _g1noteController.stream.transform(fcrValidnote);
  Stream<String> get g1address => _g1addressController.stream.transform(fcrValidaddress);
  Stream<String> get g1price => _g1priceController.stream.transform(fflValidprice);

  //------------------------------------------------
  // llegan los datos desde la vista al controlador
  //------------------------------------------------
  /// Descripcion de la oferta
  Function(String) get onG1noteChanged => _g1noteController.sink.add;
  /// Dirección residencia
  Function(String) get onG1addressChanged => _g1addressController.sink.add;
  /// Precio o valor
  Function(String) get onG1priceChanged => _g1priceController.sink.add;

  //------------------------------------------------
  // Funciones para mostrar y activacion del boton Guardar 
  // combineLatest: puede ser combineLatest3,combineLatest4,combineLatest5... 15
  //------------------------------------------------
  Stream<bool> get onActivateCREATE => Rx.combineLatest3(
                                      g1note, 
                                      g1address,
                                      g1price,
                                      (a, b, c) => true);

  //------------------------------------------------
  // Funciones Limpiar datos
  //------------------------------------------------
  /// Limpiar datos
  void fcvResetData()
  {
    _g1noteController.sink.add('');
    _g1addressController.sink.add('');
    _g1priceController.sink.add('');
  }
  
  //------------------------------------------------
  // Funciones para Cargar en temporal
  //------------------------------------------------
  ///Cargar los datos en el registro temporal maestro
  ModelSaleOffer fobGetRegisterDataGestion()
  {

    _g1noteController.stream.listen((onData) {
     lobRecord.note = onData;
    });

    _g1addressController.stream.listen((onData) {
     lobRecord.address = onData;
    });

    _g1priceController.stream.listen((onData) {

      // quitar las comas del formato de captura que se usa en la vista
      onData = onData.contains(",") == true ? onData.replaceAll(",", "") : onData;
      lobRecord.price = fdoSisParseDouble(onData);
    });

    return lobRecord;
  }

  // Cerrar controladores 
  void dispose() {

   _g1noteController.close();
   _g1addressController.close();
   _g1priceController.close();
 }

  // Se invoca cuando se accede a un método o propiedad inexistente - para cumplir con la implements BlocBase
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}