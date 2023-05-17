class Book {
  String id;
  String title;
  String subtitle;
  List<dynamic> authors;
  String publishedDate;
  String thumbnail;
  String previewLink;

  Book({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.publishedDate,
    required this.thumbnail,
    required this.previewLink,
  });

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'publishedDate': publishedDate,
      'thumbnail': thumbnail,
      'previewLink': previewLink
    };
  }

  factory Book.formJson(json) {
    return Book(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      authors: json['authors'],
      publishedDate: json['publishedDate'],
      thumbnail: json['thumbnail'],
      previewLink: json['previewLink'],
    );
  }
}
