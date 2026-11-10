# Pocket Pantry

Pocket Pantry is a small, offline-first iOS app for tracking pantry items and
their expiration dates. It is built with SwiftUI and stores data locally with
SwiftData. The project does not require an account, network service, API key or
other external dependency.

## Features

- Add, edit and delete pantry items.
- Track category, quantity and expiration date.
- See clear status indicators for expired and soon-to-expire items.
- Search items and filter them by expiration status.
- Review item details in a dedicated screen.
- Use VoiceOver-friendly labels and Dynamic Type-compatible layouts.

## Requirements

- Xcode 16 or later
- iOS 17 or later

## Getting started

1. Clone the repository.
2. Open `PocketPantry.xcodeproj` in Xcode.
3. Select the `PocketPantry` scheme and an iOS simulator.
4. Build and run the app.

The app creates a few sample items on first launch so its main states are easy
to explore. All changes remain on the device or simulator.

## Tests

Run the `PocketPantry` scheme tests in Xcode with **Product > Test**.

## Privacy

Pocket Pantry does not collect or transmit user data. Do not add secrets,
credentials, signing certificates or provisioning profiles to the repository.

## License

This project is available under the MIT License. See [LICENSE](LICENSE).

