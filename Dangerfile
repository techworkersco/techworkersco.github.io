# -----------------------------------------------------------------------------
# All pull requests should be submitted to master branch
# -----------------------------------------------------------------------------
if github.branch_for_base != "master"
    warn("Pull requests should be submitted to the master branch only.")
end

# -----------------------------------------------------------------------------
# Reminder for compressing images
# -----------------------------------------------------------------------------
is_adding_images = !(git.added_files.grep(/img/).empty?)
is_editing_images = !(git.modified_files.grep(/img/).empty?)
if is_editing_images || is_adding_images
    warn("Adding images? Remember to compress them with [ImageOptim](https://imageoptim.com/mac).")
end

# -----------------------------------------------------------------------------
# Reminder for writing a draft
# -----------------------------------------------------------------------------
is_adding_draft = !(git.added_files.grep(/_drafts/).empty?)
is_editing_draft = !(git.modified_files.grep(/_drafts/).empty?)
if is_editing_draft || is_adding_draft
    warn("Looks like you are editing a draft. Don't forget to publish when it's finished!")
end

# -----------------------------------------------------------------------------
# Verify Jekyll template
#
# Borrowed from: https://github.com/artsy/artsy.github.io/blob/master/Dangerfile
# -----------------------------------------------------------------------------
active_files = (git.modified_files + git.added_files).uniq
posts = active_files
  .select { |file| file.start_with? '_posts/' }
  .select { |file| file.end_with?('.md') }

posts.each do |filename|
    file = File.read(filename)
    if !(file.include?("<!--excerpt-->"))
        fail("Missing excerpt. Please add the excerpt tag where you'd like this post to break for the preview.", file: filename)
        message("[Read the docs](https://github.com/techworkersco/techworkersco.github.io/blob/master/.github/DOCUMENTATION.md) for details.")
    end
end

# -----------------------------------------------------------------------------
# Check spelling and prose
# -----------------------------------------------------------------------------
prose.language = "en-us"
prose.ignore_numbers = true
prose.ignore_acronyms = true
prose.lint_files

prose.ignored_words = ["twc", "TWC",
    "DIY", "PPE", "coronavirus", "COVID-19", "technocapital", "rideshare",
    "Bezos", "Veena", "Dubal", "Elon", "Musk", 
    "Vox", "Uber", "Lyft", "Instacart", "Shipt", "Bandcamp", "Airbnb", "Kickstarter"
]
prose.check_spelling
