import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var fondoMorado = Container(
      height: size.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(125, 125, 178, 1.0),
      ])),
    );
    final circulo = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );
    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          child: circulo,
          top: 90,
          left: 30,
        ),
        Positioned(
          child: circulo,
          top: -40,
          right: -30,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          right: -10,
        ),
        Container(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                "Hector Lobato",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 200,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 25),
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0, 5),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "Ingreso",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 60),
                _crearEmail(bloc),
                SizedBox(height: 30),
                _crearPassword(bloc),
                SizedBox(height: 30),
                _crearBoton(bloc)
              ],
            ),
          ),
          Text("Recuperar contrasena"),
          SizedBox(height: 100)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc loginBloc) {
    return StreamBuilder<Object>(
        stream: loginBloc.emailStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.alternate_email, color: Colors.purple),
                  hintText: "ejemplo@correo.com",
                  labelText: "Correo electronico",
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: loginBloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearPassword(LoginBloc loginBloc) {
    return StreamBuilder<Object>(
        stream: loginBloc.passwordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline, color: Colors.purple),
                  labelText: "password",
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: loginBloc.changePassword,
            ),
          );
        });
  }

  Widget _crearBoton(LoginBloc loginBloc) {
    return StreamBuilder<Object>(
        stream: loginBloc.formValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text("Ingresar"),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed:
                snapshot.hasData ? () => _login(loginBloc, context) : null,
          );
        });
  }

  _login(LoginBloc loginBloc, BuildContext context) {
    Navigator.pushReplacementNamed(context, "home");
  }
}
