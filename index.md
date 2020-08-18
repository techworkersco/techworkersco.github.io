---
layout: default
---

{% assign latest = site.posts.first %}

<article>
    {% include post_entry.html post_entry=latest display_excerpt=false
    hide_latest_badge=true %}
    <div>
        {{ latest.content }}
    </div>

    <nav aria-label="Read more in the archives">
        <ul class="pagination justify-content-center">
        <li class="page-item">
            <a class="page-link text-secondary" href="/archive/" title="{{ include.title }}">
                Read more in the archive
                <i class="fa fa-chevron-right" aria-hidden="true"></i>
            </a>
            </li>
        </ul>
    </nav>
</article>
