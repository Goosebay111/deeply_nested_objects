// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:deeply_nested_objects/bloc/collection/collection_bloc.dart';
import 'package:deeply_nested_objects/helper_functions/convert_youtube_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

void navigateToNextPage({
  required CollectionState parentNode,
  required BuildContext context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => AdaptiveVideoPlayer(parentNode: parentNode)),
  );
}

class AdaptiveVideoPlayer extends StatelessWidget {
  const AdaptiveVideoPlayer({
    super.key,
    required this.parentNode,
  });
  final CollectionState parentNode;

  @override
  Widget build(BuildContext context) {
    String? webAddress = parentNode.webAddress;
    // webAddress1 = 'https://www.youtube.com/watch?v=5pdnzUjmkzA';
    // webAddress2 = 'https://www.youtube.com/shorts/h2KWUvwJvAI';
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MediaQuery.of(context).orientation == Orientation.landscape
              ? null
              : AppBar(
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
          body: TopHatVideoPlayer(webAddress: webAddress!),
        );
      },
    );
  }
}

class TopHatVideoPlayer extends StatefulWidget {
  const TopHatVideoPlayer({super.key, required this.webAddress});
  final String webAddress;

  @override
  State<TopHatVideoPlayer> createState() => _TopHatVideoPlayerState();
}

class _TopHatVideoPlayerState extends State<TopHatVideoPlayer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    /// needs to be added to take into account the inadequacies of the youtube_player_flutter package.
    String? processedURL = ProcessURL.convertToUseableURL(widget.webAddress);

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(processedURL!)!);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
      ),
      builder: (context, player) {
        return ListView(
          children: [
            player,
          ],
        );
      },
    );
  }
}
