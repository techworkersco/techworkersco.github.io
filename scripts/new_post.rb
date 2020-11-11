#!/usr/bin/env ruby

require 'date'

issue = !ARGV.empty? ? "#{ARGV.first}" : "N"

puts "Generating new post for issue #{ issue }..."

date = Date.today

post_contents = %(---
layout: post
title: 'Issue #{ issue }: TITLE'
category: Volume 2
image:
    file: 'vol-2-issue-#{ issue }-header.jpg'
    alt: 'some img-alt text'
    caption: 'some caption text for the image'
    source_link: 'optional link to external source for image'
    half_width: false
preview: 'Some preview text for emails and social media sharing'
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

drafts = "_drafts"
file_name = "#{ date }-issue-#{ issue }.md"
path = "#{ drafts }/#{ file_name }"

Dir.mkdir("#{ drafts }") unless File.exists?("#{ drafts }")

open("#{ path }", "w") { |f|
  f.puts post_contents
}

puts "Created #{ path }"
puts "Done"
