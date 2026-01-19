# Book Library (Flutter + GetX)

A mobile book library app built with Flutter using GetX for state management and MVC-style folder structure. It loads an initial list of “already read” books, lets you toggle read/unread status locally, and provides search powered by the Open Library search API.

## Features
- Home list from `https://openlibrary.org/people/mekBot/books/already-read.json` (20+ items)
- Card UI showing cover, title, author, year, and a toggleable status button
- Search by title via `https://openlibrary.org/search.json?title={query}`
- Image caching via `cached_network_image`
- GetX controllers for state, services for networking, models for parsing both APIs

## Project Structure
- `lib/models` – data models
- `lib/controllers` – GetX controllers
- `lib/services` – API clients
- `lib/views` – screens (Home, Search)
- `lib/widgets` – shared UI widgets (book cards, etc.)

## Getting Started
```bash
cd book_library
flutter pub get
flutter run
```

## Screenshots
- Add your screenshots in this section once available.

## Notes
- Book status toggles locally only (no remote persistence).
- Requires Flutter SDK installed and a connected device/emulator to run.
