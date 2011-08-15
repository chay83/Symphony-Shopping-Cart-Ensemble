$(document).ready(function() { 
	$.fn.addToCart = function(options) {
		return this.each(function() {
			$this = $(this);
			//$this.attr('action',ROOT + '/ajax/add-to-cart');
			$this.submit(function(e){
				e.preventDefault();
				$.post(ROOT + '/ajax/add-to-cart/', $this.serialize(), function(data){
					console.log(data);
				});
				
				return false;
			});
		});
	}
	
	$.fn.onePageCheckout = function(options) {
		return this.each(function() {
			$this = $(this);
			$orderform = $this.find("#co-billing-form");
			$inputs = $orderform.validator({position:"top left"});

			var changeStage = function(stage) {
				var $list = $this.find("ol#checkoutSteps");
				
				$list.find("li div.step").hide();
				$list.find("li div.step input").attr("disabled",true);
				$list.find("li div.step textarea").attr("disabled",true);
				$list.find("li div.step select").attr("disabled",true);
				$list.find("li").removeClass("active");
				$list.find("li#opc-" + stage + " div.step").show();
				$list.find("li#opc-" + stage + " div.step input").attr("disabled",false);
				$list.find("li#opc-" + stage + " div.step textarea").attr("disabled",false);
				$list.find("li#opc-" + stage + " div.step select").attr("disabled",false);
				$list.find("li#opc-" + stage).addClass("active");
			};
			
			$this.find("li#opc-login div.col-1 button").click(function(){
				var selected = $this.find("li#opc-login div.col-1 input[name=checkout_method]:checked").val();				
				
				if(selected == 'register' || selected == 'guest'){
					var $input = $('<input type="hidden" name="checkout_method" />').val(selected);	
					
					$orderform.append($input);	
					
					changeStage("billing");
					
					if(selected == 'guest'){
						$("#billing-customer_password").attr("disabled",true);
						$("#billing-confirm_password").attr("disabled",true);
						$("#register-customer-password").hide();
					}																	
				}					
				
				return false;			
			});
			
			$this.find("li#opc-billing button").click(function(){
				if($inputs.data("validator").checkValidity()){
					
					if($("input[name='billing[use_for_shipping]']:checked").val() == '1'){
						
						$("#shipping-firstname").val($("#billing-firstname").val());
						$("#shipping-lastname").val($("#billing-lastname").val());
						$("#shipping-company").val($("#billing-company").val());
						$("#shipping-email").val($("#billing-email").val());
						$("#shipping-street1").val($("#billing-street1").val());
						$("#shipping-street2").val($("#billing-street2").val());
						$("#shipping-city").val($("#billing-city").val());
						$("#shipping-region").val($("#billing-region").val());
						$("#shipping-postcode").val($("#billing-postcode").val());
						$("#shipping-country_id").val($("#billing-country_id").val());
						$("#shipping-telephone").val($("#billing-telephone").val());
						$("#shipping-fax").val($("#billing-fax").val());
						
						changeStage("shipping_method");
						
					}else{
					
						changeStage("shipping");	
										
					}
				}
			});
			
			$this.find("li#opc-shipping button").click(function(){
				if($inputs.data("validator").checkValidity()){
					changeStage("shipping_method");
					
					
				}
			});
			
			$this.find("li#opc-shipping_method button").click(function(){
				if($inputs.data("validator").checkValidity()){
					changeStage("payment");
					$this.find("ol#checkoutSteps li div.step input").attr("disabled",false);
					$this.find("ol#checkoutSteps li div.step textarea").attr("disabled",false);
					$this.find("ol#checkoutSteps li div.step select").attr("disabled",false);
					
					if(selected == 'guest'){
						$("#billing-customer_password").attr("disabled",true);
						$("#billing-confirm_password").attr("disabled",true);
						$("#register-customer-password").hide();
					}
					
				}
			});
			
			
			
			$this.find("li#opc-review button").click(function(){
					changeStage("billing");
			});
			
			
			
				
			
		});
	}
	
	$("body#checkout").onePageCheckout();
	
	
});