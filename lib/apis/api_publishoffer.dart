import 'dart:async';
//import 'dart:convert';
//import 'package:http/http.dart' as http;

//import '../utility/utility.dart';
import '../models/model_saleoffer.dart';


/// Api para gestion ofertas
class ApiPublishOffer
{
  // ------------------------------------------------------------------------------
  //  CRUID
  // ------------------------------------------------------------------------------
  /// Adicionar registro en base de datos
  /// [tobRegister]: Registro Json para gestion en Api del servidor Backend
  Future<ModelSaleOffer?> flgApiEditSaleOffer(ModelSaleOffer tobRegister) async
  {
      //---------------------------------------------
      // Codigo para simular llamado a la API y la espera de respuesta

      ModelSaleOffer lobReg;
      var _lcrtext = tobRegister.toJsonString(); // Serializar los datos capturados(convertir el registro en Json)
     
      // Url de ejemplo para llamar al  (API backend)
      var lcrUrl = Uri.parse("https://mybackend/api/gestion?Type=add");

      await Future.delayed(const Duration(seconds: 1));
      lobReg = ModelSaleOffer();
      return lobReg;
      //---------------------------------------------

      /*
      este es el codigo real para llamadas a la API


      ModelSaleOffer lobReg;
      var _lcrtext = tobRegister.toJsonString(); // Serializar los datos capturados(convertir el registro en Json)
     
      // Url de ejemplo para llamar al  (API backend)
      var lcrUrl = Uri.parse("https://mybackend/api/gestion?Type=add");

      var lobResponse = await http.post(lcrUrl,
        body: _lcrtext,
        headers: {
            "content-type" : "application/json",
            "accept" : "application/json",
        });

      if (lobResponse.statusCode == 200)
      {
        // Cargar le Json dado como respesta por el API (backend)
        lobReg = ModelSaleOffer.fromJSON(_lcrTypeView,json.decode(lobResponse.body.toString()));
      }
      else
      {
        throw ManagementError(lobResponse.body.toString());
      }
      return lobReg;
      */
  }

  // ------------------------------------------------------------------------------
  //  CONSULTAR EN MODO JSON
  // ------------------------------------------------------------------------------

  // ------------------------------------------------------------------------------
  //  SaleOffer : MAESTRO PUBLICAR OFERTAS,MAESTRO PARTICIPANTES EN UNA OFERTA
  // ------------------------------------------------------------------------------
  /// Retorna lista de registros dada la llave de grupo
  /// [tcrTextFilter]: Parametro para texto filtro, cuando sea requerido
  /// [tnuCurrentPage]: Numero de pagina a retornar como resultado de la consulta
  Future<ModelSaleOffer?> fobQuerySaleOffer(String tcrTextFilter, int tnuCurrentPage) async
  {

      //---------------------------------------------
      // Codigo para simular llamado a la API y la espera de respuesta
      //---------------------------------------------
      var lcrFilter = tcrTextFilter.isNotEmpty ? "&TextFilter=" + tcrTextFilter: "";
      var lcrParameter = "CurrentPage=${tnuCurrentPage.toString().trim()}$lcrFilter";
      ModelSaleOffer lobReg;

      var lcrUrl = Uri.parse("https://mybackend/api/gestion?Type=query?" + lcrParameter);

      await Future.delayed(const Duration(seconds: 1));
      lobReg = ModelSaleOffer();
      return lobReg;
      //---------------------------------------------

    /*

      CODIGO FUENTE REAL PARA LLAMADA A LA API  

      var lcrFilter = tcrTextFilter.isNotEmpty ? "&TextFilter=" + tcrTextFilter: "";
      var lcrParameter = "CurrentPage=${tnuCurrentPage.toString().trim()}$lcrFilter";
      ModelSaleOffer lobReg;

      var lcrUrl = Uri.parse("https://mybackend/api/gestion?Type=query?" + lcrParameter);

      final lobResponse= await http.get(lcrUrl);

      await Future.delayed(const Duration(seconds: 1));

      if (lobResponse.statusCode == 200)
      {
        lobReg = ModelSaleOffer.fromJSON(json.decode(lobResponse.body.toString()));
        return lobReg;
      }
      else
      {
        throw ManagementError(json.decode(lobResponse.body)['error']['message']);
      }
      */
  }
}
ApiPublishOffer apiSaleOffer = ApiPublishOffer();
