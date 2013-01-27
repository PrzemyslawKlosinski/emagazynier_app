// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs

//= require bootstrap

// This will allow all of Cocoon’s jQuery magic to do its thing.
//= require cocoon

//= require_tree .



$('.submit_me').click(function() {
  $('form').submit();
  return false;
});

function update(){
	var product_summaryQuantityPurchase=document.getElementById("product_summaryQuantityPurchase").value;
	var product_summaryQuantitySales=document.getElementById("product_summaryQuantitySales").value;
	var product_reservedQuantity=document.getElementById("product_reservedQuantity").value;
	var quantity=document.getElementById("product_quantity");
	quantity.value=product_summaryQuantityPurchase - product_summaryQuantitySales - product_reservedQuantity;
}