import 'package:flutter/material.dart';
import 'package:flutter_ap/model/game_model.dart';
import 'package:flutter_ap/utils/widgets/game_image.dart';

/// Game List Tile Widget
class GameListTile extends StatefulWidget {
  const GameListTile({
    Key? key,
    this.onTap,
    required this.game,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final GamesModel game;

  @override
  State<GameListTile> createState() => _GameListTileState();
}

class _GameListTileState extends State<GameListTile> {
  late TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(24.0);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: radius),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor, borderRadius: radius),
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                    tag: widget.game.id!,
                    child: ImageWidget(imagePath: widget.game.backgroundImage)),
                const SizedBox(width: 7),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(widget.game.name ?? '',
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(
                        widget.game.released ?? '',
                        style: textTheme.labelMedium,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.game.genres?.map((e) => e.name).join(', ') ?? '',
                        style: textTheme.labelMedium,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                )
              ],
            ),

            /// Rating
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(4.0),
                  ),
                ),
                child: Text(
                  widget.game.rating?.toString() ?? '',
                  style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Positioned.fill(
                child: InkWell(onTap: widget.onTap, child: const SizedBox()))
          ]),
        ),
      ),
    );
  }
}
