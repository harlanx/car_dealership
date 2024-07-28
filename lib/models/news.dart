class News {
  News({
    required this.headline,
    required this.description,
    this.image,
    this.url = '',
    this.content = '',
  });

  final String headline;
  final String description;
  final String? image;
  final String url;
  final String content;
}
