# SweatNotes

SweatNotes Readme.

To start local firebase emulators, run:

   ```bash
   firebase emulators:start --import=./seed
   ```
optionally, `--export-on-exit` can be specified to export the data to the `seed` folder.

## Bumping a version

To bump a version, run the following command:

```bash
./bump_version.sh <major|minor|patch|build>
```

## Automatic backups

Followed this [guide](https://fireship.io/snippets/firestore-automated-backups/), and made some changes to it according to the [official docs](https://github.com/google-github-actions/setup-gcloud).

TLDR: There's a Github action that performs automatic backups once a day (using Google cloud's service account) and stores them in a Google Cloud Storage bucket. The bucket is configured to delete backups older than 30 days.

The configuration can be found in the `.github/workflows/backup.yml` file.

## Troubleshooting

1. Try reinstalling packages, clearing and re-installing pods and building iOS for XCode-related issues:

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
