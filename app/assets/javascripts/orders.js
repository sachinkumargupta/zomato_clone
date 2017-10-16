function add_food(){
  var item_array = "";
  var quantity_array = "";

  $(".item").map(function(){
    item_id = $(this).val();
    item_array += item_id + " ";
  });
  item_array = item_array.trim();
  $(".item_array").val(item_array);
  //alert(item_array);

  $(".quantity").map(function(){
    value = $(this).val();
    value = parseInt(value);
    quantity_array += value + " ";
  });
  quantity_array = quantity_array.trim();
  $(".quantity_array").val(quantity_array);
  //alert(quantity_array);
}