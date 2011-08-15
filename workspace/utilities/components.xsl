<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param name="ds-shopping-cart" />

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
				<xsl:choose>
					<xsl:when test="$ds-shopping-cart">
						<div class="summary">
							<p class="amount">
								<xsl:text>There </xsl:text> 
								<xsl:choose>
									<xsl:when test="sum(/data/shopping-cart/item/@num) &gt; 1">are </xsl:when>
									<xsl:otherwise>is </xsl:otherwise>
								</xsl:choose> 
								<a href="{$root}/cart/"><xsl:value-of select="sum(/data/shopping-cart/item/@num)"  /> 
									item<xsl:if test="sum(/data/shopping-cart/item/@num) &gt; 1">s</xsl:if>
								</a> 
								<xsl:text> in your cart.</xsl:text>
							</p>
							<p class="subtotal">
								<span class="label">Cart Subtotal:</span> 
								<span class="price">$<xsl:value-of select="/data/shopping-cart/@total"  /></span>                            
							</p>
						</div>
						<p class="block-subtitle">Recently added item(s)</p>
						<ol class="mini-products-list" id="cart-sidebar">
							<xsl:apply-templates select='/data/shopping-cart/item' mode='cart-item' />						
						</ol>
					</xsl:when>
					<xsl:otherwise>
						<p class="empty">You have no items in your shopping cart.</p>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="item" mode="cart-item">
		<xsl:variable name="product" select="/data/read-products-in-cart/entry[@id = current()/@id]" />
		<li class="item last odd">
			<a class="product-image" title="{$product/title}" href="#">
				<img src="{$root}/image/2/50/50/5{$product/image/@path}/{$product/image/filename}" />
			</a>
		    <div class="product-details">
		    	<a class="btn-remove" title="Remove This Item" href="?cart-action=drop&amp;id={$product/@id}">Remove This Item</a>
		       	<a class="btn-edit" title="Edit item" href="#">Edit item</a>
		      	<p class="product-name"><a href="#"><xsl:value-of select="$product/title"  /></a></p>
		    	<strong><xsl:value-of select="@num"  /></strong> x
				<span class="price">$<xsl:value-of select="$product/price"  /></span>                    
			</div>
		</li>
		
		
	</xsl:template>

</xsl:stylesheet>