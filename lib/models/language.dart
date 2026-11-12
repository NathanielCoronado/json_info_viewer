/// Model class that represents ONE record from languages.json.
class Language {
  final int id;
  final String name;
  final String creator;
  final int year;
  final String type;
  final String usedFor;
  final String image; // path to the local image asset
  final String description;

  const Language({
    required this.id,
    required this.name,
    required this.creator,
    required this.year,
    required this.type,
    required this.usedFor,
    required this.image,
    required this.description,
  });

  /// Converts a JSON map (one record) into a Language object.
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'] as int,
      name: json['name'] as String,
      creator: json['creator'] as String,
      year: json['year'] as int,
      type: json['type'] as String,
      usedFor: json['usedFor'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );
  }
}
