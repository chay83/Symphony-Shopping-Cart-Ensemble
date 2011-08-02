// Font Replacement
Cufon.replace('.category-title h1,.footer h4, .product-view .product-shop .product-name h1,.page-title h1, .page-title h2,.wired-home .subscribe strong', {
	hover: true
});

jQuery(document).ready(function() {
	// Featured Products
    jQuery('#featured').jcarousel();
	// FancyBox jQuery
	jQuery("a.group").fancybox({ 'zoomSpeedIn': 300, 'zoomSpeedOut': 300, 'overlayShow': true }); 	
	// Slider Homepage
	jQuery('#slider').cycle({
        fx: 'fade',
        speed: 2000,
		timeout: 5000,
        pager: '#controls',
		slideExpr: '.panel'
    });
});

$(document).ready(function() { 
    $('ul.sf-menu').superfish(); 
});

 $(document).ready(function() {
        $("ul#nav li").mouseover(function(){ //When mouse over ...
        	   //Following event is applied to the subnav itself (making height of subnav 60px)
		      $(this).find('ul').stop().animate({height: '60px', opacity:'1' , display: 'block'},{queue:false, duration:1500, easing: 'easeOutBounce'})
		});

	    $("ul#nav li").mouseout(function(){ //When mouse out ...
	          //Following event is applied to the subnav itself (making height of subnav 0px)
		      $(this).find('ul').stop().animate({height:'0px', opacity:'0', display: 'none'},{queue:false, duration:1600, easing: 'easeOutBounce'})
		});
        //menu item background color animation
		$("li").hover(function() {
             // $(this).stop().animate({ backgroundColor: "#C13D93"}, 600);
             },
           function() {
             // $(this).stop().animate({ backgroundColor: "#333333" }, 600);
        });
});