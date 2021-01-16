#!/usr/bin/env ruby

require 'date'

if ARGV.count != 3
  abort("Incorrect arguments. Must pass volume #, issue #, and date YYYY-MM-DD.

Example Usage: ./scripts/new_post.rb 3 5 2021-01-15
This will create a post for Vol 3, Issue 5 at _posts/2021-01-15-issue-5.md

")
end

volume = "#{ARGV[0]}".strip
if volume.to_i <= 0
  abort("Invalid volume number: #{volume}\nEnter a number greater than 0.")
end 

issue = "#{ARGV[1]}".strip
if issue.to_i <= 0
  abort("Invalid issue number: #{issue}\nEnter a number greater than 0.")
end

date = "#{ARGV[2]}".strip
if !(date.length == 10 && date =~ /\d{4}-{1}\d{2}-{1}\d{2}/)
  abort("Invalid date: #{date}\nMust be in YYYY-MM-DD format and be a valid date.")
end

begin
    d = DateTime.strptime(date, "%Y-%m-%d")
  rescue => error
    abort("Invalid date: #{date}\nMust be in YYYY-MM-DD format and be a valid date.")
end

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

<!-- adding another image example -->
<!-- fields are same as header images -->
<!-- delete if not needed -->
{% include image.html
  file='TODO: file name'
  alt='TODO: alt text'
  caption='TODO: caption text'
  source_link='TODO: link to source or null'
  half_width=false
%}

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
