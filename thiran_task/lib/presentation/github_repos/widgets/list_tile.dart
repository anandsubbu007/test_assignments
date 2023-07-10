import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/model/github_response.dart';

class GithubRepoItem extends StatelessWidget {
  final Items item;
  final GestureTapCallback? onTap;

  const GithubRepoItem({Key? key, required this.item, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget detailW() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 24, color: Colors.amber),
            Text(item.stargazersCount.toString()),
          ],
        ),
      );
    }

    return ListTile(
      onTap: () {},
      title: Text(
        item.fullName ?? item.name ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        item.description ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: item.owner!.avatarUrl!,
            placeholder: (context, url) => const Icon(
              Icons.account_circle_outlined,
              size: 50.0,
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.account_circle_outlined, size: 50.0),
            width: 50.0,
          )),
      trailing: detailW(),
    );
  }
}
