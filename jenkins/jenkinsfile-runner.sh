#!/bin/zsh -eu

#  clear down previous logs
# rm -rf jenkins/logs/

# run jenkins serverless job via docker (will download if not previously installed)
docker run --rm -it -v $HOSTPWD/jenkins/logs:/logs \
-v $HOSTPWD/jenkins/jenkinsfile:/workspace/Jenkinsfile \
-v $HOSTPWD:/kapitan-demo \
chr1slavery/jenkinsfile-runner:latest | tee jenkins/logs/logs.txt
