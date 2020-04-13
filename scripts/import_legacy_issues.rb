#!/usr/bin/env ruby

# frozen_string_literal: true

# Script to import legacy newsletter issues from Mailchimp archives into this
# new Jekyll-based format. This implementation is very specific to the format
# of this particular Mailchip archive, and hardcodes the output as belonging to
# "Volume 1".
#
# To run: ./scripts/import_legacy_issues.rb

require 'date'
require 'open-uri'
require 'nokogiri'
require 'reverse_markdown'

# Turns a string into Title Case.
def titleize(input)
  input.strip.split(/[[:space:]]/).map(&:capitalize).join(' ')
end

# Generates the front matter part of the issue.
def front_matter(issue)
  <<~FRONT_MATTER
    ---
    layout: post
    title: 'Issue #{issue[:number]}: #{issue[:title]}'
    category: Volume 1
    image:
        file: #{issue[:image][:file]}
        alt: #{issue[:image].fetch(:caption, 'null')}
        caption: #{issue[:image].fetch(:caption, 'null')}
        source_link: null
        half_width: false
    ---
  FRONT_MATTER
end

FORMAT_MARKERS = ['_', '**'].freeze
PARAGRAPH_SEPARATOR = "  \n  \n"
# Tweaks the markdown that reverse-markdown produces, to close formatting
# markers at each paragraph break.
def close_paragraph_formatters(markdown)
  in_format = nil
  markdown.split("\n").map do |paragraph|
    FORMAT_MARKERS.each do |marker|
      in_format = marker if paragraph.start_with?(marker)
    end
    if in_format && !paragraph.start_with?(in_format)
      paragraph = in_format + paragraph
    end
    if in_format && paragraph.strip.end_with?(in_format)
      # We're exiting this formatted block.
      in_format = nil
    elsif in_format
      paragraph << in_format
    end
    paragraph
  end.join("\n")
end

def to_markdown(html)
  close_paragraph_formatters(ReverseMarkdown.convert(html))
end

# Extracts the first image in the document only.
def extract_image(doc, issue_number)
  image_block = doc.at_css('.mcnImageCardBlockInner')
  return { file: nil, caption: nil } unless image_block

  img_url = image_block.at_css('img').attribute('src').value
  caption = image_block.at_css('.mcnTextContent')
                       .inner_text.dup.gsub("\n", ' ').strip
  return { file: nil, caption: nil } unless img_url

  file = "vol-1-issue-#{issue_number}-header.#{img_url.split('.').last}"
  IO.copy_stream(open(img_url), "img/#{file}")
  image_block.remove

  { file: file, caption: caption }
end

def text_blocks(doc)
  blocks = doc.at_css('#templateHeader').css('.mcnTextContent') +
           doc.at_css('#templateBody').css('.mcnTextContent')
  blocks ? blocks : doc.css('.mcnTextContent')
end

# Extracts all the content sections form the document.
def extract_sections(doc)
  sections = []
  title = ''
  content = ''
  text_blocks(doc).each do |block|
    if block.at_css('h1')
      # Output any captured content to sections array, start new section.
      sections << { title: title, content: content } unless title.empty? && content.empty?
      title = titleize(block.at_css('h1').inner_text)
      content = ''
    else
      content += to_markdown(block.inner_html)
    end
  end
  # Add final section to array.
  if !title.empty? && !content.empty?
    sections << { title: title, content: content }
  end
  sections
end

# Generates excerpt string.
def excerpt(issue)
  <<~EXCERPT

    <!-- Content imported from: #{issue[:url]} -->

    #{issue[:sections].first[:content].split(PARAGRAPH_SEPARATOR).first}

    <!--excerpt-->

    {% include post_image.html %}

  EXCERPT
end

def write_to_file(issue)
  filename = "_posts/#{issue[:date]}-issue-#{issue[:number]}.md"

  open(filename, 'w') do |file|
    file.puts front_matter(issue)
    file.puts excerpt(issue)
    issue[:sections].each_with_index do |section, _index|
      file.puts "### #{section[:title]}\n\n" unless section[:title].strip.empty?
      file.puts section[:content] unless section[:content].strip.empty?
      file.puts "\n\n"
    end
  end
end

# Imports the issue at the given URL with the provided metadata.
# @params [Hash] issue A hash with title, date and url keys. Represents the issue to import.
def import_issue(issue)
  puts "Importing issue: #{issue}"
  issue_doc = Nokogiri::HTML(open(issue[:url]))
  issue[:image] = extract_image(issue_doc, issue[:number])
  issue[:sections] = extract_sections(issue_doc)
  write_to_file(issue)
end

# Extracts the actual issue title from the email subject line.
# The subject lines are in three different formats:
# "Some Actual Title - Tech Workers Coalition Update DD/MM"
# "Tech Workers Coalition Update DD/MM - Some Actual Title"
# "Tech Workers Coalition Update DD/MM" (has no special title)
def extract_issue_title(text)
  # Some of the titles have linebreaks and other non-human-friendly spaces.
  # This gsub turns all the spaces into neat spaces like humans type.
  parts = text.gsub(/[[:space:]]/, ' ').split(' - ')
  if parts.first.start_with?('Tech Workers Coalition Update')
    parts.last.strip
  else
    parts.first.strip
  end
end

# Imports all issues listed in the given Mailchimp archive URL.
# @params [String] archive_url
def import_from_archive(_archive_url)
  archive_doc = Nokogiri::HTML(open(MAILCHIMP_ARCHIVE_URL))
  issues_metadata = archive_doc.at_css('ul#archive-list').css('li').map do |li|
    {
      url: li.at_css('a').attribute('href').value,
      date: Date.strptime(
        li.children.first.inner_text.match(/(.*)\b/)[1], '%m/%d/%Y'),
      title: extract_issue_title(li.children.last.inner_text)
    }
  end
  puts "Found #{issues_metadata.size} issues in archive. Starting import."

  issues_metadata = issues_metadata.sort_by { |issue| issue[:date] }.map.with_index do |issue, index|
    issue[:number] = index + 1
    issue
  end
  issues_metadata.each { |issue| import_issue(issue) }
end

###
# Main script entrypoint.
###

MAILCHIMP_ARCHIVE_URL = 'https://us11.campaign-archive.com/home/?u=194e57c175176cfd13007a197&id=7cb85d276a'
puts "Importing issues from Mailchimp archive URL: #{MAILCHIMP_ARCHIVE_URL}"
import_from_archive(MAILCHIMP_ARCHIVE_URL)
