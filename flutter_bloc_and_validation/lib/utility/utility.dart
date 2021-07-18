
import 'package:flutter/material.dart';

/// Control para errores
class  ManagementError implements Exception 
{
  final String message;
  ManagementError(this.message);
}

/// Conversión segura a tipo Double
/// [tdyValue]: Valor Parametro en tipo dynamic
double fdoSisParseDouble(dynamic tdyValue) 
{
  //print('valor double '+tdyValue.toString());
  //tdyValue = tdyValue.contains(",") == true ? tdyValue.replaceAll(",", "") : tdyValue;
  return tdyValue != null && 
         tdyValue.toString() != 'null' &&
         tdyValue.toString().isNotEmpty ? double.parse(tdyValue.toString()) : 0;
}

//-------------------------------------------------
// SisPendingAction: Mostrar Pantalla de espera
//-------------------------------------------------
/// Vista de espera para gestion procesos 
/// puede mostrar una barra de progreso y un mensaje 
/// tambien opcional muestra un icono
class SisPendingAction extends StatelessWidget 
{
  /// Opcional mostrar un icono en lugar de 
  /// progress indicator
  final IconData? tobIcon;
  /// Color del icono
  final Color? tobIconColor;
  /// Tamaño del icono
  final double tduIconSize;
  /// Tamaño ProgressIndicator
  final double tduProgressHeight;
  /// Mensaje (valor tipo texto)
  final String tcrMessage;
  /// Color del texto mensaje
  final Color? tobMessageColor;
  /// Tamaño de la fuente para texto mensaje
  final double tduFontSizeMessage;
  /// Color del fondo pantalla
  final Color? tobBackColor;
  //------------------------------
  //Parametros Boton
  //------------------------------
  /// Etiqueta titulo (valor tipo texto)
  final String tcrButtonLabel;
  /// Color del Titulo
  final Color? tobButtonLabeColor;
  /// Ancho borde del boton (cero por defecto) valor entre 1 y 16
  final double tduButtonBorderWidth;
  /// Color borde del boton (Gris por defecto)
  final Color? tobButtonBorderColor;
  /// Estilo borde del boton Valor numerico de 1 hasta 40
  /// Ejemplo: BorderRadius.circular(40) -> Borde redondeado
  final BorderRadiusGeometry? tobButtonBorderRadius;
  /// Color del fondo del boton
  final Color? tobButtonBackColor;
  /// Alto del boton
  final double tduButtonHeight;
  /// Largo del boton
  final double tduButtonWidth;
  /// accion a realizar al presionar el boton
  final VoidCallback? tobButtonPressed;

  const SisPendingAction(
    {Key? key,
    this.tobIcon,
    this.tobIconColor: Colors.grey,
    this.tduIconSize: 100,
    this.tduProgressHeight: 50,
    required this.tcrMessage,
    this.tobMessageColor: Colors.blue,
    this.tduFontSizeMessage: 22,
    this.tobBackColor: Colors.white,
    this.tcrButtonLabel:'',
    this.tobButtonLabeColor: Colors.white,
    this.tduButtonBorderWidth: 0,
    this.tobButtonBorderColor,
    this.tobButtonBorderRadius,
    this.tobButtonBackColor: Colors.blue,
    this.tduButtonHeight: 40,
    this.tduButtonWidth: 130,
    this.tobButtonPressed    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ModalBarrier(
            dismissible: false,
            color: Colors.white,
          ),
          Align (
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _fobViewItemPending(),
                      SizedBox(width: 5, height: 20,),
                      Text(tcrMessage, 
                        style: TextStyle(
                          color: tobMessageColor,
                          fontSize: tduFontSizeMessage)
                      ),
                      // si hay que mostrar un boton
                      tcrButtonLabel.isNotEmpty ? SizedBox(width: 5, height: 20,) : Container(),
                      tcrButtonLabel.isNotEmpty ? _fobViewButtonPending()  : Container(),
                    ],
                  ),
                ],
              ),
            )
          ),          
        ],
      ),
    );
  }

  /// Mostrar Icono o Barra de Espera circular
  Widget _fobViewItemPending()
  {
    if (tobIcon != null )
    {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Icon(
            tobIcon, 
            color: Colors.green,  //tobIconColor, 
            size: tduIconSize,
          )
        ),
      );
    }
    else
    {
      return SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 5,
        ),
        height: tduProgressHeight,
        width: tduProgressHeight,
      );
    }
  }
  /// Mostrar Boton debajo del mensaje
  Widget _fobViewButtonPending()
  {
    if (tcrButtonLabel.isNotEmpty)
    {
      return MaterialButton(
      height: tduButtonHeight,
      minWidth: tduButtonWidth,
      color: tobButtonBackColor,
      child: Container(
        height: tduButtonHeight,
        width: tduButtonWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            tobIcon == null ? Container() : Icon(tobIcon, size: 30, color: Colors.white),
            tobIcon == null ? Container() : Container(height: 5, width: 2,),
            Text(tcrButtonLabel.toString(), 
              style: TextStyle(
                color: tobButtonLabeColor,
                fontSize: 16)
            ),
          ],
        ),
      ),    
      onPressed: tobButtonPressed);
      //tobButtonPressed:() => tobButtonPressed, 
    }
    return Container();
  }
}