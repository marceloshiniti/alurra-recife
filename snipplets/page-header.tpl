{# /*============================================================================
  #Page header
==============================================================================*/

#Properties

#Title

#Breadcrumbs

#}

{% set padding = padding ?? true %}
{% set container = container ?? true %}
{% set page_header_title_default_classes = template == 'product' ? 'h1-md' : 'h1-huge-md' %}

{% if template == 'category'%}
            <div class="row" style="padding: 1.5rem 15px 0 15px; border-bottom: 1px solid rgba(30, 30, 30, 0.14);">{% include 'snipplets/breadcrumbs.tpl' %}</div>
{% endif %}

{% if container %}
	<div class="container">
{% endif %}
		<section class="page-header {% if padding %}py-4{% endif %} {{ page_header_class }}" data-store="page-title">
				<h1 class="h2 {{ page_header_title_default_classes }} {{ page_header_title_class }} titulo-dna" {% if template == "product" %}data-store="product-name-{{ product.id }}"{% endif %}>{% block page_header_text %}{% endblock %}</h1>
		</section>
{% if container %}
	</div>
{% endif %}
