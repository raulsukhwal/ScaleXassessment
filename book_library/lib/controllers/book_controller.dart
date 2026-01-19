import 'package:get/get.dart';

import '../models/book.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  BookController({BookService? service}) : _service = service ?? BookService();

  final BookService _service;

  final RxList<Book> books = <Book>[].obs;
  final RxList<Book> searchResults = <Book>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAlreadyReadBooks();
  }

  Future<void> fetchAlreadyReadBooks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetched = await _service.fetchAlreadyReadBooks();
      books.assignAll(fetched);
    } catch (e) {
      errorMessage.value = 'Failed to load books. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isSearching.value = true;
      searchError.value = '';
      final fetched = await _service.searchBooks(query.trim());
      searchResults.assignAll(fetched);
    } catch (e) {
      searchError.value = 'Unable to fetch search results.';
    } finally {
      isSearching.value = false;
    }
  }

  void toggleBookStatus(Book book, {bool fromSearch = false}) {
    final list = fromSearch ? searchResults : books;
    final index = list.indexWhere((b) => b.id == book.id && b.title == book.title);
    if (index == -1) return;

    final updated = list[index].copyWith(isRead: !list[index].isRead);
    list[index] = updated;
  }
}
