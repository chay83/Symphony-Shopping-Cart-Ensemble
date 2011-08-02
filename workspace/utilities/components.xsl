<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="data" mode='tag-block'>
		<div class="block block-layered-nav">
			<div class="block-title">
				<strong><span>Browse By</span></strong>
			</div>
			<div class="block-content">
				<dl id="narrow-by-list2">
					<dt>Category</dt>
					<dd>
						<ol>
							<li><a href="http://demos.hellothemes.com/hellowired/furniture/living-room.html">Living Room</a> (4)</li>
							<li><a href="http://demos.hellothemes.com/hellowired/furniture/bedroom.html">Bedroom</a> (2)</li>
						</ol>
					</dd>
				</dl>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="shopping-cart" mode="cart-block">
		<div class="block block-cart">
			<div class="block-title">
				<strong>
					<span>My Cart</span>
				</strong>
			</div>
			<div class="block-content">
				<p class="empty">You have no items in your shopping cart.</p>
			</div>
		</div>
	</xsl:template>

</xsl:stylesheet>