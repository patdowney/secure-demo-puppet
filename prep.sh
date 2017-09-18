#!/bin/bash
set -xe

bundle install --path vendor/bundle --binstubs .bundle/bin

bundle exec librarian-puppet package --strip-dot-git --path=vendor/modules --verbose
bundle exec librarian-puppet install --local --strip-dot-git --path=vendor/modules --verbose
