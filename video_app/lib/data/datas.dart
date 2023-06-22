import 'package:video_app/domain/model.dart';

/// Manual Generated Data
Model data = Model(name: "Welcome", assetPath: "opening.mp4", childrens: [
  Model(name: "Tiger", assetPath: "Tiger.mp4", childrens: _birds),
  Model(name: "Leopard", assetPath: "leopard.mp4", childrens: _birds),
  Model(name: "Lion", assetPath: "Lion.mp4", childrens: _birds),
]);
List<Model> _birds = [
  Model(name: "Parrot", assetPath: "Parrot.mp4", childrens: []),
  Model(name: "Peacock", assetPath: "Peacock.mp4", childrens: []),
  Model(name: "Butterfly", assetPath: "Butterfly.mp4", childrens: []),
  Model(name: "Owl", assetPath: "owl.mp4", childrens: []),
];
