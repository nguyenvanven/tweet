# README

The custom tweet app

## Author
* Full Name: Nguyen Van Ven
* email: vennguyenev@gmail.com

## Technical detail
* Ruby on Rails
* Active record with sqlite database
* coffeescript, haml, scss

## How to run
1. cd to project folder
2. migrate database model:
  >> rake db:migrate
3. start server:
  >>rails server

## What is implemented:
1. CRUD actions for tweets
2. Tweet lists, homepage with top 10 tweets
3. Paging for tweet list

## To Be improved
1. Tweet list should be lazy loading for detail: only load when user click view comments.
2. Improve front end design + navigation menu
