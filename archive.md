---
layout: standalone
title: Archive
---

<div class="mt-4">
{% for category in site.categories reversed %}

<h2 class="text-secondary">{{ category[0] }}</h2>
<hr width="100%">
{% for post in category[1] %}
<article class="mb-4">
    {% include post_entry.html post_entry=post display_excerpt=true %}
</article>
{% endfor %}

{% endfor %}
</div>
