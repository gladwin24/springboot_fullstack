# Institutional Management System

A modern Flutter application for managing institutional services with a beautiful, sleek design.

## Features

- Modern dark theme UI with smooth animations
- Firebase backend integration
- Service management for:
  - Appointments
  - Accommodations
  - Hall Bookings
  - Payments
  - Ticket Bookings
  - Canteen Services
  - Transportation

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Firebase CLI
- FlutterFire CLI

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/institutional_management.git
cd institutional_management
```

2. Install dependencies:
```bash
flutter pub get
```

3. Set up Firebase:
```bash
firebase login
flutterfire configure
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── theme/                 # Theme configuration
├── services/             # Service pages and logic
├── models/               # Data models
└── firebase_options.dart  # Firebase configuration
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
