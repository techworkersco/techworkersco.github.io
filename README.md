# TWC Newsletter

### ⚠️ work in progress ⚠️

<img src="https://raw.githubusercontent.com/techworkersco/newsletter/master/img/newsletter-team.png" width="250"/>

## About

> TODO:

Built with [Jekyll](https://jekyllrb.com), [Bootstrap](https://getbootstrap.com), [jQuery](https://jquery.com). Hosted with [GitHub Pages](https://pages.github.com).

## Requirements

- [Bundler](https://bundler.io)
- [Yarn](https://yarnpkg.com/en/)

## Dependencies

### Gems

- [jekyll](https://jekyllrb.com) ([Latest](https://github.com/jekyll/jekyll/releases/latest)) ([Cheat Sheet](https://learn.cloudcannon.com/jekyll-cheat-sheet/))
- [jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap)
- [jekyll-paginate](https://github.com/jekyll/jekyll-paginate)

### Yarn

- [Bootstrap](https://getbootstrap.com) ([pkg](https://yarnpkg.com/en/package/bootstrap))
- [jQuery](https://jquery.com) ([pkg](https://yarnpkg.com/en/package/jquery))

### Updating dependencies

```bash
$ make update
```

## Usage

### Installation

```bash
$ git clone https://github.com/techworkersco/newsletter.git
$ cd newsletter
$ make install
$ make
```

### Building the site

Various options using `make`:

```bash
$ make build # build the site once
$ make watch # build and watch for changes
$ make incr # build incrementally and watch for changes
$ make future # build once and allow future posts
```

### Previewing the site locally

```bash
$ make serve # browse to http://localhost:4000
```

### Writing a draft

```bash
$ bundle exec jekyll serve --future --drafts --watch
```

### Handling Links

- To other posts: `[link]({{ site.url }}{% post_url 2000-01-01-issue-title %})`
- To images: `{{ site.url }}{{ site.img_url}}/path-to/image.png`

## Contributing

> TODO:

## Conduct

Please read our [Code of Conduct](https://github.com/techworkersco/newsletter/blob/master/.github/CODE_OF_CONDUCT.md). Violations will not be tolerated and will result in immediate removal or blocking from the organization.

## License

This work is released under the [CC0 1.0 Universal (CC0 1.0) license](https://creativecommons.org/publicdomain/zero/1.0/). See [`LICENSE`](https://github.com/techworkersco/newsletter/blob/master/LICENSE).

All code is licensed under an [MIT License](https://opensource.org/licenses/MIT).
