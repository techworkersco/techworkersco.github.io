# Documentation

*This document reviews working with this site and how publishing works.*

- [Technical](#Technical)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
- [Generating a new issue](#generating-a-new-issue)
- [Labels](#labels)
- [Writing and Publishing](#writing-and-publishing)
  - [Markdown](#markdown)
  - [Images](#images)
  - [Process](#process)
  - [How we publish](#how-we-publish)
    - [Automation](#automation)
    - [Emails](#emails)
    - [Tweets](#tweets)
- [Issue Template](#issue-template)
  - [Front Matter](#front-matter)
  - [Categories as "Volumes"](#categories-as-volumes)
  - [Header images](#header-images)
  - [Other images](#other-images)
  - [Handling Links](#handling-links)

# Technical

*A technical overview of how the site works.*

You'll need [Bundler](https://bundler.io) and [Yarn](https://yarnpkg.com/en/) installed.

### Dependencies

**Gems**
- [jekyll](https://jekyllrb.com) ([Latest](https://github.com/jekyll/jekyll/releases/latest)) ([Cheat Sheet](https://learn.cloudcannon.com/jekyll-cheat-sheet/))
- [jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap)
- [jekyll-paginate](https://github.com/jekyll/jekyll-paginate)
- [danger](https://danger.systems/ruby/)

**Yarn**
- [Bootstrap](https://getbootstrap.com) ([pkg](https://yarnpkg.com/en/package/bootstrap))
- [jQuery](https://jquery.com) ([pkg](https://yarnpkg.com/en/package/jquery))

> Note: we specify a custom install path `./yarn_deps/` to workaround GH-pages ignoring `./node_modules/`.

**Other**
- [FontAwesome 5](https://fontawesome.com)

### Usage

#### Installation

```bash
$ git clone https://github.com/techworkersco/techworkersco.github.io.git
$ cd techworkersco.github.io/
$ make install
$ make
```

#### Building the site

```bash
$ make build  # build the site once
$ make watch  # build and watch for changes
$ make incr   # build incrementally and watch for changes
$ make future # build once and allow future posts
$ make draft  # build and watch, including _drafts/
```

#### Previewing the site locally

```bash
$ make serve     # browse to http://localhost:4000
$ make serve-all # build and serve future and draft posts
```

#### Updating dependencies

```bash
$ make update
```

# Generating a new issue

You can generate a new issue template in two ways.

This will generate an empty issue template in `_posts/` with the specified volume number, issue number, and date.

### GitHub Actions

1. Go to our [Create New Issue action](https://github.com/techworkersco/techworkersco.github.io/actions/workflows/new-issue-pr.yml?query=workflow%3A%22Create+New+Issue%22).
1. Click "Run workflow" on the right.
1. Select `Branch: master` (should be auto-selected).
1. Enter the `Volume #`, `Issue #`, and `Date` for the issue. **Note:** The date **must** be in `YYYY-MM-DD` format.
1. Click "Run workflow".
1. After a few seconds, the process should start and appear in the list.
1. It should only take a few minutes to run. Once complete :white_check_mark:, [click here](https://github.com/techworkersco/techworkersco.github.io/pulls) to see the new pull request with the issue that you specified.

> :bulb: **Troubleshooting:** If the workflow fails, it will display an :x: next to itself [in the list](https://github.com/techworkersco/techworkersco.github.io/actions/workflows/new-issue-pr.yml?query=workflow%3A%22Create+New+Issue%22). Click the workflow to view the logs and see what went wrong.

### Manually

Run the script locally, commit your changes, and open a pull request.

```bash
$ make new-issue volume=3 issue=5 date=2021-02-15
```

# Labels

We use various [labels](https://github.com/techworkersco/techworkersco.github.io/labels) to automate workflows. These special labels are all purple. Each has a description explaining what it does. Below are some of the most important.

### `auto-publish` label

The bot begins checking for pull requests with the `auto-publish` label [at `07:00am PST` or `08:00am PDT` every morning](https://github.com/techworkersco/techworkersco.github.io/blob/master/.github/workflows/auto-publish.yml). (The time discrepancy is because of daylight savings, and we can only provide a single time in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time). So this is the best compromise to meet our 10:00am MailChimp deadline and still have room for last-minute fixes or edits.)

The bot will check for `auto-publish` pull requests every 30 minutes for 3 hours, so `07:00-10:00am PST` or `08:00-11:00am PDT`.

The bot will merge the pull request **if and only if**:
- The PR has the `auto-publish` label
- All status checks succeeded :white_check_mark:
- The PR has been approved by at least 1 person on the [newsletter team](https://github.com/orgs/techworkersco/teams/newsletter-folks/members) :white_check_mark:

### `needs optimize images` label

If you add `needs optimize images` to a pull request, the bot will optimize images for you and commit the changes to the pull request branch.

See [Images](#images) for more details.

# Writing and Publishing

*Tips and other information for core contributors.*

## Markdown

Issues are written in Markdown. Learn about Markdown [in this guide](https://guides.github.com/features/mastering-markdown/).

## Images

All images **must** be placed in [`img/`](https://github.com/techworkersco/techworkersco.github.io/tree/master/img).

> :bulb: Prefer `jpg` as it compresses better than other formats.

> :warning: Be sure to run [ImageOptim](https://imageoptim.com/mac) on all images to reduce their file size.

On a pull request, add the `needs optimize images` label to trigger the bot to optimize images.

To manually optimize an image, you can run `make image`:

```bash
$ make image file=my-image-file.png
```

## Process

See our [Process documentation](https://github.com/techworkersco/techworkersco.github.io/blob/master/.github/PROCESS.md).

## How we publish

Everything centers around our [git](https://git-scm.com) workflow and GitHub. Once [pull requests](https://github.com/techworkersco/techworkersco.github.io/pulls) are merged, the site is rebuilt and deployed. This includes generating an RSS feed.

### Automation

We have a number of automated checks than run various verifications on pull requests, as well as tasks like checking spelling and checking for dead links.

Pull request reviews are partially automated with the help of [Danger](https://danger.systems/ruby/).

You can see all of our [GitHub Actions workflows here](https://github.com/techworkersco/techworkersco.github.io/actions).

### Emails

Emails are sent via Mailchimp using the [RSS-to-email feature](https://mailchimp.com/features/rss-to-email/). After merging a new post to `master`, an RSS feed entry is added as part of regenerating the site. Mailchimp checks for updates to the RSS feed, and after finding a new entry an email is generated and sent.

Emails are sent from **news-noreply@techworkerscoalition.org**.

### Tweets

We use [IFTTT](https://ifttt.com) to auto-tweet new issues from the RSS feed to [our Twitter account](https://twitter.com/twcnewsletter). The bot checks for new posts every hour and if it finds one, it sends a tweet.

# Issue Template

You can find a default issue template at [`_drafts/template.md`](https://github.com/techworkersco/techworkersco.github.io/blob/master/_drafts/template.md).

> :warning: All issues should include an `<!--excerpt-->` tag. (Spelled exactly like this.)

The excerpt tag is used for social media preview text, as well as the snippet on [the archive page](https://news.techworkerscoalition.org/archive/).

See [Generating a new issue](#generating-a-new-issue) for more details.

### Front Matter

Below is an explanation of our Jekyll [front matter](https://jekyllrb.com/docs/front-matter/) fields.

```yaml
---
layout: post
title: ! 'Issue N: TITLE' # where N is the issue number
category: Volume N        # where N is the volume number
image:
    file: vol-N-issue-N-header.jpg
    alt: 'img alt text'
    caption: 'img caption text'
    source_link: 'link to img external source'
    half_width: false     # img layout style
preview: 'preview text for emails + social media'
---
```

We always use the `post` layout, and the `title` should take the form: `Issue 1: My Title`.

The `preview` field is used to generate the email and social media preview text. If not provided, the post excerpt will be used.

### Categories as "Volumes"

We use a single `category:` field in the Jekyll [front matter](https://jekyllrb.com/docs/front-matter/) to specify a "Volume" for each issue.

These are the valid values for this field:

- `Volume 1` represents the original, legacy newsletter 2018-2019
- `Volume 2` this project, the reboot, beginning in early 2020
- `Volume 3` 2021
- `Volume 4` 2022
- etc.

### Header images

Every post should include a header image, which is specified by the `image:` field in the front matter.

- `file` **(required, string)** specifies the filename only. (example: `vol-1-issue-1-header.jpg`)

- `alt` **(optional, string)** specifies the contents of the `img` tag `alt` attribute.

- `caption` **(optional, string)** the caption text to be displayed below the image.

- `source_link` **(optional, link)** a link to the original source of the image, to be displayed as a link title "Source" below the image.

- `half_width` **(optional, boolean)** specifies the image layout. If `false` (the default), the image will expand to the full width of the container. If `true`, the image is centered and expands to 50% of the container width. This should almost always be `false`.

### Other Images

If desired, you can also include additional images in the body of the issue using the `image.html` include, which receives the same parameters as header images.

```jekyll
{% include image.html
    file='file name'
    alt='alt text'
    caption='caption text'
    source_link='link to source or null'
    half_width=false
%}
```

### Handling Links

> :warning: **Relative links in posts should be avoided.**
>
> Because the newsletter email is generated from the RSS feed, site links must be prepended with `{{ site.url }}`, for example:
>
> `[about]({{ site.url}}/about/)`

- To other posts: `[link]({{ site.url }}{% post_url 2000-01-01-issue-title %})`
- To other images: `{{ site.url }}{{ site.img_url}}/image-name.jpg`
