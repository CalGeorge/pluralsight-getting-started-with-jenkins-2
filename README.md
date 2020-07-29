# Getting Started with Jenkins 2

An unofficial Docker Compose environment for the Pluralsight course [Getting Started with Jenkins 2](https://app.pluralsight.com/library/courses/jenkins-2-getting-started)

## Contents

This project contains a docker-compose file to start a Jenkins and a Mailhog container. As well as a custom Dockerfile to add Maven, NPM & PhantomJS to the Jenkins container.

## Requirements

You will need the following installations:

- Docker

## Usage

To start the container and volume run the following command within the repositories root directory:

```bash
docker-compose up
```

The started services will be available at the following addresses:

Service | Address 
------- | ---
Jenkins HTTP | `localhost:8080`
Mailhog HTTP | `localhost:8025`
Mailhog SMTP (Docker) | `mailhog:1025`
Mailhog SMTP (Host) | `localhost:1025`

### Copy & Run agent.jar in Jenkins Container

In module 6 you will need to copy the `agent.jar` file to the Jenkins container so that you're able to run the jar within the container. 

Copying the file to the `/var/jenkins_home` directory in the container:

```bash 
docker cp agent.jar pluralsight-getting-started-with-jenkins-2_jenkins_1:/var/jenkins_home
```

Connecting to the container terminal:

```bash
docker exec -it pluralsight-getting-started-with-jenkins-2_jenkins_1 bash
```

### Backup & Restore Volume

If you wish to backup or restore the volume created as part of this course.

#### Backup

The following command will produce a `tar` file of the `/var/jenkins_home` directory in your current directory.

```bash
docker run --rm --volumes-from pluralsight-getting-started-with-jenkins-2_jenkins_1 -v $(pwd):/backup ubuntu tar cvf /backup/jenkins_backup.tar /var/jenkins_home
```

#### Restore

To restore the backup volume, place the tar file created by the backup in your current directory and run the following command:

```bash
docker run --rm -v pluralsight-getting-started-with-jenkins-2_jenkins_home:/var/jenkins_home -v $(pwd):/backup ubuntu bash -c "cd /var && tar xvf /backup/jenkins_backup.tar --strip 1"
```

## Notes

- As of `2020-07-29` the `jenkins2-course-spring-boot` application does not build due to Spring now requiring the use of HTTPS. Within the open pull requests there are many forks that have fixed this issue. The version I used to complete this course was `evilC/jenkins2-course-spring-boot`.
- As Jenkins is running within a container (without the browser binaries) you won't be able to run the Chrome, Firefox or Safari tests mentioned in module 6. For the purpose of showing parallel execution I set each stream to use PhantomJS.
- There is only a volume setup for the `/var/jenkins_home` directory so once the container restarts you'll lose any files created in any other agents workspace.
