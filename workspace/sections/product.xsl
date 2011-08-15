<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Content
-->
	<xsl:template match="data" mode='product'>
		<xsl:attribute name='class'>main-container col2-right-layout</xsl:attribute>
		
		<div class="main">
			<div class="col-main">
				<div class="product-view">
					<xsl:apply-templates select='read-product-by-id/entry' mode='product-essential' />
					<xsl:apply-templates select='read-product-by-id/entry' mode='product-collateral' />
				</div>
			</div>
			<div class="col-right">
				<xsl:apply-templates select='/data' mode='right-sidebar' />
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="entry" mode='product-essential'>
		<div class="product-essential">
			<form id="product_addtocart_form" method="post" class="add-cart">
				<xsl:apply-templates select="." mode="product-details" />
				<xsl:apply-templates select='.' mode='product-gallery' />				
			</form>
		</div>
	</xsl:template>
	
	<xsl:template match="entry" mode='product-collateral'>
		<div class="product-collateral">
			<xsl:apply-templates select='.' mode='product-tabs' />
			<xsl:apply-templates select='.' mode='product-boxes' />	
		</div>
	</xsl:template>
	
	<xsl:template match="entry" mode='product-tabs'>
		<ul class="product-tabs">
			<xsl:if test="long-description">
				 <li id="product_tabs_description"><a href="#">Product Description</a></li>
			</xsl:if>
			<xsl:if test="related-products">
				 <li id="product_tabs_upsell_products"><a href="#">We Also Recommend</a></li>
			</xsl:if>
			<xsl:if test="aditional-information">
				 <li id="product_tabs_additional"><a href="#">Additional Information</a></li>
			</xsl:if>
			<xsl:if test="tags">
				 <li id="product_tabs_tags"><a href="#">Tags</a></li>
			</xsl:if>
		</ul>
	</xsl:template>
	
	<xsl:template match="entry" mode='product-boxes'>
		<xsl:if test="long-description">
			 <div id="product_tabs_description_contents" class="product-tabs-content">
			 	<div class="std"><xsl:apply-templates select='long-description/*' mode='output' /></div>
			 </div>
		</xsl:if>
		<xsl:if test="related-products">
			<div id="product_tabs_upsell_products_contents" class="product-tabs-content">
				<xsl:apply-templates select='/data/read-related-products/entry' mode='related-product' />
			</div>			 
		</xsl:if>
		<xsl:if test="aditional-information">
			<div id="product_tabs_additional_contents" class="product-tabs-content">
				 <h2>Additional Information</h2>
				 <table id="product-attribute-specs-table" class="data-table">
				 	<colgroup>
				 		<col width="25%"></col>
				 		<col></col>
				 	</colgroup>
				 	<tbody>
				 		<xsl:for-each select="aditional-information/key">
				 			<tr>
				 				<th class="label"><xsl:value-of select="@name"  /></th>
				 				<td class="data"><xsl:value-of select="value"  /></td>
				 			</tr>
				 		</xsl:for-each>
				 	</tbody>
				 </table>
			</div>
		</xsl:if>
		<xsl:if test="tags">
			 <div id="product_tabs_tags_contents" class="product-tabs-content"></div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="entry" mode='related-product'>
	
	</xsl:template>
	
	<xsl:template match="entry" mode='product-details'>
		<div class="product-shop">
			<div class="product-name">
				<h1><xsl:value-of select="title"  /></h1>
			</div>
			<xsl:apply-templates select='qty' mode='availability' />
			<div class="price-box">
				<span id="product-price-51" class="regular-price">
					<span class="price">$<xsl:value-of select="price"  /></span>
				</span>
			</div>
			<div class="add-to-box">
				<div class="add-to-cart">
			    	<label for="qty">Qty:</label>
			    	<input type="hidden" name="id" value="{@id}"/>
			    	<input type="hidden" name="cart-action" value="add" />
			        <input type="text" class="input-text qty" title="Qty" value="1" maxlength="12" id="qty" name="num" />
			        <button class="button btn-cart" title="Add to Cart" type="submit">
			        	<span><span>Add to Cart</span></span>
			        </button>
				</div>
			</div>
			<div class="short-description">
				<h2>Quick Overview</h2>
				<xsl:apply-templates select="quick-description" mode="output"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="qty" mode="availability">
		<p class="availability in-stock">Availability: <span>In stock</span></p>
	</xsl:template>
	
	<xsl:template match="entry" mode='product-gallery'>
		<div class="product-img-box">
            <p class="product-image product-image-zoom">
			    <img title="Ottoman" alt="Ottoman" src="{$workspace}{image/@path}/{image/filename}" id="image" />
			</p>
			<p id="track_hint" class="zoom-notice">Double click on above image to view full picture</p>
			<div class="zoom">
			    <img class="btn-zoom-out" title="Zoom Out" alt="Zoom Out" src="{$workspace}/assets/images/slider_btn_zoom_out.gif" id="zoom_out" />
			    <div id="track">
			        <div id="handle"></div>
			    </div>
			    <img class="btn-zoom-in" title="Zoom In" alt="Zoom In" src="{$workspace}/assets/images/slider_btn_zoom_in.gif" id="zoom_in" />
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="data" mode='right-sidebar'>
		<xsl:apply-templates select='shopping-cart' mode='cart-block' />
	</xsl:template>

</xsl:stylesheet>