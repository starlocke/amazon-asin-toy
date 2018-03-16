# README

This is a "toy" app. There is absolutely zero security thinking in place.

## Screenshot

![App Screenshot](/docs/app-screenshot.png?raw=true "App Screenshot")

## Introduction

The following instructions should be done in top-down order:

- Configuration
- Build
- Drop DB (only if 'restarting')
- Create DB
- Launch
- Browse
- Add ASINs

## TL;DR (Quick) launch

- Run `./launch.sh`, follow instructions.
- Requires "Configuration"

## Configuration

Amazon Credentials

You must supply your own AMAZON_ACCESS_KEY_ID, AMAZON_ASSOCIATE_TAG and 
AMAZON_SECRET_ACCESS_KEY into a file named `web-env-variables.env`. You may
copy the template `web-env-variables-template.env`, and replace all the
`placeholder` values.

Start at:

https://affiliate-program.amazon.com/home/account

Create API credentials at:

https://affiliate-program.amazon.com/assoc_credentials/home

Detailed official Documentation is at:

https://docs.aws.amazon.com/AWSECommerceService/latest/DG/Welcome.html

## Build the system

`docker-compose build`

## Drop the database

Stop the system:

`docker-compose down`

Drop the database files:

`rm -r -f ./tmp/db`

## Create the database

Launch:

`docker-compose up -d`

Wait until all services are fully initialized (~15 seconds), and then:

`docker-compose run --rm -w /myapp web rake db:create`
`docker-compose run --rm -w /myapp web rails db:migrate`

## Launch

`docker-compose up -d`

## Browse

http://localhost:3000/ is the default URL of this app.

## Web App Usage

1. Supply ASINs using the "Fetch Tool" textarea,
   and submit it.

2. The table will be refreshed on success. On error,
   it will not be refreshed.

## Sample ASIN strings

The first one is the baby product.

```
B002QYW8LW

B01N0X3NL5
B018LJZUGK
B079S8G3HC
B00JM5GW10
B07BBMV8MY
B01N9QVIRV
B01N1037CV
B010TQY7A8
B01MRG7T0D
B00000IGGJ
B00005JNBQ
B00006KGC0
B00006KGC2
B0001LJBTE
B00020HALU
B000001DQI
B000003BGP
B00000JWOJ
B000JKXBKC
B000MZ5DD2
B0777GLYJ5
B06XCM9LJ4
B01CB6YQ8M
B00WQEPSY6
B00A85EMVK
```
