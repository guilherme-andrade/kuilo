web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
assets: webpack-dev-server
worker: bundle exec sidekiq -C config/sidekiq.yml
