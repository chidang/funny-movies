# Funny Movies - Chi Dang

### Setup

**Note:**
* Make sure your host has directory permissions for /var/lib/mysql
* Add `127.0.0.1 funny-movies.local` to your `/etc/hosts` file

    docker-compose run app rake db:create RAILS_ENV=development # this takes about 15 minutes the very first time you use docker
    docker-compose run app rake db:migrate db:seed RAILS_ENV=development
    docker-compose up # Building web server (nginx) takes a while +- 5 minutes, then visit https://funny-movies.local/ or http://localhost:3001/
    docker ps # to verify that all three containers are up and running execute 

### Server control

    docker-compose up -d # start servers
    docker-compose restart # restart servers
    docker-compose down # stop servers

### Testing

To run specs:

    docker-compose run --rm app bundle exec rspec


