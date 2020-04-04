.DEFAULT: build

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: install
install:
	bundle install
	yarn install --modules-folder yarn_deps

.PHONY: update
update:
	bundle update
	yarn upgrade --latest --modules-folder yarn_deps

.PHONY: watch
watch:
	bundle exec jekyll build --watch

.PHONY: incr
incr:
	bundle exec jekyll build --watch --incremental

.PHONY: future
future:
	bundle exec jekyll build --watch --future

.PHONY: draft
draft:
	bundle exec jekyll build --watch --future --drafts

.PHONY: serve
serve:
	bundle exec jekyll serve

.PHONY: new
new:
	./scripts/new_post.rb
