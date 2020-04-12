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
    file: null
    alt: null
    caption: null
    source_link: null
    half_width: false
---

> TODO: excerpt
>
> Something inspiring and joyful about what’s going on.
> Something funny/clever/humorous about what we can do.

<!--excerpt-->

### Focus

> TODO: focus
>
> A short blurb highlighting one worker-led effort (a strike, an appeal, etc.)
> Another blurb highlighting something less known/underrepresented in the Bay Area or US.
> A longer blurb with commentary about “What this all means” (our analysis),
> and ideally with take-aways that would-be allies can use (not quite a call to action)

### In the news

> TODO: news
>
> A curated collection of 3-10 links to other efforts around the world or relevant articles.

### Song of the week

> TODO: song
>
> A brief excerpt of lyrics from an inspiration song
>
> Include a link to a video/audio recording. (YouTube, Spotify, Bandcamp, etc.)

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
