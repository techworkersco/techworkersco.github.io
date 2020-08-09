---
layout: default
---

{% assign latest = site.posts.first %}
{% if site.posts.size > 1 %}
{% assign previous = site.posts[1] %}
{% endif %}

<article>
    {% if previous %}
    <nav aria-label="See previous issue">
        <ul class="pagination justify-content-center">
        {% include previous.html url=previous.url title=previous.title %}
        </ul>
    </nav>
    {% endif %}

    {% include post_entry.html post_entry=latest display_excerpt=false
    hide_latest_badge=true %}
    <div>
        {{ latest.content }}
    </div>

    {% if previous %}
    <nav aria-label="See previous issue">
        <ul class="pagination justify-content-center">
        {% include previous.html url=previous.url title=previous.title %}
        </ul>
    </nav>
    {% endif %}
</article>
