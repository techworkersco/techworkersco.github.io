---
layout: standalone
title: Archive
---

{% for category in site.categories reversed %}

<h3 class="text-secondary" id="{{ category[0]|slugify }}">{{ category[0] }}</h3>
<hr width="100%">
{% for post in category[1] %}
<article class="mb-4">
    {% include post_entry.html post_entry=post display_excerpt=true %}
</article>
{% endfor %}

{% endfor %}
