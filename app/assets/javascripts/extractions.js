var currentData = [];

function fetchProducts() {
  $.ajax({
    url: "/storage_units/" + $("#extraction_storage_unit_id")[0].value + "/inventory",
    type: 'get',
  }).done(function (data) {
    currentData = data;
    changeProductSelect(currentData);
    $('.extraction-product-select').val("");
  });
};

function addProductSelect() {
  if (currentData.length === 0) {
    fetchProducts();
  } else {
    setTimeout(function(){
      changeProductSelect(currentData);
    }, 50);
  }
};

function changeProductSelect(data) {
  var options = [];
  data.forEach(function (product) {
    options.push(product);
  });
  $(".extraction-product-select").each(function(_index, productSelect) {
    $(productSelect).empty();
    options.forEach(function(option) {
      $(productSelect).append(
        $('<option>', 
          { value: option.id, 'data-unit': option.measurement_unit, 'data-quantity': option.quantity }
        ).text(option.label + '(' + option.name + ')')
      );
    })
    $(productSelect).change(function(event) {
      var warning = $(this).parent().find('.extraction-maximum-amount-warning');
      var selectedOption = $(this).find(':selected');
      var maxQuantity = selectedOption.data('quantity');
      var unit = selectedOption.data('unit');
      warning.text('La cantidad máxima disponible es ' + maxQuantity + ' ' + unit);
    });
  });
};

$(document).ready(function() {
  $('#extraction_storage_unit_id').change(fetchProducts);
});
