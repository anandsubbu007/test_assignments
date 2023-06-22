import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_app/bloc/home_bloc.dart';
import 'package:video_app/presentation/dialog_ui.dart';
import 'package:video_app/widget/video_player.dart';
import 'package:video_player/video_player.dart';

class HomePg extends StatefulWidget {
  const HomePg({super.key});

  @override
  State<HomePg> createState() => HomePgState();
}

class HomePgState extends State<HomePg> {
  late VideoPlayerController _controller;

  Future loadAsset() async {
    await _controller.initialize();
    await _controller.play();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing"),
        leading: IconButton(
            onPressed: () => context.read<HomeBloc>().reset(),
            icon: const Icon(Icons.restart_alt)),
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              /// Video
              Center(
                child: StreamBuilder(
                    initialData: context.read<HomeBloc>().initialVideo,
                    stream: context.read<HomeBloc>().videoStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        _controller = snapshot.data!;
                        _controller.value =
                            const VideoPlayerValue(duration: Duration.zero);
                        return FutureBuilder(
                            future: loadAsset(),
                            builder: (context, snapshot) {
                              if (snapshot.data ?? false) {
                                return AppVideoPlayer(controller: _controller);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            });
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),

              /// Dialog
              StreamBuilder(
                  stream: context.read<HomeBloc>().dialogState.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return const SizedBox();
                    return DialogContent(state: snapshot.data!);
                  })
            ],
          )),
    );
  }
}
