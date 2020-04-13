---
layout: default
---

<h1>Latest</h1>

<h1 class="text-muted"><small>Volume 2 coming soon...</small></h1><br/>

{% assign latest = site.posts.first %}

<article>
    {% include post_entry.html post_entry=latest display_excerpt=false %}
    <div>
        {{ latest.content }}
    </div>
</article>
