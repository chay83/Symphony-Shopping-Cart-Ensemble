$(document).ready(function() { 
	$('.btn-cart').live('click',function(){
		url = $(this).data('url');
		productid = $(this).data('product-id')
		$.post(url, { rand: Math.floor(Math.random()*11000), id:productid, 'cart-action[add]':'Add item'},
		   function(data){
		   	jsonobj = xmlToJson(data);
		    console.log(jsonobj);
		   });
		
	});
});