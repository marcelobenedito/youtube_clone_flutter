import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube_clone/model/Video.dart';

const YOUTUBE_API_KEY = "AIzaSyCvP_jj2PTVAtJtM1SGBdUvGxpxvn-qrHA";
const YOUTUBE_CHANNEL_ID = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const YOUTUBE_API_BASE_URL = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> search(String query) async {
    http.Response response = await http.get(
      YOUTUBE_API_BASE_URL + "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$YOUTUBE_API_KEY"
          "&channelId=$YOUTUBE_CHANNEL_ID"
          "&q=$query"
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<Video> videos = jsonData["items"].map<Video>(
          (map) {
            return Video.fromJson(map);
          }
      ).toList();
      return videos;
    } else {

    }
  }

}