# gitlab docker container registry
```
- clone the https://github.com/spring-projects/spring-petclinic
- we need to create a Dockerfile
- we need to add the .gitlab-ci.yml 
- add the below code in there 



- here we are using the docker images only 
- this is with shared runner 
- how to do in self hosted runner ?
- 

```
--------------------------------------
```
stages:
  - build
  - test
mvn_build:
    image: maven:3.9.9-eclipse-temurin-23-alpine
    stage: build
    script:
        - mvn clean install -Dmaven.test.skip=true
    artifacts:
      paths:
        - "target/*.jar"
```
--------------------------------------------
# make a connection with docker-registry
```
- go to settings
- cicd 
- variables
- add variables
- uncheck protected variables
-- container registry connection
- key
	- CI_REGISTRY
- value
	- registry.gitlab.com/awssandeepchary1/spring-petclinic
- full project name (registry.<gitlab project name>)
- we need user and password
- gitlab user icon -> preferences -> Access Tokens -> 
- for now enable all the check list
- get the access Tokens -<token>
- uncheck the protected
-- user and password
- add variables
- key
	- CI_REGISTRY_PASSWORD
	
- value
	- - <paste the key from the token generated>
- key
	- CI_REGISTRY_USER
- value
	- <value given for generating the token>

```
------------------------------------------------------------
# Full gitlab with container registry
```
stages:
  - build
  - build-img
mvn_build:
    image: maven:3.9.9-eclipse-temurin-23-alpine
    stage: build
    script:
        - mvn clean install -Dmaven.test.skip=true
    artifacts:
      paths:
        - "target/*.jar"
build-push-img:
    image: docker:stable
    stage: build-img
    needs:
      - mvn_build
    services:
      - name: docker:dind
    script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
        - docker build -t $CI_REGISTRY/pet-clinic:$CI_PIPELINE_ID .
        - docker push $CI_REGISTRY/pet-clinic:$CI_PIPELINE_ID


```