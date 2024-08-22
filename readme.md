
# Creating a DevSecOps pipeline with PetClinic application

## Clone the repo and setup to work directly on an IDE

 ```bash
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
#open vs code
code .
```
 


## IDE integration

I downloaded the VS Code Jfrog plugin to be able to run scan directly from my IDE ( shift left ;) ) and to be able to get the build results from the Artifactory instance

![VsCode Jfrog Integration](https://github.com/5l1D3R/PetClinic/blob/main/images/vscode.png)


## C ompiling locally

If you want to compile locally, you will need to configure your maven settings files to be able to communicate w ith Artifactory instance ([Jfrog documentation](https://jfrog.com/help/r/jfrog-artifactory-documentation/resolve-maven-artifacts-through-artifactory))
The goal here is to avoid to do the dependency resolution through maven central but through Jfrog Artifactory

You can run this command to see if the dependency resolution works fine, the flag "dependency:purge-local-repository" will force to redownload the dependency instead of using the local cache
```bash
"mvnw.cmd" dependency:purge-local-repository  install -f "pom.xml" 
```
You should see on the logs that your dependency are downloaded from Artifactory
```
[INFO] Re-resolving dependencies
Downloading from central: https://gdoma.jfrog.io/artifactory/petclinic-libs-release/org/springframework/boot/spring-boot-starter-actuator/3.3.0/spring-boot-starter-actuator-3.3.0.pom
Downloaded from central: https://gdoma.jfrog.io/artifactory/petclinic-libs-release/org/springframework/boot/spring-boot-starter-actuator/3.3.0/spring-boot-starter-actuator-3.3.0.pom (2.8 kB at 54 kB/s)
Downloading from central: https://gdoma.jfrog.io/artifactory/petclinic-libs-release/org/springframework/boot/spring-boot-starter-actuator/3.3.0/spring-boot-starter-actuator-3.3.0.jar
```
To run locally the application you can type this command :
```bash
java -jar target/*.jar
```

You can then access the Petclinic at <http://localhost:8080/>.

## Preparing the repo files

Dockerfile was created to be able to build a Docker image 

```docker
FROM  openjdk:17
EXPOSE  8080
ADD  target/spring-petclinic-3.3.0-SNAPSHOT.jar  spring-petclinic-3.3.0-SNAPSHOT.jar
ENTRYPOINT  ["java","-jar","/spring-petclinic-3.3.0-SNAPSHOT.jar"]
```

Maven settings file with the Artifactory instance informations was created to enable Github to do the dependency resolution through JFrog Artifactory


## Building a Container

You should be able to build a local image with this command 
```
docker build -t petclinic-app:latest <Dockerfile folder>

```
## Start the container from the local image

You could start the container by using this command

```bash
docker run -p 8080:8080 -t petclinic-app:latest
```
# CI integration (Github actions)

I chose to use Github to build the pipeline with Github actions

Please find below an overview

![Workflow diagram](https://github.com/5l1D3R/PetClinic/blob/main/images/Diagram.jpg)

Github workflows files :

 1. **maven-build.yml**
 
	This workflow will be automatically triggered when a push or PR on the **"main"** branch occurs
	Steps :
		- Do the dependency resolution through Artifactory
		- Compile the application
		- Run the unit tests
		- Run the JFrog CLI to audit the code (SAST/SCA/SECRET/IaC) with XRay
		- Run the JFrog CLI to scan the binaries generated with XRay
		- Collect build context informations
		- Upload the binaries to Jfrog Artifactory
		- Build docker image
		- Push the image to Jfrog Artifactory registry
		- 
2.	**frogbot-scan-pull-request.yml**
	
	This workflow is triggered when a PR is created to see if there is new vulnerabilities added (comparison between source branch and destination branch)
	This will add PR decoration with the results

3.	**frogbot-scan-repository.yml**
	This workflow will scan periodically the branch **"feature123"** and create entries in the Github security tab (code scanning)

