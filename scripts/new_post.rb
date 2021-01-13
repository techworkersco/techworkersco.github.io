#!/usr/bin/env ruby

require 'date'

issue = !ARGV.empty? ? "#{ARGV[0]}" : "N"
date = ARGV.count > 1 ? "#{ARGV[1]}" : Date.today

puts "Generating new post for issue #{ issue }..."

post_contents = %(---
layout: post
title: 'Issue #{ issue }: TITLE'
category: Volume 3
image:
    file: 'vol-3-issue-#{ issue }-header.jpg'
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

puts "Created #{ path }"
puts "Done!"
