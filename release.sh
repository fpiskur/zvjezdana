#!/usr/bin/env sh
# RAILS_ENV=production bin/rails db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1 &&
bin/rails db:migrate && bin/rails db:seed