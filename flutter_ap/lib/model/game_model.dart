class GamesModel {
  int? id;
  String? slug;
  String? name;
  String? released;
  bool? tba;
  String? backgroundImage;
  double? rating;
  int? ratingTop;
  int? ratingsCount;
  int? reviewsTextCount;
  int? added;
  int? metacritic;
  int? playtime;
  int? suggestionsCount;
  String? updated;
  int? reviewsCount;
  String? saturatedColor;
  String? dominantColor;
  List<Genres>? genres;
  List<ShortScreenshots>? shortScreenshots;
  String? description;

  GamesModel(
      {this.id,
      this.slug,
      this.name,
      this.released,
      this.tba,
      this.backgroundImage,
      this.rating,
      this.ratingTop,
      this.ratingsCount,
      this.reviewsTextCount,
      this.added,
      this.metacritic,
      this.playtime,
      this.suggestionsCount,
      this.updated,
      this.reviewsCount,
      this.saturatedColor,
      this.dominantColor,
      this.genres,
      this.shortScreenshots});

  GamesModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    released = json['released'];
    tba = json['tba'];
    backgroundImage = json['background_image'];
    rating = json['rating'];
    ratingTop = json['rating_top'];
    ratingsCount = json['ratings_count'];
    reviewsTextCount = json['reviews_text_count'];
    added = json['added'];
    metacritic = json['metacritic'];
    playtime = json['playtime'];
    suggestionsCount = json['suggestions_count'];
    updated = json['updated'];
    reviewsCount = json['reviews_count'];
    saturatedColor = json['saturated_color'];
    dominantColor = json['dominant_color'];
    description = json['description'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    if (json['short_screenshots'] != null) {
      shortScreenshots = <ShortScreenshots>[];
      json['short_screenshots'].forEach((v) {
        shortScreenshots!.add(ShortScreenshots.fromJson(v));
      });
    }
  }
}

class Genres {
  int? id;
  String? name;
  String? slug;
  int? gamesCount;
  String? imageBackground;

  Genres(
      {this.id, this.name, this.slug, this.gamesCount, this.imageBackground});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }
}

class ShortScreenshots {
  int? id;
  String? image;

  ShortScreenshots({this.id, this.image});

  ShortScreenshots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
