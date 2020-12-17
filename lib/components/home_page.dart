import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:concessionaria_avenida/blocs/login_bloc.dart';
import 'package:concessionaria_avenida/classes/cliente.dart';
import 'package:concessionaria_avenida/components/item_lista.dart';
import 'package:concessionaria_avenida/components/login_page.dart';
import 'package:concessionaria_avenida/components/menu_pesquisa.dart';
import 'package:concessionaria_avenida/classes/produto.dart';
import 'package:concessionaria_avenida/blocs/produtos_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = BlocProvider.getBloc<ProdutosBloc>();
  final _blocLogin = BlocProvider.getBloc<LoginBloc>();
  Cliente _pessoaLogada;

@override
  void initState() {
    super.initState();
    _blocLogin.outCliente.listen((dado) {
      setState(() {
        _pessoaLogada = dado;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/carros.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text('Fruteira Guimarães'),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: _pessoaLogada == null
                ? Icon(Icons.login)
                : Icon(Icons.verified_user),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () async {
              _bloc.buscaProdutos();
            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () async {
              _bloc.buscaProdutosDestaque();
            },
          ),          
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String pesq =
                  await showSearch(context: context, delegate: MenuPesquisa());
              if(pesq != null){
                _bloc.buscaProdutosPesquisa(pesq);
              }
            },
          ),
        ],
      ),
      body: _body(context),
    );
  }

  _body(context) {
    _bloc.buscaProdutos();

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List<Produto>>(
            stream: _bloc.outProdutos,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao acessar servidor',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text(
                    'Não há disponibilidade deste produto',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ItemLista(snapshot.data[index], _pessoaLogada);
                },
                itemCount: snapshot.data.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
