import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:concessionaria_avenida/apis/api_produtos.dart';
import 'package:concessionaria_avenida/classes/produto.dart';

class ProdutosBloc extends BlocBase {
  final _produtosController = StreamController<List<Produto>>();
  Stream<List<Produto>> get outProdutos => _produtosController.stream;

  ApiProdutos apiProdutos = ApiProdutos();

  void buscaProdutos() async {    
    final produtos = await apiProdutos.getProdutos();
    _produtosController.sink.add(produtos);
  }

  void buscaProdutosDestaque() async {
    _produtosController.sink.add(null);
    final produtos = await apiProdutos.getProdutosDestaque();
    _produtosController.sink.add(produtos);
  }

  void buscaProdutosPesquisa(String palavra) async {
    _produtosController.sink.add(null);
    final produtos = await apiProdutos.getProdutosPesquisa(palavra);
    _produtosController.sink.add(produtos);
  }

  @override
  void dispose() {
    _produtosController.close();
  }
}
