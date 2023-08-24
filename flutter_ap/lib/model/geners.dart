class GamePlatform {
  int? id;
  String? name;
  String? slug;
  int? gamesCount;
  String? imageBackground;

  GamePlatform({
    this.id,
    this.name,
    this.slug,
    this.gamesCount,
  });

  GamePlatform.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }
}

class GameGeners {
  int? id;
  String? name;
  String? slug;
  int? gamesCount;
  String? imageBackground;
  GameGeners({
    this.id,
    this.name,
    this.slug,
    this.gamesCount,
    this.imageBackground,
  });

  GameGeners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }
}
