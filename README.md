# Getting Started with Jenkins 2

This repository contains all resources I created during the Pluralsight course "Getting Started with Jenkins 2"

## Contents

This project uses Docker Compose to create a Jenkins container with a named volume.

A custom Dockerfile is used to add Maven to the Jenkins container.

## Requirements

You will need the follwoing installations:

- Docker


## Usage

To start the container and volume run the following command within the root directory:

```bash
docker-compose up
```

### Backup & Restore Volume

If you wish to backup or restore the volume created as part of this course.

#### Backup

The following command will produce a `tar` file of the `/var/jenkins_home` directory in the repos root directory.

```bash
docker run --rm --volumes-from pluralsight-getting-started-with-jenkins-2_jenkins_1 -v $(pwd):/backup ubuntu tar cvf /backup/jenkins_backup.tar /var/jenkins_home
```

#### Restore

Place the tar file created by the backup into the repositories root directory and run the following command:

```bash
docker run --rm --volumes-from pluralsight-getting-started-with-jenkins-2_jenkins_1 -v $(pwd):/backup ubuntu bash -c "cd /var/jenkins_home && tar xvf /backup/jenkins_backup.tar --strip 1"
```
