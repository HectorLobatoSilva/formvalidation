import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Home page")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Email: ${loginBloc.email}"),
          Divider(),
          Text("Password: ${loginBloc.password}")
        ],
      ),
    );
  }
}
