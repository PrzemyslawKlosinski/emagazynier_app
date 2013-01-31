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

//= require jquery.ui.all

// This will allow all of Cocoon’s jQuery magic to do its thing.
//= require cocoon

// for DataPicker
//= require bootstrap-datepicker

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

//wyliczenie brutto na formularzu - brutto wyliczane jest z netto po dodaniu marzy
function onDiscountChange(discount){
	if(isNaN(discount.value)){
		discount.value = 0;
	}
	// if(discount != 0){
			discount_value = discount.value;
			id_discount = discount.id;
			id_netto = id_discount.replace(/(discount)/ig, 'netto_price');
			var netto_value=document.getElementById(id_netto);
			var netto_discount = (((discount_value/100.00)+1.00)*netto_value.value).toFixed(2)

			var brutto=(netto_discount * 1.23);
				if(isNaN(brutto)){
				brutto = 0.00;
			}
			id_brutto = id_netto.replace(/(netto)/ig, 'brutto');
			var brutto_value=document.getElementById(id_brutto);
			brutto_value.value=(brutto).toFixed(2); //zaokraglenie w gore
	// }
}

//wyliczenie brutto na formularzu
function onNettoChange(netto_value){
	if(isNaN(netto_value.value)){
		netto_value.value = 0.00;
	}

	var brutto=(netto_value.value * 1.23);

	id_netto = netto_value.id;
	id_brutto = id_netto.replace(/(netto)/ig, 'brutto');
	var brutto_value=document.getElementById(id_brutto);
	brutto_value.value=(brutto).toFixed(2); //zaokraglenie w gore

	id_discount = id_netto.replace(/(netto_price)/ig, 'discount');
	var discount_value=document.getElementById(id_discount);
	discount_value.value = 0;


}

//wyliczenie brutto na formularzu
function onBruttoChange(brutto_value){
	if(isNaN(brutto_value.value)){
		brutto_value.value = 0.00;
	}

	var netto=(brutto_value.value / 1.23);

	id_brutto = brutto_value.id;
	id_netto = id_brutto.replace(/(brutto)/ig, 'netto');
	var netto_value=document.getElementById(id_netto);
	netto_value.value=netto.toFixed(2); //zaokraglenie w gore

	id_discount = id_brutto.replace(/(brutto_price)/ig, 'discount');
	var discount_value=document.getElementById(id_discount);
	discount_value.value = 0;
}

// function myFunction() {
// 	$('#spinner').spinner({ min: -100, max: 100 });
// 	alert($('#spinner').spinner('value'));
// }

