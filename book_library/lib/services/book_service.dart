import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/book.dart';

class BookService {
  static const _alreadyReadUrl = 'https://openlibrary.org/people/mekBot/books/already-read.json';
  static const _searchBaseUrl = 'https://openlibrary.org/search.json';

  Future<List<Book>> fetchAlreadyReadBooks() async {
    final response = await http.get(Uri.parse(_alreadyReadUrl));
    if (response.statusCode != 200) {
      throw Exception('Unable to fetch books');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final entries = data['reading_log_entries'] as List<dynamic>? ?? [];
    final books = entries
        .map((entry) => Book.fromAlreadyRead(entry as Map<String, dynamic>))
        .where((book) => book.title.isNotEmpty)
        .toList();
    return books;
  }

  Future<List<Book>> searchBooks(String query) async {
    final uri = Uri.parse('$_searchBaseUrl?title=$query');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Search failed');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final docs = data['docs'] as List<dynamic>? ?? [];
    final books = docs
        .map((doc) => Book.fromSearch(doc as Map<String, dynamic>))
        .where((book) => book.title.isNotEmpty)
        .take(30)
        .toList();
    return books;
  }
}
