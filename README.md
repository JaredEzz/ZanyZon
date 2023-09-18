# ZanyZon Chrome Extension

ZanyZon is a Chrome extension that seamlessly adds a bit of amusement to your usual Amazon shopping experience by inserting humorous, bogus information into your Amazon URLs, while keeping the link entirely functional.

## Features

- **URL Transformation**: It alters Amazon URLs to contain comedic elements.
- **Keeps Original Functionality**: Although altered, every URL still works as expected.

## Getting Started

This project is built using Flutter and requires Flutter SDK and Dart for development.

### Prerequisites

- Chrome Browser: Make sure you have a compatible version of Chrome as your browser (any chromium browser that supports extensions will do).
- Flutter SDK: Install Flutter SDK from https://flutter.dev/docs/get-started/install. Ensure you also have the Dart SDK installed (comes with Flutter).

### Installation

1. Clone this repository.
   
```sh
git clone https://github.com/your_username_/ZanyZon.git
```

2. Install Flutter packages.

```sh
flutter pub get
```

3. Build the project.

```sh
flutter build web --web-renderer html --csp
```

## Loading the Extension to Chrome

1. After building the project, compress the `build/web` directory to a `.zip` file.
2. Download the `.zip` file to your local system.
3. Unzip/Extract the files from the `.zip` file.
4. Open the Chrome Browser and navigate to `chrome://extensions/`.
5. Ensure "Developer mode" is enabled (toggle switch at the top-right).
6. Click on "Load unpacked extension" and navigate to the directory where you unzipped the files. Select the unzipped folder.

## Usage

Navigate to any Amazon page, and watch ZanyZon transform your shopping experience!

## Contributing

Contributions are greatly appreciated. To contribute:

1. Fork the project.
2. Create your feature branch `git checkout -b feature/AmazingFeature`
3. Commit your changes `git commit -m 'Added some AmazingFeature'
4. Push to the branch `git push origin feature/AmazingFeature`
5. Open a pull request.

## License

Distributed under the MIT License. See `LICENSE` for more information.
