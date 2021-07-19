import 'package:equatable/equatable.dart';
import '../models/model_saleoffer.dart';

/// Clase Base
abstract class BlocEvent extends Equatable {
  
  @override
  List<Object> get props => []; // iniciar vacia lista de objetos 
}


abstract class SaleOfferEvent extends BlocEvent {

  /// Para pasar parametros de utilidad
  final String message;

  SaleOfferEvent({this.message: ''}); // se inicia la variable vacia
}

/// Desde formulario se esta realizando la captura de datos
class SaleOfferEventCapture extends SaleOfferEvent {}

/// Descencadenar el evento para guardar los datos
class SaleOfferEventSave extends SaleOfferEvent {

  /// Temporal registros que recoge todos los datos capturados
  final ModelSaleOffer tmpData;

  SaleOfferEventSave({String message ='', required this.tmpData}) :
             super(message: message); // se inicia las variables vacias

}

/// Descencadenar el evento actualizar datos en proceso de un contrato
class SaleOfferEventUpdate extends SaleOfferEvent {

  /// Temporal registros que recoge todos los datos capturados
  final ModelSaleOffer tmpData;

  SaleOfferEventUpdate({String message ='', required this.tmpData}) :
             super(message: message); // se inicia las variables vacias

}

/// Cuando ocurre un erro en la autenticación
class SaleOfferEventError extends SaleOfferEvent {} // activa el evento error