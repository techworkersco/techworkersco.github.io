---
layout: standalone
title: Archive
---

You can find the [archive of the legacy newsletter here](https://us11.campaign-archive.com/home/?u=194e57c175176cfd13007a197&id=7cb85d276a).

{% for category in site.categories reversed %}

<h1>{{ category[0] }}</h1>
<hr width="100%">
{% for post in category[1] %}
<article class="mb-4">
    {% include post_entry.html post_entry=post display_excerpt=true %}
</article>
{% endfor %}

{% endfor %}
