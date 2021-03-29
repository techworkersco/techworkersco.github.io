.DEFAULT: build

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: install
install:
	bundle install
	yarn install --modules-folder yarn_deps

.PHONY: update-all
update-all: update-bundle update-yarn

.PHONY: update-bundle
update-bundle:
	bundle update --all
	bundle update --bundler

.PHONY: update-yarn
update-yarn:
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

.PHONY: serve-all
serve-all:
	bundle exec jekyll serve --future --drafts

.PHONY: new-issue
new-issue:
	./scripts/new_post.rb $(volume) $(issue) $(date)

.PHONY: image
image:
	./scripts/optimize-image.sh $(file)
