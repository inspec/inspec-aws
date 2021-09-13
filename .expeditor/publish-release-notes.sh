#!/bin/bash

set -eou pipefail

PRODUCT=inspec-aws
CURRENTDATE=$(date +"%m-%d-%Y")

git clone "https://x-access-token:${GITHUB_TOKEN}@github.com/inspec/inspec-aws.wiki.git"

pushd ./inspec-aws.wiki
  # Publish release notes to S3
  aws s3 cp Pending-Release-Notes.md "s3://chef-automate-artifacts/release-notes/${PRODUCT}/${CURRENTDATE}.md" --acl public-read --content-type "text/plain" --profile chef-cd

  # Reset "Release Notes" wiki page
  cat >./Pending-Release-Notes.md <<EOH
## New AWS Cloud Resources
-
## Improvements
-
## Bug Fixes
-
EOH

  # Push changes back up to GitHub
  git add .
  git commit -m "Release Notes for published release ${CURRENTDATE}"
  git push origin master
popd

rm -rf inspec-aws.wiki
