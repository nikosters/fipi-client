# Release Guide

## Tagged Releases

Create and push a release tag:

```bash
git tag v1.2.3
git push origin v1.2.3
```

Tags matching `v*` create signed release APKs.

## Required GitHub Secrets

- `ANDROID_RELEASE_KEYSTORE_BASE64`
- `ANDROID_RELEASE_STORE_PASSWORD`
- `ANDROID_RELEASE_KEY_PASSWORD`
- `ANDROID_RELEASE_KEY_ALIAS`

`ANDROID_RELEASE_KEYSTORE_BASE64` is the base64 content of `android/app/release.jks`.

## Nightly Releases

Nightly prereleases are created from `main` and use this name, tag, and APK basename:

```text
fipi_client.YYYY-MM-DD.<shortsha>
```

The date is computed in UTC inside GitHub Actions.

## Missing Signing Secret Recovery

If a release workflow fails because a signing secret is missing:

1. Confirm the local `android/app/release.jks` and `android/key.properties` files exist.
2. Re-create the missing GitHub secret from the local release key material.
3. Re-run the failed workflow.

Do not generate a new release keystore unless the existing release key is intentionally being rotated.
