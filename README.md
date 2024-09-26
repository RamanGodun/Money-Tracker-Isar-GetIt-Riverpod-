# Money Tracker

## Overview

**Money Tracker** is a Flutter application designed to help users track their daily expenses, categorize them, and gain insights through intuitive charts and visualizations. The app provides a smooth and modern user experience by incorporating the best UI/UX practices.

### Author

- **Roman Godun**
- © 2024 All rights reserved.

## Features

- **Track Expenses**: Easily log and track your daily expenses.
- **Categorization**: Categorize your expenses into predefined groups such as food, transport, leisure, and more.
- **Charts & Analytics**: Visualize your spending habits through dynamic charts, showing expenses by category and over time.
- **Dark & Light Themes**: Choose between light and dark themes based on your preference, with settings persisted across app restarts.

## Architecture & Technologies

This application follows a **Clean Architecture** approach, which separates the data, domain, and presentation layers for better maintainability and scalability.

### Technologies Used

- **[Isar DB](https://isar.dev/)**: Efficient and schema-based local storage to manage user data and expenses.
- **[RiverPod](https://riverpod.dev/)**: A state management solution used for dependency injection, and managing global application state.
- **[GetIt](https://pub.dev/packages/get_it)**: A service locator pattern used to manage global services such as database services, shared preferences, and more.
- **[Flutter Hooks](https://pub.dev/packages/flutter_hooks)**: Utilized to manage animations and state within widgets, especially for memoization and the widget lifecycle.
- **[SharedPreferences](https://pub.dev/packages/shared_preferences)**: Used to store persistent settings such as theme mode, so user preferences are saved between app sessions.
- **Material & Cupertino UI Elements**: A mix of Material and Cupertino design is used to ensure a modern, responsive UI experience across both iOS and Android platforms.

### Key Components

1. **UI Components**: Includes dynamic charts, custom dialogs, expense list items, and settings screens.
2. **State Management**: RiverPod is used throughout the app to manage state and dependencies, ensuring optimal performance and a clean codebase.
3. **Persistent Storage**: Isar DB is used for local storage of expenses, and SharedPreferences handles lightweight settings storage (e.g., theme preferences).
4. **Animations**: Flutter Hooks is used to add smooth and dynamic animations throughout the app, such as dialog transitions and list animations.

## Getting Started

To get started with Money Tracker, clone the repository and follow the instructions below.

### Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed. You can download it from [flutter.dev](https://flutter.dev/docs/get-started/install).
- **Dart**: Make sure you have the Dart SDK set up, which comes bundled with Flutter.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/money_tracker.git
   ```

### License

This application is proprietary software. All rights are reserved © 2024 by Roman Godun. Redistribution and use in source or binary forms, with or without modification, are not permitted without explicit written permission from the author.

### Support

For any issues or inquiries, please contact the author via email or open an issue on the project's GitHub repository.
