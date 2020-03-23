# drupal

[drupal](https://hub.docker.com/_/drupal/) official image with PostgreSQL storage


docker run --name some-drupal --network some-network -d \
    -v /path/on/host/modules:/var/www/html/modules \
    -v /path/on/host/profiles:/var/www/html/profiles \
    -v /path/on/host/sites:/var/www/html/sites \
    -v /path/on/host/themes:/var/www/html/themes \
    drupal
