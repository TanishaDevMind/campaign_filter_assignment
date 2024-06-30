# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 3.1.2

* Configuration: Mysql 5

* Database creation: bundle exec rails db:create

* Database initialization: bundle exec rails db:migrate

* How to run the test suite: bundle exec rspec

* ...

* curl to fetch all users
  `curl --location '209.38.225.96:80/users''`

* curl to create user
  `curl --location '209.38.225.96:80/users' \
  --header 'Content-Type: application/json' \
  --data '{"user": {"name": "tanisha",
  "campaigns_list": [{"campaign_name": "camp2", "campaign_id": "camp1_id"}]
  }}'`

* curl to filter users
  `curl --location '209.38.225.96:80/users'/filter?campaign_names=camp2'`
