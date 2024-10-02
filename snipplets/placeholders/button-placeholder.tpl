<div class="js-addtocart js-addtocart-placeholder btn {% if direct_add %}btn-small btn-smallest-md px-4 {% endif %} dna-bt-negative btn-primary btn-block btn-transition {{ custom_class }} disabled" style="display: none;">
    <div class="d-inline-block">
        <span class="js-addtocart-text">
            {% if direct_add %}
                <div class="d-flex justify-content-center align-items-center">
                    {{ 'Comprar' | translate }}
                </div>
            {% else %}
                {{ 'Agregar al carrito' | translate }}
            {% endif %}
        </span>
        <span class="js-addtocart-success transition-container">
            {{ '¡Listo!' | translate }}
        </span>
        <div class="js-addtocart-adding transition-container">
            {{ 'Agregando...' | translate }}
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // Verifica se estamos na página de produto
    if (document.querySelector('.js-product-form')) {
        // Encontra a div abaixo do botão de adicionar ao carrinho
        let addToCartDiv = document.querySelector('.js-addtocart-placeholder');
        if (addToCartDiv) {
            // Adiciona a classe dna-bt-ok à div
            addToCartDiv.classList.add('dna-bt-ok');
        }
    } else {
        // Não faz nada se não for a página de produto
        console.log("Não é uma página de produto.");
    }
});
</script>