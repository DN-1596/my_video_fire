import 'package:flutter/material.dart';
import 'package:my_video_fire/my_video_fire_bloc/index.dart';
import 'package:my_video_fire/ui/index.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: kHomePageTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final MVFBloc mvfBloc = MVFBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder<List<VFModel>>(
        valueListenable: mvfBloc.videoNotifier,
        builder: (context,videos,_) {
          if (videos.isEmpty) {
            return const Center(
              child: Text(kNoVideosAvailable),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              children: _generateChildren(context,videos),
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mvfBloc.updateVideos(
            VFModel(
                name: "my video",
                uploadTime: DateTime.now().millisecondsSinceEpoch,
                url: "https://www.fluttercampus.com/video.mp4"),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }


  List<Widget> _generateChildren(BuildContext context,List<VFModel> videos) {
    List<Widget> items = [];

    double tileDim = 200;
    for (int i = 0; i < videos.length; i++) {
      items.add(_generateItem(tileDim, videos[i]),);
    }

    return items;
  }

  Widget _generateItem(double dim, VFModel video) {
    return VideoFireItem(
      key: UniqueKey(),
      video: video,
      dim: dim,
    );
  }

}
