#!/bin/bash

set -ueo pipefail

echo "--- system details"
uname -a
ruby -v
bundle --version

if [ -n "${CI_ENABLE_COVERAGE:-}" ]; then
  # Fetch token from vault ASAP so that long-running tests don't cause our vault token to expire
  echo "--- installing vault"
  export VAULT_VERSION=1.9.3
  export VAULT_HOME=$HOME/vault
  curl --create-dirs -sSLo $VAULT_HOME/vault.zip https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_${VAULT_VERSION}_linux_amd64.zip
  unzip -o $VAULT_HOME/vault.zip -d $VAULT_HOME

  echo "--- fetching Sonar token from vault"
  export SONAR_TOKEN=$($VAULT_HOME/vault kv get -field token secret/inspec/sonar)
fi

echo "--- bundle install"
bundle config set --local without tools maintenance deploy
bundle install --jobs=7 --retry=3

echo "+++ bundle exec rake lint"
bundle exec rake lint

echo "+++ bundle exec rake test"
bundle exec rake test
RAKE_EXIT=$?

# If coverage is enabled, then we need to pick up the coverage/coverage.json file
if [ -n "${CI_ENABLE_COVERAGE:-}" ]; then
  echo "--- installing sonarscanner"
  export SONAR_SCANNER_VERSION=4.6.2.2472
  export SONAR_SCANNER_HOME=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-linux
  curl --create-dirs -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip
  unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
  export PATH=$SONAR_SCANNER_HOME/bin:$PATH
  export SONAR_SCANNER_OPTS="-server"

  echo "--- moving coverage report"
  ls -l coverage/coverage.json
  mv coverage/coverage.json coverage/.resultset.json
  ls -l coverage/.resultset.json

  echo "--- running sonarscanner"
  sonar-scanner \
  -Dsonar.organization=inspec \
  -Dsonar.projectKey=inspec_inspec-aws \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://sonarcloud.io
fi

exit $RAKE_EXIT
