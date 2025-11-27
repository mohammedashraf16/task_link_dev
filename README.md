# task_link_dev

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)]()
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=Dart&logoColor=white)]()
[![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)]()
[![Kotlin](https://img.shields.io/badge/Kotlin-%230095D5.svg?style=for-the-badge&logo=Kotlin&logoColor=white)]()
[![Swift](https://img.shields.io/badge/Swift-%23F05138.svg?style=for-the-badge&logo=Swift&logoColor=white)]()
[![JSON](https://img.shields.io/badge/json-%23000000.svg?style=for-the-badge&logo=json&logoColor=white)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A new Flutter project.

## 🚀 Description

This Flutter project appears to be a starting point for a mobile application, potentially designed for both Android and iOS platforms, as well as web and desktop (macOS, Linux, Windows). Based on the code analysis, it incorporates features for managing categories, cities, and filters. The project also includes API consumption, caching mechanisms, and error handling, suggesting a data-driven application. The project implements the BLoC pattern for state management.

## 📌 Table of Contents

- [🚀 Description](#-description)
- [✨ Features](#-features)
- [🛠️ Tech Stack](#️-tech-stack)
- [📲 Installation](#-installation)
- [🎮 Usage](#-usage)
- [📂 Project Structure](#-project-structure)
- [🤝 Contributing](#-contributing)
- [📜 License](#-license)
- [📝 Footer](#-footer)

## ✨ Features

- **Category Management**: Fetches and displays categories, likely from a remote data source, with local caching.
- **City Management**: Fetches and displays cities, likely from a remote data source, with local caching.
- **Filtering**: Implements filtering functionality, allowing users to refine data based on specific criteria.
- **API Consumption**: Uses `dio` for making network requests to an API, with an abstraction layer for API consumption.
- **Local Caching**: Utilizes a caching mechanism (likely `shared_preferences`) to store and retrieve data locally.
- **Error Handling**: Includes custom exceptions and failure models for robust error handling.
- **Platform Support**: Supports multiple platforms including Android, iOS, Web, macOS, Linux, and Windows.
- **State Management:** Implements BLoC pattern for state management in Category, City, and Filter features.

## 🛠️ Tech Stack

- **Language**: Dart, Kotlin, Swift, C++
- **UI Framework**: Flutter
- **Web**: HTML, Javascript
- **Configuration**: YAML, JSON
- **Platforms**: Android, iOS, Web, macOS, Linux, Windows
- **Frameworks**: TypeScript, Bootstrap, Next.js

## 📲 Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/mohammedashraf16/task_link_dev.git
    cd task_link_dev
    ```

2.  **Install Flutter dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Install platform-specific dependencies (if necessary):**

    - **iOS**: `cd ios && pod install`

## 🎮 Usage

1.  **Run the Flutter application:**

    ```bash
    flutter run
    ```

2.  **Web:** The main entry point for the web application is `web/index.html`. This file bootstraps the Flutter web application.

3.  **Android/iOS:** Run the app using the flutter run command or by opening the respective platform projects in Android Studio or Xcode.

### Use Cases

- **Mobile App Development:** Building a cross-platform mobile application with features like category and city listings, and data filtering.

- **Web Application Development:** Deploying the same application to the web, leveraging Flutter's web support.

### How to use the project

-   **Exploring the UI:** Run the application on your desired platform and navigate through the home screen to view the category and city listings.

-   **Using the Filters:** Utilize the filter options available in the UI to refine the data based on your needs.

## 📂 Project Structure

```
.
├── android/
├── ios/
├── lib/
│   ├── config/
│   │   ├── app_router.dart
│   │   ├── router_transitions.dart
│   │   └── routes.dart
│   ├── core/
│   │   ├── connection/
│   │   │   └── network_info.dart
│   │   ├── database/
│   │   │   ├── api/
│   │   │   │   ├── api_consumer.dart
│   │   │   │   ├── dio_consumer.dart
│   │   │   │   └── end_points.dart
│   │   │   └── cache/
│   │   │       └── cache_helper.dart
│   │   ├── errors/
│   │   │   ├── error_model.dart
│   │   │   ├── exceptions.dart
│   │   │   └── failure.dart
│   │   └── services/
│   │       └── get_it_service.dart
│   ├── features/
│   │   ├── filter/
│   │   │   ├── data/
│   │   │   │   ├── data_source/
│   │   │   │   │   └── filter_remote_data_source.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── filter_model.dart
│   │   │   │   │   ├── sub_models/
│   │   │   │   │   │   ├── company_item.dart
│   │   │   │   │   │   ├── data_model.dart
│   │   │   │   │   │   ├── link_item.dart
│   │   │   │   │   │   └── pagination_model.dart
│   │   │   │   └── repos/
│   │   │   │       └── filter_repo_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── repos/
│   │   │   │   │   └── filter_repo.dart
│   │   │   │   └── usecases/
│   │   │   │       └── filter_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── manager/
│   │   │       │   ├── cubit/
│   │   │       │   │   ├── filter_cubit.dart
│   │   │       │   │   └── filter_state.dart
│   │   ├── home/
│   │   │   ├── data/
│   │   │   │   ├── data_sources/
│   │   │   │   │   ├── category_local_data_source.dart
│   │   │   │   │   ├── category_remote_data_source.dart
│   │   │   │   │   ├── city_local_data_source.dart
│   │   │   │   │   └── city_remote_data_source.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── category_model.dart
│   │   │   │   │   ├── city_model.dart
│   │   │   │   │   ├── sub_models/
│   │   │   │   │   │   ├── city_item.dart
│   │   │   │   │   │   └── data_model.dart
│   │   │   │   └── repos/
│   │   │   │       ├── category_repo_impl.dart
│   │   │   │       └── city_repo_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── repos/
│   │   │   │   │   ├── category_repo.dart
│   │   │   │   │   └── city_repo.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_category_usecase.dart
│   │   │   │       └── get_city_usecase.dart
│   │   │   └── presentation/
│   │   │   │   ├── manager/
│   │   │   │   │   ├── cubit/
│   │   │   │   │   │   ├── category_cubit.dart
│   │   │   │   │   │   ├── category_state.dart
│   │   │   │   │   │   ├── city_cubit.dart
│   │   │   │   │   │   └── city_state.dart
│   │   │   │   └── views/
│   │   │   │       ├── home_view.dart
│   │   │   │       └── widgets/
│   │   │   │           └── get_category_bloc_consumer.dart
│   ├── main.dart
├── linux/
├── macos/
├── pubspec.lock
├── pubspec.yaml
├── test/
│   └── widget_test.dart
├── web/
│   ├── index.html
│   └── manifest.json
└── windows/
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1.  Fork the repository
2.  Create a new branch for your feature or bug fix
3.  Make your changes
4.  Submit a pull request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](https://opensource.org/licenses/MIT) file for details.


## 📝 Footer

-   **Repository Name:** task_link_dev
-   **Repository URL:** [https://github.com/mohammedashraf16/task_link_dev](https://github.com/mohammedashraf16/task_link_dev)
-   **Author:** [Mohammed Ashraf](https://github.com/mohammedashraf16)
-   **Contact:** [mohammedashraf16@example.com](mailto:mohammedashraf16@example.com)

⭐️ Like this project? Fork, like, star, and raise issues!
