# SweatNotes

SweatNotes is a gym progress tracking app designed for efficiency and insight. The goal is to allow you to log your workout progress quickly and easily track improvements over time. SweatNotes features color-coded grids to visualize your performance, highlighting sets where you've improved or underperformed compared to previous sessions. It also tracks rest times between sets, helping you optimize your workout routine. You can fully customize the app’s appearance, including color schemes and toggling emoji markers for exercises. An in-app tutorial provides guidance to help you get the most out of SweatNotes.

Download now from the [App Store](https://apps.apple.com/us/app/sweatnotes/id6446651996).

Demo:

https://github.com/user-attachments/assets/d4c39d36-5dd0-4403-888f-77ce18a87275

---

## Development Notes

### To start local firebase emulators, run:

   ```bash
   firebase emulators:start --import=./seed
   ```

optionally, `--export-on-exit` can be specified to export the data to the `seed` folder.

### Releasing

Instructions for releasing a new version of the app.

1. Push the firestore rules to production (
   see [Pushing firestore rules](#1-pushing-firestore-rules)).
2. Bump the version in `pubspec.yaml` and `ios/Runner/Info.plist` (
   see [Bumping a version](#2-bumping-a-version)).
3. Build the app (see [Building the app](#3-building-the-app)).
4. Upload it with the Transporter app and create a release in appstoreconnect.apple.com (
   see [Uploading the app](#4-uploading-the-app)).
5. Create a git tag named `vX.Y.Z+<build>` (where `X.Y.Z` is the version number and `<build>` is the
   build number) and push it to the remote. (see [Creating a git tag](#5-creating-a-git-tag)).
6. Create a new release on Github, and upload the built app to it.

### 1. Pushing firestore rules

To push the firestore rules to production, run the following command:

```bash
firebase deploy --only firestore:rules
```

### 2. Bumping a version

To bump a version, run the following command:

```bash
./bump_version.sh <major|minor|patch|build>
```

### 3. Building the app

to build the app, run the following command:

```bash
flutter build ipa
```

### 4. Uploading the app

To upload the app simply drag and drop it into the Transporter app.

Next, go
to [appstoreconnect.apple.com](https://appstoreconnect.apple.com/apps/6446651996/appstore/ios/version/deliverable)
and create a new release (you might need to wait for a bit until the new build appears).

Add changelogs and submit.

### 5. Creating a git tag

Git tag will actually be auto-generated during the version bump. So you'll just need to push
it: `git push --tags`.

Alternatively if it's not created, run the following command to create the tag:

```bash
git tag vX.Y.Z+<build>
```

## Automatic backups

Followed this [guide](https://fireship.io/snippets/firestore-automated-backups/), and made some
changes to it according to
the [official docs](https://github.com/google-github-actions/setup-gcloud).

TLDR: There's a Github action that performs automatic backups once a day (using Google cloud's
service account) and stores them in a Google Cloud Storage bucket. The bucket is configured to
delete backups older than 30 days.

The configuration can be found in the `.github/workflows/backup.yml` file.

## Troubleshooting

1. Try reinstalling packages, clearing and re-installing pods and building iOS for XCode-related
   issues:

    ```bash
    flutter clean
    flutter pub get
    rm -rf Pods
    rm -rf ~/Library/Caches/CocoaPods
    arch -x86_64 pod update --repo-update
    ```

2. More in depth cleanup:

    ```bash
    cd ios
    sudo gem update cocoapods
    
    # Delete the build cache
    flutter clean
    
    # Delete `Podfile.lock`
    rm Podfile.lock
    
    # Delete the `Pods/` folder as well
    rm -rf Pods/
    
    # Install the Flutter package dependencies
    flutter pub get
    
    # Install the iOS pod dependencies
    arch -x86_64 pod install
    
    # Update your local pods
    arch -x86_64 pod update
    ```
