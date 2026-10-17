#!/usr/bin/env bash
# Live preview at http://localhost:4000 — rebuilds automatically when you save a file.
# Run from the repo root: bash scripts/serve.sh
set -e
cd "$(dirname "$0")/.."
export MSYS_NO_PATHCONV=1   # stops Git Bash from mangling the /site path on Windows

docker run --rm -it \
  -v "$(pwd):/site" \
  -v blog-gems:/usr/local/bundle \
  -w /site -p 4000:4000 \
  ruby:3.3 bash -c "bundle install && bundle exec jekyll serve -H 0.0.0.0 --force_polling"
