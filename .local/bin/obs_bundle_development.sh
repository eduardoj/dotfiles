#!/usr/bin/env bash

set -x

# chunk_of_text="  # solargraph
#   gem 'solargraph'
# "

chunk_of_text="  # ruby-lsp
  gem 'ruby-lsp'
  # ruby-lsp-rails
  gem 'ruby-lsp-rails'
  # ruby-lsp-rspec
  gem 'ruby-lsp-rspec'
  # ruby-lsp-factory_bot
  gem 'ruby-lsp-factory_bot'
"

cp src/api/Gemfile src/api/Gemfile.development
perl -0777 -pi -e "s/(group :development do\n)/\$1$chunk_of_text/gm" src/api/Gemfile.development
cd src/api || exit
rm -rf Gemfile.development.lock vendor/bundle.development/
BUNDLE_GEMFILE=Gemfile.development BUNDLE_PATH=vendor/bundle.development bundle install
cd - || exit
rm -rf src/api/vendor/cache
git restore src/api/vendor/cache/
