#!/usr/bin/env ruby

require 'date'

if ARGV.count != 3
  abort("Incorrect arguments. Must pass volume #, issue #, and date YYYY-MM-DD.

Example Usage: ./scripts/new_post.rb 3 5 2021-01-15
This will create a post for Vol 3, Issue 5 at _posts/2021-01-15-issue-5.md

")
end

volume = "#{ARGV[0]}"
issue = "#{ARGV[1]}"
date = "#{ARGV[2]}"

puts "Generating new post for Volume #{volume}, Issue ##{ issue } with date #{ date }..."

post_contents = %(---
layout: post
title: 'Issue #{ issue }: TITLE'
category: 'Volume #{volume}'
image:
    file: 'vol-#{ volume }-issue-#{ issue }-header.jpg'
    alt: 'TODO'
    caption: 'TODO'
    source_link: 'TODO'
    half_width: false
preview: 'TODO'
---

> TODO

<!--excerpt-->

{% include post_image.html %}

## The Worker's Perspective

> TODO

## In The News

> TODO

## In History

> TODO

## In Song

#### [Song title + link]()

> TODO

)

dir = "_posts"
file_name = "#{ date }-issue-#{ issue }.md"
path = "#{ dir }/#{ file_name }"

open("#{ path }", "w") { |f|
  f.puts post_contents
}

puts "Successfully created #{ path }"
puts "Done!"
