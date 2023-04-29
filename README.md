# SweatNotes

SweatNotes Readme.

## Bumping a version

To bump a version, run the following command:

```bash
./bump_version.sh <major|minor|patch|build>
```

## Automatic backups

Followed this guide: https://fireship.io/snippets/firestore-automated-backups/

TLDR: There's a Github action that performs automatic backups once a day (using Google cloud's service account) and stores them in a Google Cloud Storage bucket. The bucket is configured to delete backups older than 30 days.

The configuration can be found in the `.github/workflows/backup.yml` file.
