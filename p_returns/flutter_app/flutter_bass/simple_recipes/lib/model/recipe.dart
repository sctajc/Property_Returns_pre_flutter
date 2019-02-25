import 'package:duration/duration.dart';

enum RecipeType {
  food,
  drink,
}

class Recipe {
  String get getDurationString => prettyDuration(this.duration);

  final String id;
  final RecipeType type;
  final String name;
  final Duration duration;
  final List<String> ingredients;
  final List<String> preparation;
  final String imageURL;

  const Recipe({
    this.id,
    this.type,
    this.name,
    this.duration,
    this.ingredients,
    this.preparation,
    this.imageURL,
  });
}
