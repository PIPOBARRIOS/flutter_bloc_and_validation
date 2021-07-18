//import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_saleoffer_event.dart';
import 'bloc_saleoffer_state.dart';
import '../apis/api_publishoffer.dart';
import '../utility/utility.dart';

/// SaleOffer : BlocBase Eventos - MAESTRO PUBLICAR OFERTAS,MAESTRO PARTICIPANTES EN UNA OFERTA
class SaleOfferBloc extends Bloc<SaleOfferEvent, StandardEditionState>
{
  SaleOfferBloc() : super(StandardEditionStateIsInitializing(),);

  //--------------------------------------------------------------
  // Proceso de gestion
  //--------------------------------------------------------------
  @override
  Stream<StandardEditionState> mapEventToState(SaleOfferEvent event) async* 
  {
    if (event is SaleOfferEventCapture)
    {
      yield StandardEditionStateIsCapture();
    }

    if (event is SaleOfferEventSave)
    {
      yield StandardEditionStateIsSaving();
      yield *_fcvMapSavingDataBase(event);
    }

    if (event is SaleOfferEventUpdate)
    {
      yield StandardEditionStateIsSaving();
      yield *_fcvUpdateDataUpdate(event);
    }

    if (event is SaleOfferEventError)
    {
      // cuando ocurre un error
      yield StandardEditionStateIsFailure(msjError:'ocurrió algún error.');
    }
  }

  //---------------------------------------------------------------------
  // Procesos gestion firmar acuerdo y demas pasos
  //---------------------------------------------------------------------

  /// Cargando datos para la vista
  Stream<StandardEditionState> _fcvUpdateDataUpdate(SaleOfferEventUpdate event)  async*
  {
    try
    {
      bool llgResponse = false;
      await apiPublishOffer.flgApiEditSaleOffer(event.tmpData).then((tcrValue) {
        if (tcrValue != null)
        {
          llgResponse = true;
        }
      });

      if (llgResponse == true)
      {
          // Mostrar la vista de datos
          yield StandardEditionStateIsCapture();
      }
      else
      {
        // Ocurrio algin error
        yield StandardEditionStateIsFailure(msjError: "Ocurrió algún error");
      }
    }
    on ManagementError catch (e)
    {
      yield StandardEditionStateIsFailure(msjError: e.message);
    }
  }

  //---------------------------------------------------------------------
  // Procesos para gestion 
  //---------------------------------------------------------------------

  Stream<StandardEditionState> _fcvMapSavingDataBase(SaleOfferEventSave event) async*
  {
    try
    {
      bool llgResponse = false;

      await apiPublishOffer.flgApiEditSaleOffer(event.tmpData).then((tcrValue) {
        if (tcrValue != null)
        {
          llgResponse = true;
        }
      });

      if (llgResponse == true)
      {
          // Mostrar la vista, finalizado con Exito
          yield StandardEditionStateIsSuccessFull();
      }
      else
      {
        // Ocurrio algin error
        yield StandardEditionStateIsFailure(msjError: "Ocurrió algún error");
      }

    }
    on ManagementError catch (e)
    {
      yield StandardEditionStateIsFailure(msjError: e.message);
    }
  }
}
