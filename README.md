# RoBorregos Web Dashboard

Web application intended to be the team's data warehouse and dashbord for
management of information related to team RoBorregos (international robotics
team). Homemade project, developed by RoBorregos' members. Unfortunately, you
can't consult more than the login page of this dashboard, since you would
require a valid username and password to see the rest of it, but you can check
out our public site at [roborregos.com](https://roborregos.com) or
[roborregos.mx](https://roborregos.mx).



## Table of contents

- [RoBorregos Web Dashboard](#roborregos-web-dashboard)
	- [Table of contents](#table-of-contents)
	- [Project details](#project-details)
		- [Development team](#development-team)
		- [Management tools](#management-tools)
	- [Development](#development)
		- [Third-party](#third-party)
		- [Running the stack of development](#running-the-stack-of-development)
		- [Makefile commands](#makefile-commands)
		- [Setup with Docker](#setup-with-docker)
		- [Stopping services](#stopping-services)
		- [Good to know commands](#good-to-know-commands)



## Project Details

### Development team

| Name | Email | Github | Role |
| ---- | ----- | ------ | ---- |
| José Eduardo Sanchez | [gallo.sanchez23@gmail.com](mailto:gallo.sanchez23@gmail.com) | [@gallosanchez23](https://github.com/gallosanchez23) | Developer |
| José Cisneros Morales | [joseacisnerosm@gmail.com](mailto:joseacisnerosm@gmail.com) | [@Josecisneros001](https://github.com/Josecisneros001) | Developer |

### Management tools

You should ask for access to these tools if you don't have it already:

* [Github repo](https://github.com/RoBorregos/roborregos-web-dashboard.git)
* [Heroku](https://www.heroku.com/)



## Development

### Third-party

Before setting up the project, you should have installed the following
development tools:

* [Git](https://git-scm.com/downloads)
* [Docker](https://runnable.com/docker/getting-started/)
* [Docker Compose](https://docs.docker.com/compose/install/)

### Running the stack of development

We provide two different ways to setup your local project: a custom Makefile
and docker-compose native commands. As we strongly encourage you to use our
Makefile, you can still use docker-compose. Also, it could be useful some
knowledge about docker if you want to have more specific interactions with the
container. With this being said, we will continue using Makefile commands, but
you can obtain the same result following [these](#setup-with-docker) steps.

Once you have installed the required third-party software, you can follow these
steps:

1. Clone the project repository on your local machine.

	SSH:

	```bash
	$ git clone git@github.com:RoBorregos/roborregos-web-dashboard.git
	```

	or HTTPS:
	```bash
	$ git clone https://github.com/RoBorregos/roborregos-web-dashboard.git
	```

2. Enter the project's directory

	```bash
	$ cd roborregos-web-dashboard
	```

3. Create the Docker image (This could take a couple minutes).

	```bash
	$ make start
	```

***Note: If using Linux, remember that you may need the sudo command in order
to avoid permission-denied errors. Other options is to apply executable
permissions to the docker-compose binary. You can fine more information about
this in the [installation guide](https://docs.docker.com/compose/install/).***

You are now ready to open the application and start collaborating with the
project. Go to your browser and enter [localhost:3000](http://localhost:3000/)
to see the running application. Enjoy!

### Makefile commands

Other Makefile commands available for you are:

To buil a Docker image from the current docker-compose.yml file, or (if
existing) docker-compose.override.yml:

```bash
$ make build
```

To remove any dangling images, containers and temporary files (from Docker)
related to the roborregos-web-dashboard project:

```bash
$ make clean
```

To create and migrate project's development and test db's:

```bash
$ make prepare-db
```

🌟 - To create and completely setup your Docker development environment.

```bash
$ make start
```

To use the existing project's image to start the containers with docker-compose
running in background:

```bash
$ make up
```

🌟 - To turn down and remove the project's containers running in background:

```bash
$ make down
```

To restart only the web service:

```bash
$ make restart
```

🌟 - To show the last 50 logs from the running web service container:

```bash
$ make logs
```

🌟 - To fire up a bash session inside the running web service container:

```bash
$ make shell
```

🌟 - To fire up a bash session inside the running web service container and
execute `rails c` command to place you inside rails console:

```bash
$ make console
```

🌟 - To run all specs within test service container:

```bash
$ make test
```

### Setup with Docker

1. Clone the project repository on your local machine.

	SSH:

	```bash
	$ git clone git@github.com:RoBorregos/roborregos-web-dashboard.git
	```

	or HTTPS:
	```bash
	$ git clone https://github.com/RoBorregos/roborregos-web-dashboard.git
	```

2. Enter the project's directory

	```bash
	$ cd roborregos-web-dashboard
	```

3. Create the Docker image (This could take a couple minutes).

	```bash
	$ docker-compose build
	```

	***Note: If using Linux, remember that you may need the sudo command in order
	to avoid permission-denied errors. Other options is to apply executable
	permissions to the docker-compose binary. You can fine more information about
	this in the [installation guide](https://docs.docker.com/compose/install/).***

4. If it is the first time you are running the project, you will need to create
	the project's database. For this, fire up a new terminal and navigate to the
	project's directory. Once you are there, run:

	```bash
	$ docker-compose run web rails db:create
	```

	This command will use Rails within the existing and running container to
	create the development and test databases for our project. This should output
	something like:

	```bash
	Starting roborregos-web-dashboard_db_1 ... done
	Created database 'roborregos_dashboard_development'
	Created database 'roborregos_dashboard_test'
	```

5. Finally, you will need to run the pending db migrations. For this, run:

	```bash
	$ docker-compose run web rails db:migrate
	```

	If you've previously done all the above, simply run:

	```bash
	$ docker-compose up
	```

	This command will start the Rails application and display the logs on your
	terminal. Use `Ctrl + C` to exit the logs and turn the application down.
	Otherwise, in order to run the service in the background, just run:

	```bash
	$ docker-compose up -d
	```

You are now ready to open the application and start collaborating with the
project. Go to your browser and enter [localhost:3000](http://localhost:3000/)
to see the running application. Enjoy!

### Stopping services

In order to stop `roborregos-web-dashboard` entirely you can run:


```bash
$ docker-compose stop
```

If you want to stop the services and remove the containers:


```bash
$ docker-compose down
```

If you only want to stop one service in particular, you can specify it with the
following command:


```bash
$ docker-compose stop [service-name]
```

### Good to know commands

If the service is already running, you can run:

```bash
$ docker attach roborregos-web-dashboard_web_1
```

to attach all logs from the web service, or

```bash
$ docker attach roborregos-web-dashboard_db_1
```

for the db service.
Also, if the container is already running, you can always run:

```bash
$ docker-compose run web bash
```

to enter the container's console, from where you can interact directly with
Rails and every program installed in the containers environment.
