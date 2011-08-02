<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/format-date.xsl" />
	<xsl:import href="../utilities/output.xsl" />
	<xsl:import href="../utilities/images.xsl" />
	<xsl:import href="../utilities/navigation.xsl" />
	<xsl:import href="../utilities/pagination.xsl" />
	<xsl:import href="../utilities/components.xsl" />

	<xsl:output
		omit-xml-declaration="no"
		method="html"
		indent='yes'
	/>

<!--
	Global Datasources
-->
	<xsl:variable name='g-copy' select='/data/system-copy-by-page' />
	<xsl:variable name='g-seo' select='/data/system-seo/entry' />

<!--
	Constants
-->
	<xsl:variable name='date-output' select="'%d;%ds; %m+; %y+;'" />
	<xsl:variable name='time-output' select="'#h;:#0m;#ts;'" />
	<xsl:variable name='assets-version' select='"1"' />
	<xsl:param name="site-mode" />
	<xsl:param name="mode" />

<!--
	Title
-->
	<xsl:template match="/" mode="title">
		<xsl:choose>
			<xsl:when test='$g-seo/meta-title'>
				<xsl:value-of select='$g-seo/meta-title' />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$page-title" />
				<xsl:text> | </xsl:text>
				<xsl:value-of select="$website-name" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="data" mode="title">
		<title>
			<xsl:apply-templates select="/" mode="title" />
		</title>
	</xsl:template>

<!--
	Descriptions
-->
	<xsl:template match="/" mode="descriptions">
		<meta name="description" content="{$g-seo/meta-description}" />
	</xsl:template>

	<xsl:template match="/" mode="keywords">
		<meta name="keywords">
			<xsl:attribute name="content">
				<xsl:for-each select='$g-seo/meta-keywords/item'>
					<xsl:value-of select="."/>
					<xsl:if test='following-sibling::*'>
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</xsl:attribute>
		</meta>
	</xsl:template>

	<xsl:template match="data" mode="descriptions">
		<xsl:apply-templates select="/" mode="keywords" />
		<xsl:apply-templates select="/" mode="descriptions" />
	</xsl:template>

<!--
	Includes
-->
	<xsl:template match="/" mode="includes">
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/widgets.css" media="all" />
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/nav.css" media="all" />
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/styles.css" media="all" />
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/custom.css" media="all" />
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/print.css" media="print" />

		<link rel="shortcut icon" href="{$root}/favicon.ico" type="image/x-icon" />
		<link rel="apple-touch-icon" href="{$root}/apple-touch-icon.png" />

		<!-- All JavaScript at the bottom, except for Modernizr which enables HTML5 elements & feature detects -->
		<script src="{$workspace}/assets/js/libs/modernizr.min.js"></script>
	</xsl:template>

	<xsl:template match="data" mode="includes">
		<xsl:apply-templates select="/" mode="includes" />
	</xsl:template>

<!--
	Footer Includes
-->

	<xsl:template match="/" mode="footer-includes">
		<!-- Grab Google CDN's jQuery. -->
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js"></script>
		<script type="text/javascript" src="{$workspace}/assets/js/hello.jquery.js"></script>
		<script type="text/javascript" src="{$workspace}/assets/js/jquery.cycle.all.js"></script>
		<script type="text/javascript" src="{$workspace}/assets/js/superfish.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script> 
		<script type="text/javascript" src="{$workspace}/assets/js/xmltojson.js"></script> 
		<script type="text/javascript" src="{$workspace}/assets/js/cart.js"></script> 
		<script type="text/javascript" src="{$workspace}/assets/js/custom.js"></script>

		<xsl:choose>
			<xsl:when test='$mode = "production"'>
					<script type="text/javascript" src="{$workspace}/assets/js/production.min.js?v={$assets-version}"></script>
				<xsl:call-template name='analytics' />
			</xsl:when>
			<xsl:otherwise>
				<script src="{$workspace}/assets/js/common.js"></script>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name='analytics'>
		<script type="text/javascript">
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', '']);
			_gaq.push(['_trackPageview']);
			_gaq.push(['_trackPageLoadTime']);

			(function(d, t) {
				var g = d.createElement(t),
				s = d.getElementsByTagName(t)[0];
				g.async = true;
				g.src = '//www.google-analytics.com/ga.js';
				s.parentNode.insertBefore(g, s);
			}(document, 'script'));
		</script>
	</xsl:template>

	<xsl:template match="data" mode="footer-includes">
		<xsl:apply-templates select="/" mode="footer-includes" />
	</xsl:template>
	
	<xsl:template match="data" mode="search-form">
		<form id="search_mini_form" method="get">
			<div class="form-search">
				<label for="search">Search</label>
				<input id="search" type="text" name="q" value="" class="input-text"/>
				<input type="image" class="search_btn" src="/workspace/assets/images/icons/search_ico.gif" value="Go"/>
				<div id="search_autocomplete" class="search-autocomplete"></div>
			</div>
		</form>
	</xsl:template>
	
	<xsl:template match="data" mode="header-container">
		<div class="header">
			<h1 class="logo"><img src="{$workspace}/assets/images/logo.png" alt="Wired"/></h1>
			<div class="cms-links">
				<ul>
					<li class="welcome">Default welcome msg!</li>
					<li><a href="#">Order Status</a></li>
					<li><a href="#">Customer Service</a></li>
					<li class="last"><a href="#">Find a store</a></li>
				</ul>
			</div>
			<div class="access">
				<ul class="links">
					<li class="first">
						<a href="{$root}/customer/account/" title="My Account">My Account</a>
					</li>
					<li>
						<a href="{$root}/wishlist/" title="My Wishlist">My Wishlist</a>
					</li>
					<li>
						<a href="{$root}/checkout/cart/" title="My Cart" class="top-link-cart">My Cart</a>
					</li>
					<li>
						<a href="{$root}/checkout/" title="Checkout" class="top-link-checkout">Checkout</a>
					</li>
					<li class=" last">
						<a href="{$root}/customer/account/login/" title="Log In">Log In</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="navigation">
			<div class="nav-container">
				<xsl:apply-templates select='/data' mode='navigation'>
					<xsl:with-param name='type' select='"menu"' />
				</xsl:apply-templates>	
			</div>
			<xsl:apply-templates select="/data" mode="search-form" />
			<div class="clearfix"></div>
		</div>		
		
	</xsl:template>
	
	<xsl:template match="data" mode="footer-container">
		<div class="footer">
			<div class="footer-links">
				<div class="footer-block first">
					<h6>Customer Service</h6>
					<ul>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/about-magento-store/">About Us</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/our-company/">Our company</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/catalog/seo_sitemap/category/">Sitemap</a>
						</li>
					</ul>
				</div>
				<div class="footer-block">
					<h6>Customer Info</h6>
					<ul>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/contacts/">Contact Us</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/price-matching/">Price matching</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/testimonials/">Testimonials</a>
						</li>
					</ul>
				</div>
				<div class="footer-block">
					<h6>Corporate</h6>
					<ul>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/privacy/">Privacy Policy</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/safe-shopping/">Safe &amp; secure shopping</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/terms/">Terms &amp; conditions</a>
						</li>
					</ul>
				</div>
				<div class="footer-block last">
					<h6>Information</h6>
					<ul>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/delivery/">Delivery information</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/guarantee/">Satisfaction guarantee</a>
						</li>
						<li>
							<a href="http://demos.hellothemes.com/hellowired/returns/">Returns policy</a>
						</li>
					</ul>
				</div>
				<div class="payment">
					<img src="{$root}/assets/images/creditcards.gif" alt="We Accept all Major Credit Cards"/>
				</div>
			</div>
		</div>
	</xsl:template>

<!--
	Content
-->
	<xsl:template match="data" />

<!--
	Main
-->
	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;&#10;</xsl:text>
		<xsl:comment>[if IE 8]&gt;&lt;html id="ie" class="v8"&gt;&lt;![endif]</xsl:comment>
		<xsl:comment>[if IE 7]&gt;&lt;html id="ie" class="v7"&gt;&lt;![endif]</xsl:comment>
			<head charset='utf-8'>
				<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<meta http-equiv="imagetoolbar" content="false" />
				<meta name="MSSmartTagsPreventParsing" content="true" />

				<xsl:apply-templates select="data" mode="title" />
				<xsl:apply-templates select="data" mode="descriptions" />
				<xsl:apply-templates select="data" mode="includes" />
			</head>
			<body>
				<xsl:attribute name='id'>
					<xsl:value-of select='$current-page' />
				</xsl:attribute>
				<div class="wrapper">
					<div class="inner-wrapper">
						<div class="page">						
							<div class="header-container">
								<xsl:apply-templates select="data" mode="header-container" />
								
							</div>
							<div class="main-container">
								<xsl:apply-templates select='data' mode='content' />
							</div>
							<div class="footer-container">
								<xsl:apply-templates select="data" mode="footer-container" />
							</div>
							<div class="copyright">
								<div class="f-left">
									<address>  2008 Magento Demo Store. All Rights Reserved.</address>
								</div>
								<div class="f-right">
									<a href="http://www.hellothemes.com/" title="Magento Templates">Magento Templates</a> by <a href="http://www.hellothemes.com/" title="Magento Themes"><img src=" /workspace/assets/images/media/hellothemes.png" alt="Magento Themes"/></a>
								</div>
								<div style="clear:both;"/>
							</div>					
						</div>
					</div>
				</div>
				<xsl:apply-templates select="data" mode="footer-includes" />
			</body>

		<xsl:comment>[if (IE 7)|(IE 8)]&gt;&lt;/html&gt;&lt;![endif]</xsl:comment>
	</xsl:template>

</xsl:stylesheet>