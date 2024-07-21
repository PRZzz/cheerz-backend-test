# README

Suggested solution for the [Problem Statement](./problem_statement.pdf) of Cheerz's backend technical test.

* [Starting The Application](#starting-the-application)
* [Database Structure](#database-structure)
* [Future Developments](#future-developments)
  * [Needed Evolutions](#needed-evolutions)
  * [Code Maintenability](#code-maintenability)
  * [Minor Improvements To Validate](#minor-improvements-to-validate)

## Starting The Application

To run locally the application, follow these steps:

* Install Postgresql
  * The chosen version must support `pgcrypto` and `plpgsql` extensions (I used version 14.12 when developing)
* Install the ruby version specified in the `Gemfile`
* Install dependencies: `bundle install`
* Setup the database: `rails db:setup`
* Run the server: `rails s`

## Database Structure

Database was created as simple as possible with a table for our users (`users`) and a table that can be seen as a "queue" (`fallback_usernames`) to hold usernames to fallback to when the user tries to signup with one already taken.

The only specifity (which is still pretty common) is the use of UUID as primary key as I consider it more safe and future-proof.

## Future Developments

This project aims to be a **very** simple solution (and could be seen as a proof of concept). There is still a lot to be done if we want it to be production-ready.

Below are lists of developments that would improve this project, organized by category.

### Needed Evolutions

All the listed evolutions here should be done as soon as possible.

* Change default value for `username` columns in factory to a more robust method that uses `sequence` (cf [doc](https://github.com/thoughtbot/factory_bot/blob/main/GETTING_STARTED.md#inline-sequences)) to avoid the easy creation of flaky tests.
* Log / Alert somewhere when the error `NO_FALLBACK_USERNAME_FOUND_ERROR` is encountered.

### Code Maintenability

If the project needs to grow, these are the subjects we can work on to make development easier.

* Setup a CI/CD
* Coding style guideline (e.g. rubocop)

### Minor Improvements To Validate

* Make `username` the primary key of the table `fallback_usernames`
* Changes the `username` columns to a `VARCHAR(3)` (`limit: 3` in rails schema.db)
