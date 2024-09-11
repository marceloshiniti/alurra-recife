<ul class="list-unstyled">
    {% for language in languages %}
        <li class="mb-4{% if language.active %} font-weight-bold{% endif %}">
            <a href="{{ language.url }}">
                <img class="lazyload mr-1" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" />
                {{ language.country_name }}
            </a>
        </li>
    {% endfor %}
</ul>
