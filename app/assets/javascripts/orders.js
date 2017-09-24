function addfood() {
  var item_list = "";
  var item_name = "";
  var quantity_list = "";
  var item_counter = 0;
  $(".add-food-button").click(function(){
    quantity = $("#quantity").val();
    quantity = Math.trunc(quantity);
    if(quantity>0) {
      item_counter++;
      item = $("#item").val();
      if(item){
        item_name = $("#item option:selected").attr("data-name");
        if(item_counter!=1){
          item_list += ", ";
          quantity_list += ", ";}
        else{
          $(".submit-food-order").after('<table class="table table-responsive table-striped food-item-list"></table>');
          append_item = "<tr><th>Food Item</th><th>Quantity</th></tr>";
          $(".food-item-list").append(append_item);
        }
        item_list += item;
        quantity_list +=quantity;
        $("#order_item_array").val(item_list);
        $("#order_quantity_array").val(quantity_list);
        $("#quantity").val(1);
        append_item = "<tr><td>" + item_name + "</td><td>" + quantity + "</td></tr>";
        $(".food-item-list").append(append_item);
        $("#item option:selected").remove();
      }
      else{
        alert("Sorry!! No more Item to select");
      }
    }
    else {
      alert("Quantity must be greater then 0");
      $("#quantity").val(1);
    }
  });
}