# Sheba App

## Overview
The Sheba App is a Flutter mobile application designed for civic services, allowing users to report community issues and verify asset security. It connects to a Supabase backend for data storage and management.

## Project Structure
```
sheba_app/
├── lib/
│   ├── main.dart                # App entry point + Supabase initialization
│   └── supabase_config.dart      # Supabase client configuration
├── supabase/
│   └── migrations/
│       └── 001_create_reports_table.sql  # SQL migration for reports table
├── assets/                       # Image assets (existing)
├── pubspec.yaml                  # Dependencies
├── android/                      # Android platform files
├── ios/                          # iOS platform files
└── README.md                     # Project documentation
```

## Getting Started

### Prerequisites
- Flutter SDK installed on your machine.
- A Supabase account and project set up.

### Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   cd sheba_app
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Run the application:
   ```
   flutter run
   ```

### Supabase Configuration
- Update the `lib/supabase_config.dart` file with your Supabase URL and Anon Key:
  ```dart
  import 'package:supabase_flutter/supabase_flutter.dart';

  class SupabaseConfig {
    static final SupabaseClient client = SupabaseClient(
      'YOUR_SUPABASE_URL',
      'YOUR_SUPABASE_ANON_KEY',
    );
  }
  ```

### Database Migration
- The SQL migration to create the `reports` table can be found in `supabase/migrations/001_create_reports_table.sql`:
  ```sql
  CREATE TABLE reports (
    id SERIAL PRIMARY KEY,
    category VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    photo_url VARCHAR
  );
  ```

### Features
- **Civic Report**: Users can submit reports with category, title, description, location, and photo.
- **Asset Check**: Users can verify the security status of assets.

### Dependencies
Add the following dependencies to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^0.2.0
  google_fonts: ^6.1.0
  image_picker: ^1.0.7
```

### Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

### License
This project is licensed under the MIT License. See the LICENSE file for details.