### Docker-Compose
### From 
## developer 
### to 

![](https://knpuniversity.com/imagine/course_video_poster_large/uploads/screencast/composer:ec02af1c8c8b7a77403283ad7a0534e9c1037b06/KnpU-Composer.png)
![fit original](https://topdev.vn/assets/img/logo.png)

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
#### Presented by: Khanh Tran

---

## Who am i

- Technology Evangelist @ GEEK Up
- I'm a Hobbit, and my hobbies:
  - Docker & Microservice
  - Nightwish music
<br/>
Twitter: @khanhtran
khanh.tq@geekup.vn

![right](https://s-media-cache-ak0.pinimg.com/564x/6e/0c/61/6e0c61a14548e0c397bd06d10637f7ac.jpg)

---

# Agenda
- Why Docker?
- Why Docker-Compose?
- How to setup a PhalconPHP project with docker-compose
- 10 take-away tips 

![](http://www.mylarfoodstoragedinners.com/wp-content/uploads/2016/03/1bf06a7.jpg)

---

# [fit] Say one more time 
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
# [fit] work on my machine

![original](https://i.ytimg.com/vi/ucKnpvPaAeM/maxresdefault.jpg)

^ Question: who fixed bug case-sensitive MySQL table name

---
![fit](https://ipggi.files.wordpress.com/2011/06/21-06-2011-10-40-57-am.png?w=982)

---

![](http://2eof2j3oc7is20vt9q3g7tlo5xe.wpengine.netdna-cdn.com/wp-content/uploads/2014/04/docker-matrix.jpg)

---

# [fit] Legacy ways to provide dev environment

- README.txt
- Virtual box, VMware
- Vagrant (https://www.vagrantup.com) 

![right](http://www.gex.pl/wp-content/uploads/2011/07/Virtualbox_logo.png)
![left](http://cdn.dev.classmethod.jp/wp-content/uploads/2015/02/vagrant_logo-320x320.png)


---

# [fit] Problems of legacy ways

---

# [fit] Human don't read document
![inline](http://image.slidesharecdn.com/drush-110615113628-phpapp02/95/intro-to-drush-66-728.jpg?cb=1308138458) 

---

# [fit] VM is BIG & SLOW

![original](http://www.magnasoma.com/content/images/Magnasoma-Monolith-3-01.jpg)

---

# [fit] Conflicting libraries
![inline](https://www.researchgate.net/profile/Jens_Lehmann2/publication/240615108/figure/fig2/AS:298587226427395@1448200150110/Fig-2-Example-DEB-package-dependency-tree-OntoWiki-Some-explanation-Boxes-are-part.png)

--- 

# [fit] Woody every problems 
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
# [fit] has a solution
![original](http://generator-meme.com/inc/media/memes/buzz-and-woody.jpg)

^ Question: can you name it?

---

![fit](http://image.slidesharecdn.com/dockerlpc2014cristian-141022130848-conversion-gate02/95/docker-and-the-linux-kernel-8-638.jpg?cb=1413983410)

---

![](http://justdrupal.com/content/images/2016/06/docker-image.png)

---

# [fit] Demo #1
![fit right](http://images.geekyplatypus.com/2016/12/18163627/dockerphp.png)

---

![inline](http://www.maxpou.fr/images/articles/symfony-docker/schema-v2.png)

---

![](http://blog.cloud66.com/content/images/2015/05/56291573.jpg)

---

```bash
$ docker pull mysql:5.7
$ docker run mysql:5.7 
  --name db 
  -v $(pwd)/stacks/mysql/.db:/var/lib/mysql 
  -p 3306:3306 
  -e MYSQL_ROOT_PASSSWORD=123Abc

$ docker build -t web .
$ docker run web --link db:db -p 8080:80

...
```

---

## Multi-container apps are a hassle 
```
$ docker pull ...
$ docker pull ...
$ docker pull ...
$ docker pull ...
$ docker build ...
$ docker build ...
$ docker build ...
$ docker build ...
$ docker run ...
$ docker run ...
$ docker run ...
$ docker run ...
```

![right fit filtered](https://s3.amazonaws.com/docker-compose/simple-application-stack.png)

---

# [fit] Woody every problems 
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
# [fit]  has a solution
![original](http://generator-meme.com/inc/media/memes/buzz-and-woody.jpg)

---

![fit](https://s-media-cache-ak0.pinimg.com/564x/36/fe/ed/36feed67094e1d133e166868d4c712b3.jpg)

---

# We can treat containers as
![fit inline](https://s3.amazonaws.com/docker-compose/application-stacks.png)

---

![original](http://engineering.laterooms.com/content/images/2016/05/orchestra-1.jpg)

---

## Docker-Compose: 
## Get an app running in one command

![fit inline filtered](https://s3.amazonaws.com/docker-compose/docker-compose.png)

---
# docker-compose.yml
 
```yaml
version "2"
services:
  nginx:
    image: nginx
    links:
      - web:web
    ports:
      - 80:80
  web: 
    build: src 
    links:
      - db:db
  db:
    image: mysql:5.7
  cache:
    image: redis:latest
 ```

---

## Docker-Compose commands 

```bash
# run all containers in background
$ docker-compose -f docker-compose.yml up -d

# stop all containers
$ docker-compose down

# scale web to 3 containers
$ docker-compose scale web=3

# show logs
$ docker-compose logs -f
```

---

# [fit] Demo #2
![fit](http://www.maxpou.fr/images/articles/symfony-docker/schema-v2.png)

---

![](http://nationallearning.com.au/wp-content/uploads/2008/12/tips.jpg)

---

## Tip #1: How to use volumes to store container's data

```yml
services:
  web:
    volumes:
      - ./stacks/web/uploads:/uploads
      - ./stacks/web/cache:/cache
  db:
    volumes:
      - ./stacks/mysql/.db:/var/lib/mysql 
```

--- 

## Tip #2: Simplify application's configuration by using links
```php
# before
'db' => [
  'host' => get_env('DB_HOST')
]
```
```yml
services:
  web:
    links:
      - db:db
      - cache:cache
  db:
    image: mysql:5.7
  cache:
    image: redis
```
```php
# after
'db' => [
  'host' => 'db'
]
```
--- 

## Tip #3: Running development tasks with Use one-off containers

```bash
# Run PHP Composer
$ docker run --rm composer/composer -v $(pwd):/app composer install 

# Migrate database
$ docker-compose run devtools migrations:migrate -n

# Run Bower
$ docker run -v $(pwd)/src/web:/data ngtrieuvi92/nodejs-devtools bower
 install --allow-root

```

---

## Tip #4: Simplify docker-compose commands by using Makefile

```Makefile
# Makefile
VERSION = 1.0

.PHONY: start dev_up composer-install bower dbmigrate

start: composer-install bower dbmigrate

dev_up:
  docker-compose up -d --remove-orphans

ps:
  docker-compose ps

dbmigrate:
  docker-compose run devtools migrations:migrate -n
```

```bash
$ make dev_up
$ make ps
$ make dbmigrate
```

---

## Tip #5: Mitigate remmebering to many ports by using typicode/Hotel 

```bash
# add domain www.topdev.dev 
$ hotel add http://localhost:10000 --name www.topdev

# add domain www.topdev.dev 
$ hotel add http://localhost:10001 --name adminer.topdev

$ open adminer.topdev.dev
$ open www.topdev.dev
```


---

## Tip #6: Experimental web scaling in development env.

```bash
$ docker-compose scale www=3
```

```lua
upstream topdev_www  {
  server topdev_www_1:8080 max_fails=1 fail_timeout=10s;
  server topdev_www_2:8080 max_fails=1 fail_timeout=10s;
  server topdev_www_3:8080 max_fails=1 fail_timeout=10s;
}

server {
    listen 80;
    server_name www.topdev.dev;
    location / {
        proxy_pass http://topdev_www;
        proxy_http_version 1.1;
        proxy_set_header        HTTP_CLIENT_IP       $remote_addr;
        proxy_set_header        HTTP_X_FORWARDED_FOR $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_ignore_headers Set-Cookie;
        proxy_ignore_headers Cache-Control Expires;
        proxy_cache_bypass $http_secret_header;
    }
}
```

--- 

### Tip #7: Mount your docker.sock

[__Nginx-Proxy__](https://github.com/jwilder/nginx-proxy) generates reverse proxy configs for nginx 
and reloads nginx when containers are started and stopped.

```yml
version: '2'
services:
  nginx-proxy:
    image: jwilder/nginx-proxy
    container_name: nginx-proxy
    ports:
      - "80:80"
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro

  whoami:
    image: jwilder/whoami
    container_name: whoami
    environment:
      - VIRTUAL_HOST=whoami.local
```

```bash
$ docker-compose up
$ curl -H "Host: whoami.local" localhost
I'm 5b129ab83266
```

--- 

## Tip #8: How to config different environment 

- Define per docker-compose file per environment as below:
  - docker-compose-dev.yml
  - docker-compose-test.yml
  - docker-compose-staging.yml
  - docker-compose-production.yml

```bash
# Use symbol link files to define different environments
$ ln -s docker-compose-dev.yml docker-compose.yml
$ make dev_up
```

---
## Tip #9: Avoid breaking change by using tagging image

```yml
services:
  db:
    image: mysql:5.7
  search:
    image: elasticsearch:2.4
```


--- 

## Tip #10: Improve DevOps skill by learning from master

- Let search on Docker Hub for a good docker image
- Go to there Github repository and learn:
  - their Dockerfile
  - their Nginx.conf
  - their my.cnf
  - etc...
- Examle: [APSL/thumbor](https://hub.docker.com/r/apsl/thumbor/)

--- 

## Bonus: How to run two duplicated docker-compose in same machine

__Use project alias as prefix of service's name__

---
# Q&A


![original](https://scontent.fsgn4-1.fna.fbcdn.net/v/t31.0-8/14889945_1278106412241232_554011688288104757_o.jpg?oh=8a7499a768b198229503425c29d6f953&oe=58DC3232)

---
### Join Us

![left filtered original](https://scontent.fsgn4-1.fna.fbcdn.net/v/t31.0-8/14480590_1252642808120926_8837552896187895013_o.jpg?oh=c0600fe6478c60e3e43f92d5db65d548&oe=58E18908)
![right original](https://scontent.fsgn4-1.fna.fbcdn.net/v/t31.0-8/11111630_838194519580597_9210896921543950142_o.jpg?oh=19fc1e31d2d3426591b9fde08eddd2f9&oe=5917B136)

---
# Images Credit

- https://knpuniversity.com/imagine/course_video_poster_large/uploads/screencast/composer:ec02af1c8c8b7a77403283ad7a0534e9c1037b06/KnpU-Composer.png
- http://www.mylarfoodstoragedinners.com/wp-content/uploads/2016/03/1bf06a7.jpg
- https://i.ytimg.com/vi/ucKnpvPaAeM/maxresdefault.jpg
- https://ipggi.files.wordpress.com/2011/06/21-06-2011-10-40-57-am.png?w=982
- http://2eof2j3oc7is20vt9q3g7tlo5xe.wpengine.netdna-cdn.com/wp-content/uploads/2014/04/docker-matrix.jpg
- http://www.gex.pl/wp-content/uploads/2011/07/Virtualbox_logo.png
- http://cdn.dev.classmethod.jp/wp-content/uploads/2015/02/vagrant_logo-320x320.png
- http://image.slidesharecdn.com/drush-110615113628-phpapp02/95/intro-to-drush-66-728.jpg?cb=1308138458
- http://www.magnasoma.com/content/images/Magnasoma-Monolith-3-01.jpg
- https://www.researchgate.net/profile/Jens_Lehmann2/publication/240615108/figure/fig2/AS:298587226427395@1448200150110/Fig-2-Example-DEB-package-dependency-tree-OntoWiki-Some-explanation-Boxes-are-part.png
- http://generator-meme.com/inc/media/memes/buzz-and-woody.jpg
- http://image.slidesharecdn.com/dockerlpc2014cristian-141022130848-conversion-gate02/95/docker-and-the-linux-kernel-8-638.jpg?cb=1413983410
- http://justdrupal.com/content/images/2016/06/docker-image.png
- http://images.geekyplatypus.com/2016/12/18163627/dockerphp.png
- http://www.maxpou.fr/images/articles/symfony-docker/schema-v2.png
- http://blog.cloud66.com/content/images/2015/05/56291573.jpg
- http://generator-meme.com/inc/media/memes/buzz-and-woody.jpg
- https://s-media-cache-ak0.pinimg.com/564x/36/fe/ed/36feed67094e1d133e166868d4c712b3.jpg
- http://engineering.laterooms.com/content/images/2016/05/orchestra-1.jpg
- http://www.maxpou.fr/images/articles/symfony-docker/schema-v2.png
- http://nationallearning.com.au/wp-content/uploads/2008/12/tips.jpg
