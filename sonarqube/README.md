# sonarqube

## Description

Docker container running sonarqube

## Usage

* Start : `docker-compose up -d`
* Open https://sonarqube.dev.localhost
* Login with default admin/admin account

## Notes about sonarqube

### Java

```bash
git clone https://github.com/IGNF/validator
cd validator
mvn clean package
mvn sonar:sonar -Dsonar.java.binaries=$PWD/**/target/classes \
    -Dsonar.host.url=http://localhost:9000 -Dsonar.login=$SONAR_TOKEN
```

## sonar-scanner under docker

```bash
git clone https://github.com/mborne/remote-git
# send to sonarqube
docker run --rm \
    -v $PWD/remote-git:/project \
    -w=/project --network=devbox \
    nikhuber/sonar-scanner:latest sonar-scanner \
    -Dsonar.projectKey=remote-git \
    -Dsonar.language=php \
    -Dsonar.sources=/project/src \
    -Dsonar.host.url=http://sonarqube:9000   -Dsonar.login=$SONAR_TOKEN
```


