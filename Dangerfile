is_next_issue = github.pr_labels.any? { |label| label.include? "next issue" }

# -----------------------------------------------------------------------------
# Uploading images
# -----------------------------------------------------------------------------
if is_next_issue
  message(":camera: To add images to this issue, [upload them here](https://github.com/techworkersco/techworkersco.github.io/upload/#{github.branch_for_head}/img).")
end

# -----------------------------------------------------------------------------
# All pull requests should be submitted to master branch
# -----------------------------------------------------------------------------
if github.branch_for_base != "master"
    warn("Pull requests should be submitted to the `master` branch only.")
end

# -----------------------------------------------------------------------------
# Tips for auto-publishing
# -----------------------------------------------------------------------------
has_auto_publish_label = github.pr_labels.any? { |label| label.include? "auto-publish" }
if is_next_issue && !has_auto_publish_label
  message(":bulb: **Tip:** add the `auto-publish` label to [automatically publish this issue tomorrow morning](https://github.com/techworkersco/techworkersco.github.io/blob/master/.github/DOCUMENTATION.md#labels).")
end

# -----------------------------------------------------------------------------
# Reminder for writing a draft
# -----------------------------------------------------------------------------
is_adding_draft = !(git.added_files.grep(/_drafts/).empty?)
is_editing_draft = !(git.modified_files.grep(/_drafts/).empty?)
if is_editing_draft || is_adding_draft
    fail("Looks like you are editing a draft. Drafts will not be published.")
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
      fail("Missing excerpt tag `<!--excerpt-->`. Please add the excerpt tag where you'd like this post to break for the preview. ([docs here](https://github.com/techworkersco/techworkersco.github.io/blob/master/.github/DOCUMENTATION.md#issue-template))", file: filename)
    end

    if !(file.include?("{% include post_image.html %}"))
      warn("**Header image not included in the markdown file!** Add `{% include post_image.html %}` where you would like to place the image.", file: filename)
    end
end
