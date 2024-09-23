{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if settings.pagination == 'infinite' %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 15 %}
	{% else %}
		{% paginate by 12 %}
	{% endif %}
{% else %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 50 %}
	{% else %}
		{% paginate by 48 %}
	{% endif %}
{% endif %}

{% if not show_help %}

{% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
{% set has_category_description_without_banner = not category_banner and category.description %}

{% if category_banner %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}

{% if category.description or not category_banner %}
	<div class="container">
		{% set page_header_padding = category.description ? false : true %}
		{% set page_header_classes = category.description ? 'pt-4 pb-2 pt-md-4 pb-md-2' %}
		{% if not category_banner %}
			{% embed "snipplets/page-header.tpl" with {container: false, padding: page_header_padding, page_header_class: page_header_classes} %}
			    {% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
			{% endembed %}
		{% endif %}
		{% if category.description %}
			<p class="{% if category_banner %}my-4 py-md-2 text-center{% else %}mb-4 pb-1{% endif %}">{{ category.description }}</p>
		{% endif %}
	</div>
{% endif %}

{% include 'snipplets/grid/filters-modals.tpl' %}

<section class="category-body {% if settings.filters_desktop_modal %}pt-md-2{% endif %}" data-store="category-grid-{{ category.id }}">
	<div class="container mt-3 mb-5">
		<div class="row" style="margin-top: 30px; margin-bottom: 30px;">
			{% include 'snipplets/grid/filters-sidebar.tpl' %}
			{% include 'snipplets/grid/products-list.tpl' %}
		</div>

		{% if category.id == 26390831 %}
		<div class="row descricao-dna">
		
		<div class="col">
		<h2 style="color: #1E1E1E; font-size: 16px;">Últimos Lançamentos</h2>
		<p style="color: #ACACAC; font-size: 14px;">Quando se fala em venda de sandálias, estamos entrando em um universo onde a elegância encontra a casualidade, transitando entre o conforto diurno e o requinte noturno sem esforço. A sandália feminina não é apenas um item de vestuário, mas uma extensão da personalidade e do estilo de vida de quem as usa. Hoje, decifrar os segredos por trás de uma sandália feminina de qualidade é fundamental tanto para a vendedora quanto para a consumidora final.</p>
		</div>
		
		<div class="col">
		<h2 style="color: #1E1E1E; font-size: 16px;">O Significado Por Trás de Cada Par</h2>
		<p style="color: #ACACAC; font-size: 14px;">Ao olhar para as prateleiras repletas de sandálias femininas você já se perguntou o que torna cada par único? Não é somente o design ou o material, é a história que esses calçados contam. Cada par de sandálias é uma narrativa prestes a ser entrelaçada com a jornada individual da cliente. O artesão que escolhe o couro, o designer que pensa cada curva, e o sorriso de satisfação da mulher quando encontra “aquela” sandália, tudo isso compõe a tapeçaria rica e colorida do comércio desse item atemporal.</p>
		</div>
		
		</div>
		
		{% endif %}

		{% if category.id == 26390832 %}
		<div class="row descricao-dna">
		
		<div class="col">
		<h2 style="color: #1E1E1E; font-size: 16px;">A Arte e a Versatilidade na Venda de Sandálias</h2>
		<p style="color: #ACACAC; font-size: 14px;">Quando se fala em venda de sandálias, estamos entrando em um universo onde a elegância encontra a casualidade, transitando entre o conforto diurno e o requinte noturno sem esforço. A sandália feminina não é apenas um item de vestuário, mas uma extensão da personalidade e do estilo de vida de quem as usa. Hoje, decifrar os segredos por trás de uma sandália feminina de qualidade é fundamental tanto para a vendedora quanto para a consumidora final.</p>
		</div>
		
		<div class="col">
		<h2 style="color: #1E1E1E; font-size: 16px;">O Significado Por Trás de Cada Par</h2>
		<p style="color: #ACACAC; font-size: 14px;">Ao olhar para as prateleiras repletas de sandálias femininas você já se perguntou o que torna cada par único? Não é somente o design ou o material, é a história que esses calçados contam. Cada par de sandálias é uma narrativa prestes a ser entrelaçada com a jornada individual da cliente. O artesão que escolhe o couro, o designer que pensa cada curva, e o sorriso de satisfação da mulher quando encontra “aquela” sandália, tudo isso compõe a tapeçaria rica e colorida do comércio desse item atemporal.</p>
		</div>

		</div>
		{% endif %}

	</div>
</section>
{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}