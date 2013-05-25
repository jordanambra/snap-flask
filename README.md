# snap-flask

Nearly instant setup of a new Flask application.

## Development Stack
* Localhost: Vagrant + Virtualbox
* Server Version: Ubuntu 13.04 Server (Raring Ringtail)
* Database: PostgreSQL
* Web Server: Nginx
* App Server: uWSGI on Supervisord

## Server Layout
* 1 Load Balancer
* 2 Web/App Servers
* 1 Database Server


## Getting Started

* Install the latest Virtualbox from https://www.virtualbox.org/
* Install the latest Vagrant from http://www.vagrantup.com/
* Clone this repo
* In terminal, cd to the root of the repo
* vagrant up
* Load balanced website is now available at http://192.168.50.1. Feel free to add it to your hosts file or router DNS.

## Server Access
* Log into the load balancer with vagrant ssh lb
* Log into the database server with vagrant ssh db
* Log into the 1st web server with vagrant ssh web1
* Log into the 2nd web server with vagrant ssh web2