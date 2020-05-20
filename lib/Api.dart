import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:youtube_app/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyDeaJEn9SrZb2ahy56PORld74Jknaq5Qzg";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api{

  Future<List<Video>> pesquisar(String pesquisa) async{

    http.Response response = await http.get(
        URL_BASE + "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa"
      );

      if(response.statusCode == 200){

        Map<String, dynamic> result = json.decode(response.body);
        List<Video> videos = result["items"].map<Video>(
            (map){
              return Video.fromJson(map);
            }
        ).toList();
        return videos;
      }else{

      }
  }
}