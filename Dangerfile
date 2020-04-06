# Reminders for writing a draft
is_adding_draft = !(git.added_files.grep(/_drafts/).empty?)
is_editing_draft = !(git.modified_files.grep(/_drafts/).empty?)
if is_editing_draft || is_adding_draft
  warn("Looks like you are editing a draft. Don't forget to publish when it's finished!")
end

# Setup for prose-lint
prose.language = "en-us"
prose.ignore_acronyms = true
prose.ignore_numbers = true

# Look for prose issues
prose.lint_files

# Look for spelling issues
prose.ignored_words = [
    "twc", "TWC"
]
prose.check_spelling
