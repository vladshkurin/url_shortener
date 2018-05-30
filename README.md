### Url Shortener

Build an application:

```sh
docker-compose build
```
Run a migration:

```sh
  docker-compose run url_shortener bundle exec rake db:migrate
```

Run an application:

```sh
  docker-compose up -d
```

Go to: http://localhost:3000
