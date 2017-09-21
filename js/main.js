simpleCart({

  checkout: {
    // type: "PayPal",
    // email: "you@yours.com",
  },

  // tax: 1.5,
  cartStyle: "table"
  ,
  cartColumns: [
    { view:'image', label: false},
    { attr: "name" , label: "Название" } ,
    { attr: "price" , label: "Цена", view: 'currency' } ,
    // { attr: "size" , label: "Размер" } ,
    // { attr: "color" , label: "Цвет" } ,
    // { view: "decrement" , label: false , text: "-" } ,
    { view: "input", attr: "quantity" , label: "Количество" } ,
    // { view: "increment" , label: false , text: "+" } ,
    { attr: "total" , label: "Итого", view: 'currency' } ,
    { view: "remove" , text: "Удалить" , label: false }
  ]

});

simpleCart.currency({
  code: "RUB",
  name: "Рубль",
  symbol: " руб",
  delimiter: " ",
  after: true,
  accuracy: 2
});


//* Refresh cart once simpleCart is ready to listen.
simpleCart.ready(function() {
  simpleCart.update();
});

$('.pgwSlideshow').pgwSlideshow();
