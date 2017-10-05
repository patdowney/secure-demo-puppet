#!/bin/bash
set -xe

find manifests modules -type f -name '*.pp' | xargs bundle exec puppet parser validate

bundle exec puppet-lint --no-80chars-check --no-140chars-check --fail-on-warnings --with-context --fix --with-filename modules
bundle exec puppet-lint --no-80chars-check --no-140chars-check --fail-on-warnings --with-context --fix --with-filename manifests
