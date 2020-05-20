import 'package:flutter/material.dart';
import 'package:youtube_app/CustomSearchDelegate.dart';
import 'package:youtube_app/telas/Biblioteca.dart';
import 'package:youtube_app/telas/EmAlta.dart';
import 'package:youtube_app/telas/Inicio.dart';
import 'package:youtube_app/telas/Inscricao.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _index = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> _telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricao(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
            "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: (){
              print("acao: videocam");
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String res = await showSearch(context: context, delegate: CustomSearchDelegate());
              print(res);
              setState(() {
                _resultado = res;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){
              print("acao: account_circle");
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _telas[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (indice){
          setState(() {
            _index = indice;
          });
        },
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            title: Text("Inicio"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              title: Text("Em alta"),
              icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
              title: Text("Inscrições"),
              icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
          )
      ],
      ),
    );
  }
}
