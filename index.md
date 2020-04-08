---
layout: default
---

<h1>Latest <small>⚠️ WIP, coming soon ⚠️</small></h1>

{% assign latest = site.posts.first %}

<article>
    {% include post_entry.html post_entry=latest display_excerpt=false %}
    <div>
        {{ latest.content }}
    </div>
</article>
