<p align="center">
  <a href="#" target="_blank">
    <img src="https://workable-application-form.s3.amazonaws.com/advanced/production/60b134fd79ed484c4efcbaa7/6b27a348-6eae-49a5-a818-85ee834d0176" width="80">
  </a>
</p>

<p align="center">
<img src="https://circleci.com/gh/founderandlightning/fl-laravel_boilerplate.svg?style=shield&circle-token=4beb466f683f9409784f085b52b3bb31e4b6c8f0" width="145">
<img src="https://camo.githubusercontent.com/316ccceb2c875497ee2197622c2040a241b8afe4ff78ab7cc0161ee2a644b8a3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c61726176656c2d4646324432303f7374796c653d666f722d7468652d6261646765266c6f676f3d6c61726176656c266c6f676f436f6c6f723d7768697465">
<img src="https://github.com/founderandlightning/fl-laravel_boilerplate/actions/workflows/ci.yml/badge.svg" width="170">
</p>


<details  open="open">

<summary>Table of Contents</summary>

<a>Project Setup</a><br/>
* <a  href="#deploy-application-to-heroku">With Infrastructure</a>
* <a  href="#prerequisites">Local</a>

<a  href="#about-the-project">About The Project</a>

* <a  href="#built-with">Built With</a>
* <a  href="#deployment">Deployment</a>
    * <a  href="#hosting">Hosting</a>
        *	<a  href="#ci">CI</a>
        *	<a  href="#environments">Environments</a>
        *	<a  href="#tools">Tools</a>

<a  href="#getting-started">Getting Started</a>
* <a  href="#prerequisites">Prerequisites</a>
* <a  href="#installation">Installation</a>
* <a  href="#external-services">External Services</a>

<a  href="#deploy-application-to-heroku">Deploying application on heroku</a>
* <a  href="#variablescredentials-that-you-need-to-prepare-with-instruction-how-to-get-those">Variable reference</a>
* <a  href="#know-issues">Known Issues</a>
* <a  href="#deployment-docs">deployment-docs</a>
</details> 


<!-- ABOUT THE PROJECT -->

## About The Project


Short description about project


A list of commonly used resources that I find helpful are listed in the acknowledgements.



### Built With


- Language: <img src="https://img.shields.io/badge/PHP-v8.1.x-blue" >
- Framework: <img src="https://img.shields.io/badge/laravel-v9.x-blue">
- Database: <img src="https://img.shields.io/badge/postgres-v13.x-blue">
- Testing tools: <img src="https://img.shields.io/badge/phpunit-9.5.x-blue" >
- Error Reporting: <img src=https://img.shields.io/badge/Rollbar-7.x-blue>



# Deployment

###  Hosting
* We're using Heroku as hosting solution, for it's the right balance between simplicity and flexibility of it's features.

### CI
* We use CircleCI as primary tool for CI/CD.All configuration related to CircleCI are located in .circleci directory where config.yml is mandatory a file which can be copied from tech specific boilerplate.Here is commit lifecycle.
    1. Every commit is checked by linter on pre-commit git hook (dev need to fix all lint errors before this point)
    2. Every push is checked by TDD on pre-push git hook
    3. Once pushed, Commit is automatically checked by CI which execute the command mentioned in config.yml
    4. circleCi initially check rejected commit via Reviewee (Commit appears in Review Tool where it has to be reviewed and accepted/rejected/fixed)
    5. It deploys code to dev APP and run postman tests against it
    6. Run TDD
    7. Deploy to UAT

### Environments
* UAT aka Staging
* Production aka Live

### Tools
* **Error handling**
    * Rollbar is used as error tracking tool and configured via composer, on every error occurrence a trello card is created on board with which rollbar is connected.
* **Performance monitoring**
    * New relic is used as  performance monitoring tool and used as stand-alone application. It gives us aggregated dashboard and sections to drill down the challenges we might experience on our systems.
* **Log monitoring**
    * We use Papertrail as log management tool for catching Heroku system and build logs because we cannot check live request log and can't check logs for previous request except build logs on Heroku. Some of the key features which papertrail provides are custom alert, easy search and filter log.
    * Additionally, we are experimenting with Coralogix as alternate log management too as alert and dashboard are quite good as compared to papertrail.
* **Setup backups**
    * Automatic backup are set up on daily basis for env variable and database via buildpack.
    * Backups are stored in different S3 bucket.


## Getting Started


To get a local copy up and running follow these simple example steps.



### Prerequisites



Here is a list of how to list things you need to use the software and how to install them.

* Git  [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* Docker [Install docker](https://docs.docker.com/engine/install)
* Docker-Compose [Install docker-compose](https://docs.docker.com/compose/install)



### Installation

## First Run : One-command-to-rule-them-all
```
git clone git@github.com:founderandlightning/fl-laravel_boilerplate.git \
&& cd fl-laravel_boilerplate \
&& docker-compose up --build -d \
&& docker-compose exec laravel-api composer install \
&& docker-compose exec laravel-api composer run dev-setup \
&& git config core.filemode false 
```

```
http://22.95.1.1
```

Admin URL (also accessible from the above link) : `http://22.95.1.1/admin`

Admin credentials : `admin@admin.com / admin`


Everything should be working fine. If not, please open an issue.


### Quick-docs


Port mappings in `docker-compose.yml` are as following:
1. **295 : 80**
    1. HTTP
    1. Service-and-container name = `laravel-api`
    1. IP = `22.95.1.1`
1. **296 : 296**
    1. Vite
    1. Config file : `vite.config.js`
1. **297: 5432**
    1. Postgres
    1. Service-and-container name = `laravel-pg`
    1. IP = `22.95.1.2`


Files to update service/container names:
1. `docker-compose.yml`
1. `composer.json`
1. `.circleci/config.yml`
1. `.github/workflows/ci.yml`

Files to update IP address:
1. `docker-compose.yml`
1. `.env.example`
1. `.env.testing`

Files to update port numbers:
1. `vite.config.js`


#### Default landing page screenshot
<img src="https://user-images.githubusercontent.com/37613346/189156361-97fae29c-ad61-4720-9462-1e6827342391.png" width="600" />

## Workflow

### Git workflow

We're using trunk-based development as our git workflow. https://github.com/founderandlightning/coding-guidelines/blob/master/General/README.md#trunk-based-development-policy

### Committing your changes

1. Make sure, that you installed project dependencies so git-hooks can do their job.
2. Write proper commit message:
    - for commits fixing rejected Reviewee commits use format `fixed sha ...` (use , to fix multiple commits in one go)
3. Git hooks check:
    - pre-commit:
        - Lint
        - CS errors
        - MD errors
    - pre-push:
        - Security Checker
        - phpunit

   If any git hook return error, please fix issue and try committing again.


# External Services

* **Service name**
    * How to create account
    * How to create APP, Key or token (if required)
    * How to use Keys in environment/config variables


## Deploy application to Heroku

#### Prerequisites

Here is the list of Variables/credentials that you need in setup command:

* AWS Keys for user with admin access: [AWS console](https://us-east-1.console.aws.amazon.com/iamv2/home?region=eu-west-2#/users)
* CircleCI API token: [CircleCI API Key](https://circleci.com/account/api)
* Heroku Auth token: [Heroku Auth Key](https://dashboard.heroku.com/account/applications/authorizations/new)

### Know issues
1. Name of the pipeline or app shouldn't exceed 25 characters
2. Name of APP should not contain any special character except -

### Deployment docs

#### Step 1 :Update config
Open `setup/modifier.sh` file and update the following variables (wherever required):

#### Laravel specific variables
1. PROJECT_ORG_OR_USERNAME='founderandlightning'
1. PROJECT_REPO='fl-laravel-boilerplate'
1. PROJECT_API_SERVICE_NAME='laravel-api'
1. PROJECT_PG_SERVICE_NAME='laravel-pg'
1. PROJECT_TF_SERVICE_NAME='laravel-tf'
1. PROJECT_IP_FIRST_TWO_OCTETS='229.21'
1. PROJECT_PORT_HTTP='921'
1. PROJECT_PORT_VITE='922'
1. PROJECT_PORT_DB='923'
#### Heroku/Infrastructure specific variables
1. REPO_NAME='fl-laravel-boilerplate'
1. HEROKU_PIPELINE_NAME="app-pipeline"
1. HEROKU_STAGING_APP="app-staging"
1. HEROKU_PRODUCTION_APP="app-production"
1. HEROKU_ACCOUNT_EMAIL='email@founderandlightning.com'
1. HEROKU_API_KEY='XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
1. AWS_ACCESS_KEY_ID: 'xxxxxxxxxxxxxxxxxxxx'
1. AWS_SECRET_ACCESS_KEY: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
1. POSTMAN_API_KEY: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
1. CIRCLECI_API_KEY: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

#### Step 2 : Run below script for setting up Infra

```
git clone git@github.com:founderandlightning/test-lbp.git \
&& cd test-lbp \
&& git config core.filemode false \
&& cd setup && chmod +x modifier.sh ci.sh \
&& ./modifier.sh \
&& ./ci.sh \
&& cd terraform && chmod +x heroku.sh \
&& ./heroku.sh
```

#### The above steps would result in following being created:
1. Heroku pipeline with staging and production apps
    1. Postgres database for each app
    2. Dyno configuration : 1 web and 1 worker
    3. Papertrail
    4. New Relic
    5. Rollbar
    6. Scheduler
    7. Redis server
1. CircleCI pipeline with "ci" and "cd" workflows
1. Postman collection runner (at CircleCI)
1. AWS IAM users : staging, production and backup
1. AWS S3 buckets : staging, production and backup

#### Step 3 :Post deployment tasks

Once the deployment was successful, and you verified that pipeline is working fine checkout setup folder with  `git checkout setup`
