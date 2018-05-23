#!/bin/bash

SONAR_VERSION="sonar-scanner-cli-3.0.3.778"
SONAR_DIR="sonar-scanner-3.0.3.778"

wget -P $HOME -N "https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/${SONAR_VERSION}.zip"
unzip -d $HOME $HOME/$SONAR_VERSION.zip

SONAR_PARAMS="-Dsonar.projectKey=$CIRCLE_PROJECT_REPONAME \
            -Dsonar.login=$SONAR_TOKEN \
            -Dsonar.projectName=$CIRCLE_PROJECT_REPONAME \
            -Dsonar.projectVersion=$CIRCLE_BUILD_NUM \
            -Dsonar.host.url=https://sonarcloud.io \
            -Dsonar.sourceEncoding=UTF-8 \
            -Dsonar.organization=$SONAR_ORG \
            -Dsonar.sources=. \
             Dsonar.github.oauth=$GITHUB_TOKEN \
            -Dsonar.github.endpoint='https://api.github.com' \
            -Dsonar.github.repository=$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME \
            -Dsonar.projectKey=$SONAR_PJKEY \
            -Dsonar.analysis.mode=preview;"

$HOME/$SONAR_DIR/bin/sonar-scanner $SONAR_PARAMS
