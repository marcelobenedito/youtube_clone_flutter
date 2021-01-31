import 'package:flutter/material.dart';
import 'package:youtube_clone/Api.dart';
import 'package:youtube_clone/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class HomeScreen extends StatefulWidget {
  String search;

  HomeScreen(this.search);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _listVideos(String search) {
    Api api = Api();
    return api.search(search);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _listVideos(widget.search),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video> videos = snapshot.data;
                  Video video = videos[index];
                  return GestureDetector(
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                        apiKey: YOUTUBE_API_KEY,
                        videoId: video.id,
                        autoPlay: true,
                        fullScreen: true
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(video.image),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        ListTile(
                          title: Text(video.title),
                          subtitle: Text(video.channel),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(
                child: Text("No data to display!"),
              );
            }
            break;
        }
        return null;
      },
    );
  }
}
