import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_saleoffer_state.dart';
import '../utility/utility.dart';
import '../blocs/bloc_saleoffer_behavior_persistent.dart';
import '../blocs/bloc_saleoffer_bloc.dart';
import '../blocs/bloc_saleoffer_event.dart';

///
/// SaleOffer : MAESTRO PUBLICAR OFERTAS,MAESTRO PARTICIPANTES EN UNA OFERTA
///
class FormSaleOffer extends StatefulWidget
{

  FormSaleOffer();

 @override
 _FormSaleOfferState createState() => _FormSaleOfferState();
}

class _FormSaleOfferState extends State<FormSaleOffer>
{
  late SaleOfferBloc _lobBloc;
  late SaleOfferFormBloc _lobFormBloc;
  double _lduFontMsjSize =0;
  double _height = 0;
  double _width  = 0;

  /// Descripción o nota complementaria, para explicar la oferta a realizar
  late TextEditingController _g1noteController;
  /// Dirección del domicilio del proponente
  late TextEditingController _g1addressController;
  /// Precio o valor economico del la oferta al publicar
  late TextEditingController _g1priceController;
  

  @override
  void initState() {
    _lobBloc = SaleOfferBloc();

    _lobFormBloc = SaleOfferFormBloc();
    _fcvInitValueController();
    //oApp.gobAddressGeolocation = _fobGetGeoLocationLatLng();
    super.initState();
  }
  @override
  void dispose() {
    _lobFormBloc.dispose();
    _fcvDisposeContrller();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    _height = MediaQuery.of(context).size.height;
    _width  = MediaQuery.of(context).size.width;

    _lduFontMsjSize = MediaQuery.of(context).size.height * 0.020;
    return Scaffold(
    body: BlocBuilder<SaleOfferBloc,StandardEditionState>(
      bloc: _lobBloc,
      builder: (BuildContext context, StandardEditionState state)
      {
        if (state is StandardEditionStateIsSaving)
        {
          return _fcvBuildSaving();
        } 
        else if (state is StandardEditionStateIsSuccessFull)
        {
          return _fcvBuildSuccessFull();
        }
        else if (state is StandardEditionStateIsFailure)
        {
          return _fcvBuildFailure();
        }
        else if (state is StandardEditionStateIsInitializing || state is StandardEditionStateIsCapture)
        {
          return _fobBuildForm();
        }
        return Container();
      }),
    );
  }

  //-------------------------------------------------
  // _fcvBuildSaving: Guardando datos
  //-------------------------------------------------
  /// Guardando datos
  Widget _fcvBuildSaving()
  {
   var _lcrAppStateMsg = 'Guardando datos...';

   return SisPendingAction(tcrMessage: _lcrAppStateMsg,
                           tduFontSizeMessage: _lduFontMsjSize);
  }

  //-------------------------------------------------
  // _fcvBuildSuccess: Finalizado con exito
  //-------------------------------------------------
  /// Finalizado con exito
  Widget _fcvBuildSuccessFull()
  {
   var _lcrAppStateMsg = 'Finalizado con éxito!!';

   return SisPendingAction(tcrMessage: _lcrAppStateMsg,
                           tduFontSizeMessage: _lduFontMsjSize,
                           tobIcon: Icons.check_circle,
                           tcrButtonLabel: 'OK',
                           tobButtonPressed: () { 

  // Borrar datos existentes en bloc
  _fcvResetController();
  _lobFormBloc.fcvResetData();
  // Desencadenar el evento para volver al formulario de captura
   _lobBloc.add(SaleOfferEventCapture());
 });
  }

  //-------------------------------------------------
  // _fcvBuildFailure: Cuando hay error al guardar
  //-------------------------------------------------
  /// Cuando hay error al guardar
  Widget _fcvBuildFailure()
  {
   var _lcrAppStateMsg = 'Ocurrio un error al guardar los datos.';

   return SisPendingAction(tcrMessage: _lcrAppStateMsg,
                           tduFontSizeMessage: _lduFontMsjSize,
                           tobIcon: Icons.access_alarm);
  }

  //-------------------------------------------------
  // _fobBuildForm: El formulario
  //-------------------------------------------------
  /// Vista del formulario
  Widget _fobBuildForm()
  {
    return Stack(
      children: <Widget>[
        Container(
          child: ListView(
            children: <Widget>[
                // Campos para captura
                _fobViewFieldsForm(),
            ]
          )
        ),
        _fobBuildButtonSave(),
      ]
    );
  }
  
  /// Mostrar el boton guardar
  Widget _fobBuildButtonSave()
  {
    return StreamBuilder<bool>(
      stream: _lobFormBloc.onActivateCREATE,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.hasData == true && snapshot.data == true ?
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(left: _width *0.0220),
                  alignment: Alignment.center,
                  height: _height * 0.10,
                  width: _width * 0.35,
                  child: _fobBuildButtonSaveEdition(),
                ),
              ]
            )
          ) : Container();
        //return _fobBuildViewButton(snapshot);
      }
    );
  }
  
  /// Boton para guardar los cambios realizados
  Widget _fobBuildButtonSaveEdition()
  {
    return _fobViewButtonAction("Guardar",
      (){

        var _lobRegData = _lobFormBloc.fobGetRegisterDataGestion();
         // Desencadenar el metodo guardar
        _lobBloc.add(SaleOfferEventSave(message: "CREATE", tmpData: _lobRegData));
      }       
    );
  }

  /// Mostrar Boton debajo del mensaje
  Widget _fobViewButtonAction(String tcrLabel,  VoidCallback tobButtonPressed)
  {
      return MaterialButton(
      height: 40,
      minWidth: 70,
      color: Colors.blue,
      child: Container(
        alignment: Alignment.center,
        height: 25,
        width: 90,
        child: Text(tcrLabel.toString(), 
              style: TextStyle(
                color: Colors.white,
                fontSize: 16)
            ),
      ),    
      onPressed: tobButtonPressed);
  }
  //-------------------------------------------------
  // _fobViewFieldsForm: Vista Campos de captura formulario
  //-------------------------------------------------
  /// Vista Campos de captura formulario
  Widget _fobViewFieldsForm()
  {
    return Container(
      child: Column(
        children: <Widget>[
	  
          //  Descripción Nota textual
          StreamBuilder<String>(
            stream: _lobFormBloc.g1note,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                    labelStyle: TextStyle(color: Colors.blue),
                    errorText: snapshot.error?.toString(),
                    icon: Icon(Icons.border_color, color: Colors.red),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black38))
                  ),
                  controller: _g1noteController,
                  onChanged: _lobFormBloc.onG1noteChanged,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,                       
                )
              );
            }
          ),
          // Direccion Domicilio
          StreamBuilder<String>(
            stream: _lobFormBloc.g1address,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Dirección Residencia',
                    labelStyle: TextStyle(color: Colors.blue),
                    errorText: snapshot.error?.toString(),
                    icon: Icon(Icons.house_sharp, color: Colors.red),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black38))
                  ),
                  controller: _g1addressController,
                  onChanged: _lobFormBloc.onG1addressChanged,
                )
              );
            }
          ),

          // Precio oferta
          StreamBuilder<String>(
            stream: _lobFormBloc.g1price,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                    labelStyle: TextStyle(color: Colors.blue),
                    errorText: snapshot.error?.toString(),
                    icon: Icon(Icons.monetization_on, color: Colors.red,),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black38))
                  ),
                  controller: _g1priceController,
                  onChanged: _lobFormBloc.onG1priceChanged,
                )
              );
            }
          ),
          // Total de artistas acanzados - g1RecValidscopeRetp

	      ],
	    ),
    );
  }

  //-------------------------------------------------
  // Gestion de datos
  //-------------------------------------------------
  
  /// Inicializar valores de Controllers
  void _fcvInitValueController()
  {
    _g1noteController = TextEditingController();
    _g1addressController = TextEditingController();
    _g1priceController = TextEditingController();
  }

  /// Resetear valores de Controllers
  void _fcvResetController()
  {
    _g1noteController.value = TextEditingValue.empty;
    _g1addressController.value = TextEditingValue.empty;
    _g1priceController.value = TextEditingValue.empty;
  }

  /// Finalizar valores de Controllers
  void _fcvDisposeContrller()
  {
    _g1noteController.dispose();
    _g1addressController.dispose();
    _g1priceController.dispose();
  }

}