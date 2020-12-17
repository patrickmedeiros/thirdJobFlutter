import 'package:concessionaria_avenida/classes/cliente.dart';
import 'package:concessionaria_avenida/classes/produto.dart';
import 'package:concessionaria_avenida/components/produtos_detalhe.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemLista extends StatelessWidget {
  final Produto produto;
  final Cliente cliente;

  ItemLista(this.produto, this.cliente);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(produto.foto),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(produto.item),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12,4,0,12),
                      child: Text(
                          'Preço ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(produto.preco)}'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                    ProdutosDetalhePage(produto, cliente)),
                    );
                  },
                  child: Text(
                    'Detalhes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
