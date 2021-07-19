import 'package:equatable/equatable.dart';

abstract class BlocState extends Equatable {
  
  @override
  List<Object> get props => []; // iniciar vacia lista de objetos 
}

abstract class StandardEditionState extends BlocState {}

/// proceso de captura datos en formulario esta en curso (estado normal)
class StandardEditionStateIsCapture extends StandardEditionState {}

/// se esta haciendo el proceso de guardar datos
class StandardEditionStateIsSaving extends StandardEditionState {}

/// Proceso de guardado esta completo
class StandardEditionStateIsSuccessFull extends StandardEditionState {}

/// Inicializacion en curso
class StandardEditionStateIsInitializing extends StandardEditionState {}

/// Proceso de busqueda  activo o en curso
class StandardEditionStateIsSearching extends StandardEditionState {}

/// Cargando datos
class StandardEditionStateIsLoading extends StandardEditionState {}

/// Ocupado en un proceso
class StandardEditionStateIsBusy extends StandardEditionState {}

/// State - Cuando no hay resultados de siguiente pagina
class StandardEditionStateIsNosuccessNext extends StandardEditionState {}

/// se produjo un erro en captura, guardado o busqueda de datos
class StandardEditionStateIsFailure extends StandardEditionState {
  final String msjError;
  StandardEditionStateIsFailure({required this.msjError});
}
