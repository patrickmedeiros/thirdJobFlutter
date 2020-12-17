import 'dart:convert';
import 'package:concessionaria_avenida/classes/produto.dart';
import 'package:http/http.dart' as http;

class ApiProdutos {
  var url =
      'https://api.sheety.co/c140e3cff7dd8eb3d544b711ef5cb5a2/fruteiraGuimaraes/produtos';

  // getCarros() async {
  //   final response = await http.get(url);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   print(json.decode(response.body)['carros']);
  // }

  getProdutos() async {
    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['produtos'];
      List<Produto> produtos = lista
          .map<Produto>((produto) =>
              Produto.fromJson(produto)) //map percorre todos os dados da lista
          .toList();
      return produtos;
    } else {
      throw Exception('Erro ao acessar WebService');
    }
  }

   getProdutosDestaque() async {
    var response = await http.get(url+'?filter[destaque]=true');
    
    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['produtos'];
      List<Produto> produtos = lista
          .map<Produto>((produto) =>
              Produto.fromJson(produto)) //map percorre todos os dados da lista
          .toList();
      return produtos;
    } else {
      throw Exception('Erro ao acessar WebService');
    }
  }
  getProdutosPesquisa(String palavra) async {
    var response = await http.get(url+'?filter[item]='+palavra);
    
    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['produtos'];
      List<Produto> produtos = lista
          .map<Produto>((produto) =>
              Produto.fromJson(produto)) //map percorre todos os dados da lista
          .toList();
      return produtos;
    } else {
      throw Exception('Erro ao acessar WebService');
    }
  }
}
