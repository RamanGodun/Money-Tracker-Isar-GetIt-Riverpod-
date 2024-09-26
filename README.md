# Money Tracker

## Overview

**Money Tracker** is a Flutter application designed to help users track their daily expenses, categorize them, and gain insights through intuitive charts and visualizations. The app provides a smooth and modern user experience by incorporating the best UI/UX practices.

### Author

- **Roman Godun**
- Copyright © 2024 Roman Godun. All rights reserved.

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
- **[Google Fonts](https://pub.dev/packages/google_fonts)**: To ensure consistency in typography across the application.
- **[intl](https://pub.dev/packages/intl)**: For internationalization and formatting dates and numbers.
- **[uuid](https://pub.dev/packages/uuid)**: For generating unique IDs for various app components.
- **Code Generation for Isar**: The app uses code generation to create models and manage schema for the Isar database, ensuring efficient data storage and retrieval, enabling the app to automatically handle complex database structures efficiently.

### Key Components

1. **UI Components**: Includes dynamic charts, custom dialogs, expense list items, and settings screens.
2. **State Management**: RiverPod is used throughout the app to manage state and dependencies, ensuring optimal performance and a clean codebase.
3. **Persistent Storage**: Isar DB is used for local storage of expenses, and SharedPreferences handles lightweight settings storage (e.g., theme preferences).
4. **Animations**: Flutter Hooks is used to add smooth and dynamic animations throughout the app, such as dialog transitions and list animations.

### Repository:

... https://github.com/RamanGodun/Money-Tracker-Isar-GetIt-Riverpod-.git

### License

Copyright © 2024 Roman Godun. All rights reserved.

This code is provided **for educational and reference purposes only**. Redistribution, modification, or use of the code **for commercial purposes** is strictly prohibited without the explicit written permission of the author.

### Support

For any issues or inquiries, please contact the author via email or open an issue on the project's GitHub repository.
