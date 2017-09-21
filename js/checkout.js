simpleCart.ready(function() {
  simpleCart.each(function(item, x) {
    $('form').append('<input type="hidden" name="' + item.get('id') + ' Название" value="' + item.get('name') + '">');
    $('form').append('<input type="hidden" name="' + item.get('id') + ' Цвет" value="' + item.get('color') + '">');
    $('form').append('<input type="hidden" name="' + item.get('id') + ' Размер" value="' + item.get('size') + '">');
    $('form').append('<input type="hidden" name="' + item.get('id') + ' Количество" value="' + item.get('quantity') + '">');
    $('form').append('<input type="hidden" name="' + item.get('id') + ' Цена" value="' + item.get('price') + '">');
    $('form').append('<input type="hidden" name="' + item.get('id') + ' Итого" value="' + item.get('total') + '">');
  });
});
