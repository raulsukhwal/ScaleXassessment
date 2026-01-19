class Book {
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.coverId,
    required this.isRead,
  });

  final String id;
  final String title;
  final String author;
  final int? publishedYear;
  final int? coverId;
  final bool isRead;

  String? get coverImageUrl =>
      coverId != null ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg' : null;

  Book copyWith({
    String? id,
    String? title,
    String? author,
    int? publishedYear,
    int? coverId,
    bool? isRead,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publishedYear: publishedYear ?? this.publishedYear,
      coverId: coverId ?? this.coverId,
      isRead: isRead ?? this.isRead,
    );
  }

  factory Book.fromAlreadyRead(Map<String, dynamic> json) {
    final work = json['work'] as Map<String, dynamic>? ?? {};
    final authors = work['author_names'] as List<dynamic>?;
    return Book(
      id: (work['key'] ?? '') as String,
      title: (work['title'] ?? 'Untitled') as String,
      author: authors != null && authors.isNotEmpty ? authors.first.toString() : 'Unknown',
      publishedYear: work['first_publish_year'] as int?,
      coverId: work['cover_id'] as int?,
      isRead: true,
    );
  }

  factory Book.fromSearch(Map<String, dynamic> json) {
    final authors = json['author_name'] as List<dynamic>?;
    return Book(
      id: (json['key'] ?? json['cover_edition_key'] ?? '') as String,
      title: (json['title'] ?? 'Untitled') as String,
      author: authors != null && authors.isNotEmpty ? authors.first.toString() : 'Unknown',
      publishedYear: json['first_publish_year'] as int?,
      coverId: json['cover_i'] as int?,
      isRead: false,
    );
  }
}
