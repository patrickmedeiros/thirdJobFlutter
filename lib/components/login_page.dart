import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:concessionaria_avenida/apis/api_login.dart';
import 'package:concessionaria_avenida/blocs/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = BlocProvider.getBloc<LoginBloc>();

  var _edEmail = TextEditingController();
  var _edSenha = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _quadroSuperior(context),
          _camposForm(context),
        ],
      ),
    );
  }

  _quadroSuperior(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final quadro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(92, 188, 217, 1.0),
            Color.fromRGBO(186, 201, 205, 1.0),
          ],
        ),
      ),
    );

    final balao = Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.10),
      ),
    );

    return Stack(
      children: <Widget>[
        quadro,
        Positioned(child: balao, left: 30, top: 120),
        Positioned(child: balao, right: 10, top: 40),
        Positioned(child: balao, right: 30, top: 140),
        Positioned(child: balao, left: 50, top: 40),
        Positioned(child: balao, left: 150, top: 10),
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80),
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                height: 42,
              ),
              SizedBox(height: 10),
              Text(
                'Fruteira Guimarães',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _camposForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Login do Cliente',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                  ),
                ),
                _campoEmail(),
                _campoPassword(),
                _botaoEntrar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _campoEmail(){
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: TextField(
        controller: _edEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.alternate_email,
            color:Colors.blue,
          ),
          labelText: 'E-mail do cliente:',
        ),
      ),
    );
  }

  _campoPassword(){
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: TextField(
        controller: _edSenha,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock_open,
            color:Colors.blue,
          ),
          labelText: 'Senha:',
        ),
      ),
    );
  }

  RaisedButton _botaoEntrar(){
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
        child: Text('Entrar'),
      ),
      onPressed: () async {
        await _verificaLogin();
      },
    );
  }

  Future<void> _verificaLogin() async {
    if (_edEmail.text == '' || _edSenha.text == '') {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Atenção:"),
          content:
              new Text("Preencha todos os campos ou clique no botão voltar"),
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

    ApiLogin apiLogin = ApiLogin();
    final cliente =
        await apiLogin.getLoginCliente(_edEmail.text, _edSenha.text);

    if (cliente == null) {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Login Inválido"),
          content: new Text(
              "Informe novamente seus dados, ou clique no botão voltar"),
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
      // Adiciona ao Stream o cliente logado
      _bloc.loginCliente(cliente);

      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Login Efetuado com Sucesso!!"),
          content: new Text("Agora você pode realizar pedidos."),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }
}
