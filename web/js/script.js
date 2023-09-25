const app = new Vue({
    el: '#app',

    data: {

        nomeRisorsa : GetParentResourceName(),

        searchProduct : "",

        colorSettings : [
            {
                type : "legendary",
                text : "#ECC745",
            },
            {
                type : "rare",
                text : "#00FFC2"
            },
            {
                type : "comune",
                text : "#B7B7B7"
            },
            {
                type : "epic",
                text : "#8D57FF"
            },
            {
                type : "superlegendary",
                text : "#FF6BE7"
            },
        ],

        products : [],


        basket : [],

        locales : {},

        totalPrice : 0,

        playerMoney : 0,
    },

    methods: {

        postNUI(type, data) {
            $.post(`https://${this.nomeRisorsa}/${type}`, JSON.stringify(data));
        },

        filterProduct() {
            if(this.searchProduct.length > 0) {
                return this.products.filter(item => item.label.toLowerCase().includes(this.searchProduct.toLowerCase()));
            } else {
                return this.products;
            }
        },

        getColorSettings(type) {
            if(!type) {
                type = 'comune'
            }

            return this.colorSettings.find(item => item.type === type);
        },

        addToBasket(v) {
            if(this.basket.find(item => item.label === v.label)) {
                this.addOneProduct(this.basket.find(item => item.label === v.label));
            } else {
                this.basket.push({
                    label : v.label,
                    price : v.price,
                    quantity : 1,
                    name : v.name,
                    type : v.type,
                });
            }
            this.updatePrice();
        },

        addOneProduct(v) {
            v.quantity++;
            this.updatePrice();
        },

        removeOneProduct(v) {
            if(v.quantity > 1) {
                v.quantity--;
            } else {
                this.basket.splice(this.basket.indexOf(v), 1);
            }
            this.updatePrice();
        },

        updatePrice() {
            this.totalPrice = 0;
            this.basket.forEach(item => {
                this.totalPrice += item.price * item.quantity;
            });
        },

        removeAllProducts() {
            this.basket = [];
            this.updatePrice();
        },

        getPriceItemInBasket(label) {
            return this.basket.find(item => item.label === label).price * this.basket.find(item => item.label === label).quantity;
        },

        buy() {
            if(this.basket.length === 0) {
                return;
            }
            this.postNUI('buy', {
                totalPrice : this.totalPrice,
                basket : this.basket
            });
            $("#app").fadeOut(500)
            this.postNUI('close');
            this.removeAllProducts();
        }
    }

});


window.addEventListener('message', function(event) {
    var data = event.data;
    if (data.type === "OPEN") {
        app.basket = []
        app.updatePrice()
        $("#app").fadeIn(500)
    } else if(data.type === "SET_LOCALES") {
        app.locales = data.locales
    } else if(data.type === "SET_ITEMS") {
        app.products = data.items
    } else if(data.type === "SET_PLAYER_MONEY") {
        app.playerMoney = data.money
    }
})


document.onkeyup = function (data) {
    if (data.key == 'Escape') {
        $("#app").fadeOut(500)
        app.postNUI('close')
    }
};