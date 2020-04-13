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
# Check spelling and prose
# -----------------------------------------------------------------------------
prose.language = "en-us"
prose.lint_files

prose.ignored_words = ["twc", "TWC"]
prose.check_spelling
