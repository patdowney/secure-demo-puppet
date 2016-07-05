#!/bin/bash
set -xe

PACKAGE_MAINTAINER="pat.downey@gmail.com"
PACKAGE_URL="https://github.com/patdowney/secure-demo-puppet"
PACKAGE_TYPE="deb"

bundle install --path vendor/bundle --binstubs .bundle/bin

bundle exec librarian-puppet package --strip-dot-git --path=vendor/modules --verbose
bundle exec librarian-puppet install --local --strip-dot-git --path=vendor/modules --verbose

bundle exec puppet-lint --no-80chars-check --fail-on-warnings --with-context --with-filename modules
bundle exec puppet-lint --no-80chars-check --fail-on-warnings --with-context --with-filename manifests

VERSION=${TRAVIS_BUILD_NUMBER:-0}

PACKAGE_NAME=${PACKAGE_NAME:-$(basename `pwd`)}

mkdir -p .output
rm -rf .output/*

bundle exec  fpm -t ${PACKAGE_TYPE} -s dir \
  --prefix /usr/share/${PACKAGE_NAME} \
  --package ".output/${PACKAGE_NAME}_${VERSION}_all.${PACKAGE_TYPE}" \
  --name "${PACKAGE_NAME}" \
  --version "${VERSION}" \
  --depends 'puppet' \
  --architecture all \
  --maintainer "$PACKAGE_MAINTAINER" \
  --url $PACKAGE_URL \
  --deb-user root \
  --deb-group root \
  --verbose \
  bin/ \
  manifests/ \
  $(find modules/ -name files -or -name lib -or -name manifests -or -name templates) \
  $(find vendor/modules/ -name files -or -name lib -or -name manifests -or -name templates)
