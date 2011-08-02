<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Content
-->
	<xsl:template match="data" mode='product'>
		<xsl:attribute name='class'>main-container col2-right-layout</xsl:attribute>
		<div class="col-main">
			<div class="product-view">
				<xsl:apply-templates select='read-products-for-category-and-subcategories/entry' mode='product-essential' />
				<xsl:apply-templates select='read-products-for-category-and-subcategories/entry' mode='product-collateral' />
			</div>
		</div>
		<div class="col-right">
			<xsl:apply-templates select='/data' mode='right-sidebar' />
		</div>
	</xsl:template>
	
	<xsl:template match="entry" mode='product-essential'>
	
	</xsl:template>
	
	<xsl:template match="entry" mode='product-collateral'>
	
	</xsl:template>
	
	<xsl:template match="data" mode='right-sidebar'>
		<xsl:apply-templates select='shopping-cart' mode='cart-block' />
	</xsl:template>

</xsl:stylesheet>