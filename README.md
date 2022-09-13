This is my first solo (non-tutorial) Rails project. It's a simple CRM made for a client to have easy access to information about their clients and their appointments. It has a full test suite, custom made authentication, and is easy to use.

If you want to try it out on your system you should have Ruby 3.0.2 installed and:

 - clone the repo
 - run `cd zvjezdana`
 - run `bundle install`
 - run `rails db:migrate`
 - delete the `credentials.yml.enc` file inside the projects config directory
 - add a username to encrypted credentials (run `rails credentails:edit` in your terminal and add a new line `username: "whatever"`)
 - start a `rails console`
 - add a user with the username you just added to credentials.yml. E.g. `User.create(username: "whatever", password: "test", password_confirmation: "test")`
 - Run `rails server`
 - go to `localhost:3000` in your browser and you're ready to go.

To run the full test suite run `rails test:system test` in your terminal. Get ready for flashing chrome windows because I didn't use headless browser for system tests since it's a small app and it just looks cooler :)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)