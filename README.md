# fipi_client

Flutter Android client for working with FIPI question data.

Maintained by `nkstr.ru`.

## Requirements

- Flutter `3.35.7`
- Dart `3.9.2`
- Java `17`
- Android SDK

## Local Development

Install dependencies:

```bash
flutter pub get
```

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## Android Release Signing

Android release builds require these local files:

- `android/key.properties`
- `android/app/release.jks`

Both files are intentionally ignored by git and must not be committed.

`android/key.properties` uses this format:

```properties
storePassword=...
keyPassword=...
keyAlias=fipi_client_release
storeFile=app/release.jks
```

## CI And Releases

GitHub Actions runs CI on pull requests and pushes to `main`.

Tagged releases are created from Git tags matching `v*`, for example `v1.2.3`.

Nightly prereleases are created from `main` and named as:

```text
fipi_client.YYYY-MM-DD.<shortsha>
```

## License

This project is licensed under the [MIT License](LICENSE).
