<div class="pt-md-3{% if not home_main_product %} px-md-3{% endif %}">

    {# Product name and breadcrumbs for product page #}

    {% if home_main_product %}
        {# Product name #}
        <h2 class="mb-3">{{ product.name }}</h2>
    {% else %}
        {% embed "snipplets/page-header.tpl" with {container: false, padding: false, page_header_title_class: 'js-product-name mb-3'} %}
            {% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
        {% endembed %}
    {% endif %}

    {# Product SKU #}

    {% if settings.product_sku and product.sku %}
        <div class="font-small opacity-60 mb-3">
            {{ "SKU" | translate }}: <span class="js-product-sku">{{ product.sku }}</span>
        </div>
    {% endif %}

    {# Product price #}

    <div class="price-container" data-store="product-price-{{ product.id }}">
        <div class="mb-3">
            
            
            <span class="d-inline-block mr-1">
            	<div class="js-price-display h3" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">{% if product.display_price %}{{ product.price | money }}{% endif %}</div>
            </span>
            
            <div class="pix-icon" style="display: inline-block; vertical-align: middle;">
                <!-- Insira o código SVG aqui -->
                <img src="{{ 'images/pix.svg' | static_url }}" class="pix" alt="Pix">
            </div>
            {{ component('payment-discount-price', {
                    visibility_condition: settings.payment_discount_price,
                    location: 'product',
                    container_classes: "h6 font-weight-normal mt-2 dna-texto1",
                    text_classes: {
                        price: 'h5 text-accent font-weight-bold',
                    },
                }) 
            }}
            
            {% include 'snipplets/labels.tpl' with {product_detail: true} %}
            <span class="d-block font-big title-font-family mt-1">
               <div id="compare_price_display" class="js-compare-price-display price-compare {% if settings.payment_discount_price %}font-body{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</div>
            </span>

            
        </div>

        {% set installments_info = product.installments_info_from_any_variant %}
        {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
        {% set show_payments_info = settings.product_detail_installments and product.show_installments and product.display_price and installments_info %}
        {% set showDiscount = hasDiscount and product.showMaxPaymentDiscount %}
        {% set discountContainerStyle = not (showDiscount) ? "display: none" %}

        {% if not home_main_product and (show_payments_info or showDiscount) %}
            <div {% if installments_info %}data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments"{% endif %} class="{% if installments_info %}js-modal-open js-fullscreen-modal-open{% endif %} js-product-payments-container mb-3 {% if not home_main_product %}col-md-8{% endif %} px-0" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
        {% endif %}
        {% if show_payments_info %}
            {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "mb-2 font-small"}}) }}
        {% endif %}
            <div class="js-product-discount-container mb-2 font-small" style="{{ discountContainerStyle }}">
                <span class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</span> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}
                {% set discountDisclaimerStyle = not product.showMaxPaymentDiscountNotCombinableDisclaimer ? "display: none" %}
                    <div class="js-product-discount-disclaimer font-small opacity-60" style="{{ discountDisclaimerStyle }}">
                        {{ "No acumulable con otras promociones" | translate }}
                    </div>
            </div>
        {% if not home_main_product and (show_payments_info or hasDiscount) %}
                <a id="btn-installments" class="font-small" href="#" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                    <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#credit-card"/></svg>
                    {% if not hasDiscount and not settings.product_detail_installments %}
                        {{ "Ver medios de pago" | translate }}
                    {% else %}
                        {{ "Ver más detalles" | translate }}
                    {% endif %}
                </a>
            </div>
        {% endif %}

    </div>

    {# Promotional text #}

    {% if product.promotional_offer and not product.promotional_offer.script.is_percentage_off and product.display_price %}
        <div class="js-product-promo-container {% if not home_main_product %}col-md-8{% endif %} px-0" data-store="product-promotion-info">
            {% if product.promotional_offer.script.is_discount_for_quantity %}
                {% for threshold in product.promotional_offer.parameters %}
                    <div class="mb-1 mt-4 text-accent">{{ "¡{1}% OFF comprando {2} o más!" | translate(threshold.discount_decimal_percentage * 100, threshold.quantity) }}</div>
                {% endfor %}
            {% else %}
                <div class="mb-1 mt-4 text-accent">{{ "¡Llevá {1} y pagá {2}!" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}</div>
            {% endif %}
            {% if product.promotional_offer.scope_type == 'categories' %}
                <p class="font-small">{{ "Válido para" | translate }} {{ "este producto y todos los de la categoría" | translate }}:
                {% for scope_value in product.promotional_offer.scope_value_info %}
                   {{ scope_value.name }}{% if not loop.last %}, {% else %}.{% endif %}
                {% endfor %}</br>{{ "Podés combinar esta promoción con otros productos de la misma categoría." | translate }}</p>
            {% elseif product.promotional_offer.scope_type == 'all'  %}
                <p class="font-small">{{ "Vas a poder aprovechar esta promoción en cualquier producto de la tienda." | translate }}</p>
            {% endif %}
        </div>
    {% endif %}

    {# Product form, includes: Variants, CTA and Shipping calculator #}

     <form id="product_form" class="js-product-form mt-4" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
        {% if template == "product" %}
            {% set show_size_guide = true %}
        {% endif %}
        {% if product.variations %}
            {% include "snipplets/product/product-variants.tpl" with {show_size_guide: show_size_guide} %}
        {% endif %}

        {% set show_product_quantity = product.available and product.display_price %}

        {% if settings.last_product and show_product_quantity %}
            <div class="{% if product.variations %}js-last-product{% endif %} text-accent mb-3"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
                {{ settings.last_product_text }}
            </div>
        {% endif %}
        
        <div class="row col-11" style="margin-bottom: 20px;">
        <input class="btn btn-primary btn-big btn-block bt-comprar-dna1" type="submit" name="go_to_checkout" value="Comprar agora" data-component="cart.checkout-button"/>
        </div>
        
        <div class="row col-11 no-gutters mb-4 {% if settings.product_stock %}mb-md-3{% endif %}" style="padding: 0;">
            
            {% set product_quantity_home_product_value = home_main_product ? true : false %}
            {% if show_product_quantity %}
                <!--{% include "snipplets/product/product-quantity.tpl" with {home_main_product: product_quantity_home_product_value} %}-->
            {% endif %}
            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
            <div class="{% if show_product_quantity %}col-8 {% if not home_main_product %}col-md-11{% endif %}{% else %}col-12{% endif %}">

                {# Add to cart CTA #}

                <button type="submit" class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big btn-block {{ state }} bt-comprar-dna" {% if state == 'nostock' %}disabled {% endif %} data-store="product-buy-button" data-component="product.add-to-cart">
                {{ "images/carrinho.svg" | static_url | img_tag("Cart") }}
                Adicionar ao carrinho
                </button>

                {# Fake add to cart CTA visible during add to cart event #}

                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}

            </div>

            {% if settings.ajax_cart %}
                <div class="col-11">
                    <div class="js-added-to-cart-product-message font-small my-3" style="display: none;">
                        <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#check"/></svg>
                        <span>
                            {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-open-cart js-fullscreen-modal-open btn-link font-small ml-1" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                        </span>
                    </div>
                </div>
            {% endif %}
        </div>

        {% if template == 'product' %}

            {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

            {% if show_product_fulfillment %}
                <div class="mb-4 pb-2 background-dna">
                    {# Shipping calculator and branch link #}

                    <div id="product-shipping-container" class="product-shipping-calculator list" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
                        {% if store.has_shipping %}
                            {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                        {% endif %}
                    </div>

                    {% if store.branches %} 
                        {# Link for branches #}
                        {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
                    {% endif %}
                </div>

            {% endif %}
        {% endif %}
     </form>
</div>

{% if not home_main_product %}
   {# Product payments details #}
    {% include 'snipplets/product/product-payment-details.tpl' %}
{% endif %}
