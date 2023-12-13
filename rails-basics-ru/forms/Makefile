setup:
	bin/setup
	yarn
	bundler

start:
	bin/dev

console:
	bin/rails console

test:
	yarn run build
	yarn run build:css
	NODE_ENV=test bin/rails test
	cat Gemfile | grep simple_form

.PHONY: test
