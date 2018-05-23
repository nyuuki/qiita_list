#!/bin/bash
#################################################
# based on https://github.com/Sagacify/ci-tools
#################################################

SONAR_VERSION="sonar-scanner-cli-3.0.3.778"
SONAR_DIR="sonar-scanner-3.0.3.778"

wget -P $HOME -N "https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/${SONAR_VERSION}.zip"
unzip -d $HOME $HOME/$SONAR_VERSION.zip

DEFAULT_SONAR_PARAMS="-Dsonar.projectKey=$CIRCLE_PROJECT_REPONAME \
                        -Dsonar.login=$SONAR_TOKEN \
                        -Dsonar.projectName=$CIRCLE_PROJECT_REPONAME \
                        -Dsonar.projectVersion=$CIRCLE_BUILD_NUM \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.sourceEncoding=UTF-8 \
                        -Dsonar.sources=."

if [ -n "$CI_PULL_REQUEST" ]; then
  if [ "$CIRCLE_BRANCH" != "staging" ] & [ "$STAGING_EXISTS" ]; then
    SONAR_PROJECT_KEY=$CIRCLE_PROJECT_USERNAME:$CIRCLE_PROJECT_REPONAME:staging
  else
    SONAR_PROJECT_KEY=$CIRCLE_PROJECT_USERNAME:$CIRCLE_PROJECT_REPONAME
  fi

  echo "Preview analyzing ${CI_PULL_REQUEST} by SonarQube Github Plugin"
  $HOME/$SONAR_DIR/bin/sonar-scanner $DEFAULT_SONAR_PARAMS \
    -Dsonar.projectKey=$SONAR_PROJECT_KEY \
    -Dsonar.github.repository=$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME \
    -Dsonar.github.pullRequest=${CI_PULL_REQUEST##*/} \
    -Dsonar.github.oauth=$GITHUB_TOKEN \
    -Dsonar.github.endpoint="https://api.github.com" \
    -Dsonar.analysis.mode=preview;
fi

if [ "$CIRCLE_BRANCH" == "master" ]; then
    echo "Analyzing ${CIRCLE_BRANCH} branch to push issues to SonarQube server"
    ls -l $HOME/$SONAR_DIR/bin/
    chmod +x $HOME/$SONAR_DIR/bin/sonar-scanner
    sed -i s/sh/bash/g $HOME/$SONAR_DIR/bin/sonar-scanner
    $HOME/$SONAR_DIR/bin/sonar-scanner $DEFAULT_SONAR_PARAMS \
    -Dsonar.projectKey=$CIRCLE_PROJECT_USERNAME:$CIRCLE_PROJECT_REPONAME -X;
elif [ "$CIRCLE_BRANCH" == "staging" ]; then
    echo "Analyzing ${CIRCLE_BRANCH} branch to push issues to SonarQube server"
    $HOME/$SONAR_DIR/bin/sonar-scanner $DEFAULT_SONAR_PARAMS \
    -Dsonar.projectKey=$CIRCLE_PROJECT_USERNAME:$CIRCLE_PROJECT_REPONAME:staging;
fi