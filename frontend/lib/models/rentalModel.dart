class Rental {
  final String name;
  final String imageUrl;
  final String description;
  final double price;

  final double lat;
  final double long;

  Rental({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.lat,
    required this.long,
  });
}
