/// Model for the Data
class Model {
  /// Name of video
  String name;

  /// Video file name
  String assetPath;

  /// Next available Models
  List<Model> childrens;
  Model({
    required this.name,
    required this.assetPath,
    required this.childrens,
  });
}
