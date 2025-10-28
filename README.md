# Movie Browser App

This is a Flutter project that showcases a movie browsing application, built with a focus on clean architecture, Riverpod for state management, and GoRouter for navigation.

## Features

*   Browse popular movies.
*   Search for movies.
*   View movie details.
*   Save Movies Locally (Favorites).

## Architecture

The project follows a **Feature-First Layered Architecture** to promote modularity and maintainability.

*   **Data Layer:** Handles API interactions and data retrieval.
*   **Domain Layer:** Contains core business logic and data models (e.g., `Movie`).
*   **Presentation Layer:** Manages UI (Widgets/Screens) and state (Riverpod Notifiers/Providers).

## Libraries Used

*   **`flutter_riverpod`**: For robust and scalable state management.
*   **`go_router`**: For declarative and URL-based navigation.
*   **`http`**: For making network requests to the TMDB API.
*   **`cached_network_image`**: For efficient loading and caching of network images.
*   **`envied`**: For secure management of API keys.
*   **`intl`**: For internationalization and date formatting.

## Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/gschlaen/movie_browser_app.git
    cd movie_browser_app
    ```

2.  **Install Flutter dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Set up API Key:**
    This project uses the [The Movie Database (TMDB) API](https://www.themoviedb.org/). You'll need to obtain an API key from their website.

    Create a `.env` file in the root of the project and add your API key:
    ```
    TMDB_API_KEY=YOUR_API_KEY_HERE
    ```
    **Note:** The `.env` file is already included in `.gitignore` to prevent it from being committed to version control.

    **Run the envied_generator to generate de API Key:**
    ```bash
    dart pub add envied dev:envied_generator dev:build_runner
    ```

4.  **Run the application:**
    ```bash
    flutter run
    ```

## Future Improvements

If I had more time, I would focus on the following enhancements:

*   **Theme Switching:** Add a theme provider to allow users to switch between light and dark modes.
*   **Unit and Widget Test Coverage:** Implement comprehensive unit and widget tests to ensure the reliability and correctness of the application.
*   **Error Handling:** Implement a more sophisticated error-handling strategy with dedicated error widgets and user-friendly messages.
*   **Offline Support:** Enhance local caching to not just save favorites, but also cache popular movies to reduce API calls and provide offline support.
*   **Profile Screen:** Implement the "Profile" screen with user-specific information or settings.
*   **Pagination:** Implement pagination for popular movies and search results.
*   **Debounce in Movie Search:** Implement a debounce mechanism to the movie search to avoid triggering API calls on every keystroke.