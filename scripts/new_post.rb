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

> TODO: excerpt
>
> Something inspiring and joyful about what’s going on.
>
> Something funny/clever/humorous about what we can do.

<!--excerpt-->

{% include post_image.html %}

## The Worker's Perspective

> TODO:
>
> A short blurb highlighting one worker-led effort (a strike, an appeal, etc.)
>
> Another blurb highlighting something less known/underrepresented in the Bay Area or US.
>
> A longer blurb with commentary about “What this all means” (our analysis),
> and ideally with take-aways that would-be allies can use (not quite a call to action)

## In The News

> TODO:
>
> A curated collection of 3-10 links to other efforts around the world or relevant articles.

## In History

> TODO:
>
> Highlight a connection to historical context. Situate ourselves in this moment in history.
>
> Highlight a previous tech worker collective action from collectiveactions.tech

## In Song

#### Song title + link

> TODO:
>
> A brief excerpt of lyrics from an inspirational song
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
