#!/usr/bin/env ruby

require 'date'

issue = !ARGV.empty? ? "#{ARGV.first}" : "N"

puts "Generating new post for issue #{ issue }..."

date = Date.today

post_contents = %(---
layout: post
title: ! 'Issue ##{ issue }'
image:
    file: null
    alt: null
    caption: null
    source_link: null
    half_width: false
---

> TODO: excerpt

<!--excerpt-->

### In the news

> TODO: news

### Song of the week

> TODO: song

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
