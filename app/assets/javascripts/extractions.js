var currentData = [];



function fetchProducts() {
  console.log($("#extraction_storage_unit_id")[0].value)
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
        ).text(option.name + ' con etiqueta: ' + option.label )
      );
    })
    $(productSelect).trigger("liszt:updated");
    $(productSelect).trigger("chosen:updated");
    $(productSelect).change(function(event) {
      setWarning(this);
    });
    setWarning(productSelect);
  });
};

function setWarning(productSelect) {
  var warning = $(productSelect).parent().parent().find('.extraction-maximum-amount-warning');
  var selectedOption = $(productSelect).find(':selected');
  var maxQuantity = selectedOption.data('quantity');
  var unit = selectedOption.data('unit');
  warning.text('La cantidad máxima disponible es ' + maxQuantity + ' ' + unit);
}

function getProductFromBarCode() {
  var button = $(event.target)
  var code = button.closest(".barcode-section").find('.barcode')[0].value
  var url = "/bar_code/get_product?code=" + code
  $.ajax({url: url, success: function(result){
    var amount = result[0]["amount"];
    var product = result[0]["product_type_id"];
    button.closest(".fields").find('#amount').val(amount);
    button.closest(".fields").find('select').val(product);
  }});
};

$(document).ready(function() {
  $('#extraction_storage_unit_id').change(fetchProducts);
});
