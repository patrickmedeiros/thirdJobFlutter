import 'dart:convert';

import 'package:concessionaria_avenida/classes/cliente.dart';
import 'package:http/http.dart' as http;

class ApiLogin {
  final url =
      'https://api.sheety.co/c140e3cff7dd8eb3d544b711ef5cb5a2/fruteiraGuimaraes/clientes';

  getLoginCliente(String email, String senha) async {
    var response =
        await http.get(url + '?filter[email]=${email}&filter[senha]=${senha}');

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['clientes'];

      if (lista.length == 1) {
        return Cliente(lista[0]['id'], lista[0]['nome'], lista[0]['email']);
      } else {
        return null;
      }
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
