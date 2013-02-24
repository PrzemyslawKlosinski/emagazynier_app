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
function onOutcomeDiscountChange(discount){
	if(isNaN(discount.value)){
		discount.value = 0;
	}
	// if(discount != 0){
			discount_value = discount.value;
			id_discount = discount.id;


			//policz netto z hidden
			var id_netto_sales = id_discount.replace(/(discount)/ig, 'netto_sales_price');
			var netto_sales = document.getElementById(id_netto_sales);
			var netto_sales_discount = (((discount_value/100.00)+1.00)*netto_sales.value).toFixed(2);

			//zapisz netto z marza
			id_netto = id_discount.replace(/(discount)/ig, 'netto_price');
			var netto = document.getElementById(id_netto);
			netto.value = netto_sales_discount;


			//dorobic pobieranie vatu (przeniesc z product -> product_price)
			// var vat = document.getElementById('defaultVat');
			// var vat_value = (vat.value/100)+1;
			var brutto=(netto_sales_discount * 1.23);
				if(isNaN(brutto)){
				brutto = 0.00;
			}
			id_brutto = id_netto.replace(/(netto)/ig, 'brutto');
			var brutto_value=document.getElementById(id_brutto);
			brutto_value.value=(brutto).toFixed(2); //zaokraglenie w gore
	// }
}

function onIncomeDiscountChange(discount){
	if(isNaN(discount.value)){
		discount.value = 0;
	}

	discount_value = discount.value;
	id_discount = discount.id;

		//pobierz pole hidden i wstaw wartosc z pola cena zakupu
		// var id_netto_sales = id_discount.replace(/(discount)/ig, 'netto_sales_price');
		// var netto_sales = document.getElementById(id_netto_sales);

		//tymczasowo zachowaj orginalna netto
		id_netto = id_discount.replace(/(discount)/ig, 'netto_price');
		var netto = document.getElementById(id_netto);
		netto.value = (((discount_value/100.00)+1.00)*netto.value).toFixed(2);		
		// netto_sales.value = netto.value;


		// wylicz cene z marza marze i wstaw do pola netto_price
		// var netto_sales_discount = (((discount_value/100.00)+1.00)*netto_sales.value).toFixed(2);		
		// alert(netto_sales_discount);
		// netto_sales.value = netto_sales_discount;	

		//policz od tego brutto
			var brutto=(netto.value * 1.23);
				if(isNaN(brutto)){
				brutto = 0.00;
			}
			id_brutto = id_netto.replace(/(netto)/ig, 'brutto');
			var brutto_value=document.getElementById(id_brutto);
			brutto_value.value=(brutto).toFixed(2); //zaokraglenie w gore


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

function onSalesNettoChange(netto_value){
	if(isNaN(netto_value.value)){
		netto_value.value = 0.00;
	}

	var brutto=(netto_value.value * 1.23);

	id_netto = netto_value.id;
	id_brutto = id_netto.replace(/(netto)/ig, 'brutto');
	var brutto_value=document.getElementById(id_brutto);
	brutto_value.value=(brutto).toFixed(2); //zaokraglenie w gore

	//pod netto_sales_price - zapisujemy nettp_purchase_price
	var id_netto_purchase = id_brutto.replace(/(brutto_price)/ig, 'netto_sales_price');
	var nettoPurchase = document.getElementById(id_netto_purchase);
	var marza = (((netto_value.value - nettoPurchase.value) / nettoPurchase.value)*100).toFixed(2);

	id_discount = id_brutto.replace(/(brutto_price)/ig, 'discount');
	var discount_value=document.getElementById(id_discount);
	discount_value.value = marza;


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


//wyliczenie brutto na formularzu
function onSalesBruttoChange(brutto_value){
	if(isNaN(brutto_value.value)){
		brutto_value.value = 0.00;
	}

	var netto=(brutto_value.value / 1.23);

	id_brutto = brutto_value.id;
	id_netto = id_brutto.replace(/(brutto)/ig, 'netto');
	var netto_value=document.getElementById(id_netto);
	netto_value.value=netto.toFixed(2); //zaokraglenie w gore


	//pod netto_sales_price - zapisujemy nettp_purchase_price
	var id_netto_purchase = id_brutto.replace(/(brutto_price)/ig, 'netto_sales_price');
	var nettoPurchase = document.getElementById(id_netto_purchase);
	var marza = (((netto_value.value - nettoPurchase.value) / nettoPurchase.value)*100).toFixed(2);

	// alert(marza);

	id_discount = id_brutto.replace(/(brutto_price)/ig, 'discount');
	var discount_value=document.getElementById(id_discount);
	discount_value.value = marza;
}

// function myFunction() {
// 	$('#spinner').spinner({ min: -100, max: 100 });
// 	alert($('#spinner').spinner('value'));
// }


///////////////////////////////// action for product_prices
// product_price_nettoPurchasePrice
// product_price_nettoSalesPrice
// product_price_bruttoPurchasePrice
// product_price_bruttoSalesPrice
// defaultVat
// discount


//wyliczenie brutto na formularzu
function change_bruttoPurchasePrice(){

	var netto = document.getElementById('product_price_nettoPurchasePrice');
	if(isNaN(netto.value)) {
		netto.value = 0.00;
	}

	var vat = document.getElementById('defaultVat');
	var vat_value = (vat.value/100)+1;

	var brutto = document.getElementById('product_price_bruttoPurchasePrice');
	brutto.value = (netto.value * vat_value).toFixed(2); //zaokraglenie w gore
	

	//zamienic discount
	// id_discount = id_netto.replace(/(netto_price)/ig, 'discount');
	// var discount_value=document.getElementById(id_discount);
	// discount_value.value = 0;

}

function change_bruttoSalesPrice() {

	var netto = document.getElementById('product_price_nettoSalesPrice');
	if(isNaN(netto.value)) {
		netto.value = 0.00;
	}

	var vat = document.getElementById('defaultVat');
	var vat_value = (vat.value/100)+1;

	var brutto = document.getElementById('product_price_bruttoSalesPrice');
	brutto.value = (netto.value * vat_value).toFixed(2); //zaokraglenie w gore

}


function change_nettoPurchasePrice(){

	var brutto = document.getElementById('product_price_bruttoPurchasePrice');
	if(isNaN(brutto.value)) {
		brutto.value = 0.00;
	}

	var vat = document.getElementById('defaultVat');
	var vat_value = (vat.value/100)+1;

	var netto = document.getElementById('product_price_nettoPurchasePrice');
	netto.value = (brutto.value / vat_value).toFixed(2); //zaokraglenie w gore
	
}

function change_nettoSalesPrice() {

	var brutto = document.getElementById('product_price_bruttoSalesPrice');
	if(isNaN(brutto.value)) {
		brutto.value = 0.00;
	}

	var vat = document.getElementById('defaultVat');
	var vat_value = (vat.value/100)+1;

	var netto = document.getElementById('product_price_nettoSalesPrice');
	netto.value = (brutto.value / vat_value).toFixed(2); //zaokraglenie w gore
}

function change_discount(){

	var nettoPurchase = document.getElementById('product_price_nettoPurchasePrice');
	var nettoSales = document.getElementById('product_price_nettoSalesPrice');

	var marza = (((nettoSales.value - nettoPurchase.value) / nettoPurchase.value)*100).toFixed(2);
	var discount = document.getElementById('discount');
	discount.value = marza;

}

// na podstawie znizki wylicz cene sprzedazy
function count_discount() {

	var nettoPurchase = document.getElementById('product_price_nettoPurchasePrice');
	if(isNaN(nettoPurchase.value)) {
		nettoPurchase.value = 0.00;
	}

	var discount = document.getElementById('discount');
	var netto_with_discount = (((discount.value/100.00)+1.00)*nettoPurchase.value).toFixed(2)

	var nettoSales = document.getElementById('product_price_nettoSalesPrice');
	nettoSales.value = netto_with_discount;
}

function checkAutoUpdate(checkbox) {

	    if (checkbox.id == 'actualPriceOnPurchase') {
	    	if(checkbox.checked) {
	    		var netto = document.getElementById('product_price_nettoPurchasePrice');
	    		netto.readOnly = true;
	    		var brutto = document.getElementById('product_price_bruttoPurchasePrice');
	    		brutto.readOnly = true;
	    	} else {
	    		var netto =	document.getElementById('product_price_nettoPurchasePrice');
	    		netto.readOnly = false;
	    		var brutto = document.getElementById('product_price_bruttoPurchasePrice');
	    		brutto.readOnly = false;
	    	}
		}

	    if (checkbox.id == 'product_price_calculateByPurchase') {
	    	if(checkbox.checked) {
	    		var netto = document.getElementById('product_price_nettoSalesPrice');
	    		netto.readOnly = true;
	    		var brutto = document.getElementById('product_price_bruttoSalesPrice');
	    		brutto.readOnly = true;
	    	} else {
	    		var netto =	document.getElementById('product_price_nettoSalesPrice');
	    		netto.readOnly = false;
	    		var brutto = document.getElementById('product_price_bruttoSalesPrice');
	    		brutto.readOnly = false;
	    	}
		}

}

//ustawia unsold w quantity
function setUnsold(amount) {

	if(isNaN(amount.value)){
		amount.value = 0.00;
	}

			id_amount = amount.id;
			id_unsold = id_amount.replace(/(amount)/ig, 'unsold');
			var unsold = document.getElementById(id_unsold);
			unsold.value = amount.value;
}

//ustawia dane sprzedazy

// $(document).ready(function(){
//     $("#showHideDescription").click(function(){

// $("#combo_box").live('change',
function setPurchase(select) {

	var product_id = select.options[select.selectedIndex].value;
    var id_product = select.id;
	id_netto = id_product.replace(/(product_id)/ig, 'netto_price');
	var netto = document.getElementById(id_netto);
	id_brutto = id_netto.replace(/(netto_price)/ig, 'brutto_price');
	var brutto = document.getElementById(id_brutto);	
	id_discount = id_netto.replace(/(netto_price)/ig, 'discount');
	var discount_value=document.getElementById(id_discount);

	id_amount = id_netto.replace(/(netto_price)/ig, 'amount');
	var amount = document.getElementById(id_amount);


	if (product_id != "") {
		// alert(strUser);

					netto.readOnly=false;
					brutto.readOnly=false;
					discount_value.readOnly=false;
					amount.readOnly=false;

	$.ajax({
           type: "post",
           cache: false,
           url: "/products/price", //+ strUser,
           dataType: "json",

           // data: "matched_time="+matched_time,
           // data: {product : "1"}, // params[:latitude] and params[:longitude] in your controller.
           // data: {pubyear: pubyear, codetype: codetype},
           data: {id: product_id},
           // data: null, // optional data

             beforeSend: function(){
                  // alert("Before send");
             },

            complete:    function() {
                 // alert("Ajax Complete!");
             },
             
             error: function(xhr, status, error){
                  alert("Błąd " + xhr.responseText);
             },

             success: function(result){
             	  //$("#descriptionDiv").html

				  // alert(result.response);
                  // alert("in the success..." + result.nettoSalesPrice + result.bruttoSalesPrice);

					netto.value = result.nettoPurchasePrice;
					brutto.value = result.bruttoPurchasePrice;

					// var json1 = eval(data);
     //                $(divId).html( json1.role_type.description )
     //                $(divId).show('slow');
             }

           // success: function(result) {
           //      alert(strUser + ' ok ' + result);
           // },                

           // error : function(req, status, error) {
           //      alert(strUser + ' not ok ' + req + " " + status + " " + error);
           // }

       });
	

	} else {
					
					netto.readOnly=true;
					brutto.readOnly=true;
					discount_value.readOnly=true;
					amount.readOnly=true;

					netto.value = 0;
					brutto.value = 0;	
					discount_value.value = 0;
					amount.value = 0.00;
	}

}

function setSales(select) {

	var product_id = select.options[select.selectedIndex].value;
	var id_product = select.id;

	id_netto_sales = id_product.replace(/(product_id)/ig, 'netto_sales_price');
	var netto_sales = document.getElementById(id_netto_sales);

					id_netto = id_product.replace(/(product_id)/ig, 'netto_price');
					var netto = document.getElementById(id_netto);

					id_brutto_sales = id_netto.replace(/(netto_price)/ig, 'brutto_sales_price');
					var brutto_sales = document.getElementById(id_brutto_sales);

					id_brutto = id_netto.replace(/(netto_price)/ig, 'brutto_price');
					var brutto = document.getElementById(id_brutto);

					id_discount = id_brutto.replace(/(brutto_price)/ig, 'discount');
					var discount = document.getElementById(id_discount);

					id_amount = id_brutto.replace(/(brutto_price)/ig, 'amount');
					var amount = document.getElementById(id_amount);



	if (product_id != "") {

					netto.readOnly=false;
					brutto.readOnly=false;
					discount.readOnly=false;
					amount.readOnly=false;

	$.ajax({
           type: "post",
           cache: false,
           url: "/products/price",
           dataType: "json",
           data: {id: product_id},

             error: function(xhr, status, error){
                  alert("Błąd " + xhr.responseText);
             },

             success: function(result){
                  	
                  	// ustaw hidden netto
					netto_sales.value = result.nettoPurchasePrice;

                  	// ustaw netto
					netto.value = result.nettoSalesPrice;

					// ustaw hidden brutto
					brutto_sales.value = result.bruttoPurchasePrice;

					// ustaw brutto
					brutto.value = result.bruttoSalesPrice;

					// ustaw narzut - wylicz z  (sprzedaz-zakup/zakup)*100
					var marza = (((result.nettoSalesPrice - result.nettoPurchasePrice) / result.nettoPurchasePrice)*100).toFixed(2);
					discount.value = marza;

					// jesli marz -100, czyli cena 0 to ustaw marze na 0
					// if (discount.value = -100) {
					// 	discount.value = 0;
					// 	netto.value = result.nettoPurchasePrice;
					// 	brutto.value = result.bruttoPurchasePrice;
					// }


             }

       });
	

	} else {
					netto.readOnly=true;
					brutto.readOnly=true;
					discount.readOnly=true;
					amount.readOnly=true;

					netto.value = 0;
					brutto.value = 0;	
					discount.value = 0;
					amount.value = 0.00;
	}


}