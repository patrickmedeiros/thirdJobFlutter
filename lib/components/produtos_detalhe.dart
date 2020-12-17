import 'package:concessionaria_avenida/apis/api_pedidos.dart';
import 'package:concessionaria_avenida/classes/cliente.dart';
import 'package:concessionaria_avenida/classes/produto.dart';
import 'package:flutter/material.dart';


class ProdutosDetalhePage extends StatefulWidget {
  final Produto produto;
  final Cliente cliente;

  ProdutosDetalhePage(this.produto, this.cliente);

  @override
  _ProdutosDetalhePageState createState() => _ProdutosDetalhePageState();
}

class _ProdutosDetalhePageState extends State<ProdutosDetalhePage> {
  var _edPedido = TextEditingController();
  String _mensagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(widget.produto.foto),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.cliente == null
                ? "Você deve se logar para fazer um pedido"
                : "Faça uma pedido, ${widget.cliente.nome}!",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          _formPedido(),
        ],
      ),
    );
  }

  _formPedido() {
    if (widget.cliente == null) {
      return Center(
        child: Text("Venha nos visitar..."),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edPedido,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText:
                  '${widget.produto.item}, ele é vendido por ${widget.produto.unidadeMedida}',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FlatButton(
              onPressed: () async {
                await _enviarPedido();
              },
              child: Text(
                ' Enviar ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _mensagem,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  _enviarPedido() async {
    if (_edPedido.text == '') {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Atenção:"),
          content: new Text("Por favor, informe a descrição do seu pedido"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
      return;
    }

    ApiPedidos apiPedidos = ApiPedidos();
    final pedidoId = await apiPedidos.savePedido(
        widget.produto, widget.cliente, _edPedido.text);

    if (pedidoId > 0) {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Pedido Cadastrada com Sucesso"),
          content: new Text(
              "Em breve entraremos em contato. Sua pedido: ${pedidoId}"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    } else {
      print('Erro de acesso ao WebService...');
    }
  }
}
