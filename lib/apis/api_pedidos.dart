import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:date_format/date_format.dart';


class ApiPedidos {
  final url =
      'https://api.sheety.co/c140e3cff7dd8eb3d544b711ef5cb5a2/fruteiraGuimaraes/pedidos';

  savePedido(produto, cliente, descricao) async {
    var reg = {
      "pedido": {
        "produtoId": produto.id,
        "clienteId": cliente.id,
        "descricao": descricao,        
        //"data": formatDate(
        //    DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn])
      }
    };

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reg),
    );

    if (response.statusCode == 200) {
      var retorno = jsonDecode(response.body)['pedido'];
      return retorno['id'];
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
