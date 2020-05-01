---
layout: default
---

<h1 class="mb-2">Latest</h1>

{% assign latest = site.posts.first %}

<article>
    {% include post_entry.html post_entry=latest display_excerpt=false %}
    <div>
        {{ latest.content }}
    </div>
</article>
