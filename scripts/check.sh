#!/usr/bin/env bash
# Build + link-check exactly like GitHub Actions (.github/workflows/pages-deploy.yml).
# Run this before pushing to catch a build failure locally instead of on GitHub.
# Run from the repo root: bash scripts/check.sh
set -e
cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1   # stops Git Bash from mangling the /site path on Windows

docker run --rm \
  -v "$(pwd):/site" \
  -v blog-gems:/usr/local/bundle \
  -w /site \
  ruby:3.3 bash -c '
    git config --global --add safe.directory /site
    bundle install --quiet
    JEKYLL_ENV=production bundle exec jekyll build -d /tmp/_site_check
    bundle exec htmlproofer /tmp/_site_check \
      --disable-external \
      --ignore-urls "/^http:\/\/127.0.0.1/,/^http:\/\/0.0.0.0/,/^http:\/\/localhost/"
  '

echo "OK — build and link check passed, safe to push."
