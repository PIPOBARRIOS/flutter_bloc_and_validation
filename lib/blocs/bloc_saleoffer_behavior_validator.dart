
import 'dart:async';

import '../utility/utility.dart';

/// Funciones de validacion
class ValidSaleOffer
{
  /// Descrpcion de la oferta
  final StreamTransformer<String,String> fcrValidnote = StreamTransformer<String,String>.fromHandlers(handleData: (note, sink)
  {
    if (note.isEmpty)
    {
     sink.addError('Ingrese datos validos');
    }
    else
    {
      if (note.length < 20)
      {
        sink.addError('La nota es muy corta');
      }
      else
      {
        sink.add(note);
      }
    }
  });

  /// Dirección residencia
  final StreamTransformer<String,String> fcrValidaddress = StreamTransformer<String,String>.fromHandlers(handleData: (address, sink)
  {
    if (address.isEmpty)
    {
     sink.addError('Ingrese datos validos');
    }
    else
    {
     sink.add(address);
    }
  });

  /// Precio o valor economico del la oferta al publicar
  final StreamTransformer<String,String> fflValidprice = StreamTransformer<String,String>.fromHandlers(handleData: (price, sink)
  {
    if (price.isEmpty)
    {
      sink.addError('Ingrese datos validos');
    }
    else
    {
      var _lcrExpNumeric = r"^([0-9]{1,12}[,.]{0,1})+$"; 
      final RegExp lobExpValid = new RegExp(_lcrExpNumeric);

      if (lobExpValid.hasMatch(price))
      {
        var lnuValue = fdoSisParseDouble(price);  
        if (lnuValue < 20 || lnuValue > 100)
        {
          sink.addError('Precio no valido (Permitido entre 20 y 100 Pesos)');
        }
        else
        {
          sink.add(price); 
        }
      }
      else
      {
        sink.addError('Ingrese solo números');
      }
	  }  
  });
}