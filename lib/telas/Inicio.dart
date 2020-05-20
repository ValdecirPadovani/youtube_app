import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_app/Api.dart';
import 'package:youtube_app/model/Video.dart';

class Inicio extends StatefulWidget {

  String find;

  Inicio(this.find);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _findVideo(String find){
    Api api = Api();
    return api.pesquisar(find);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _findVideo(widget.find),
      // ignore: missing_return
      builder: (context, snapshot){
          switch(snapshot.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
                if(snapshot.hasData){
                  return ListView.separated(
                      itemBuilder: (context, index){
                        List<Video> videos = snapshot.data;
                        Video video = videos[index];
                        return GestureDetector(
                          onTap: (){
                            FlutterYoutube.playYoutubeVideoById(
                                apiKey: CHAVE_YOUTUBE_API,
                                videoId: video.id);
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(video.imagem),
                                    )
                                ),
                              ),
                              ListTile(
                                title: Text(video.titulo),
                                subtitle: Text(video.canal),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        height: 3,
                        color: Colors.red,
                      ),
                      itemCount: snapshot.data.length);
                }else{
                  return Center(
                    child: Text("Nenhum dado a ser exibido")
                  );
                }
              break;
          }
      },
    );
  }
}
