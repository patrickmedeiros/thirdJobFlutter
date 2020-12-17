import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:concessionaria_avenida/apis/api_produtos.dart';
import 'package:concessionaria_avenida/blocs/login_bloc.dart';
import 'package:concessionaria_avenida/components/home_page.dart';
import 'package:concessionaria_avenida/blocs/produtos_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  ApiProdutos apiprodutos = ApiProdutos();
  apiprodutos.getProdutos();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => ProdutosBloc()),
        Bloc((i) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
