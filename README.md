# Funny Movies - Chi Dang

### Setup
  Note: Make sure your host has directory permissions for /var/lib/mysql

    docker-compose run app rake db:create RAILS_ENV=production # this takes about 15 minutes the very first time you use docker
    docker-compose run app rake db:migrate db:seed RAILS_ENV=production
    docker-compose up -d # or 'docker-compose up' then visit http://localhost:8081
    docker ps # to verify that all three containers are up and running execute 

### Server control

    docker-compose up -d # start servers
    docker-compose restart # restart servers
    docker-compose down # stop servers

### Testing

To run specs:

    docker-compose run --rm app bundle exec rspec