# ----------------------------------------------------------------------
#  Development
# ----------------------------------------------------------------------

#: Builds a Docker image from the current docker-compose.yml file
build:
	@docker-compose build web

#: Removes dangling images/containers and temporary files
clean: down
	@docker container prune --force

#: Creates, prepares and migrates project's db
prepare-db:
	@docker-compose run --rm web rails db:create db:test:prepare db:migrate

#: Setups your Docker development environment (build, prepare, clean, up)
start: build prepare-db up

#: Starts the containers with docker-compose in background
up: clean
	@docker-compose up -d web

#: Removes the containers running in background
down:
	@docker-compose down --remove-orphans 2> /dev/null; true

#: Restarts the web service
restart:
	@docker-compose restart web

#: Shows the logs of the web service container
logs:
	@docker-compose logs -f --tail 50 web

#: Fires up a bash session inside the web service container
shell:
	@docker-compose run web bash 2> /dev/null

#: Fires up a bash session inside the rails console in web service container
console:
	@docker-compose run web rails c 2> /dev/null

#: Runs RSpec with docker-compose test service
test:
	@docker-compose run --rm test
