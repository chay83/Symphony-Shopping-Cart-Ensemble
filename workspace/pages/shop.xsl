<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../utilities/master.xsl" />
	<xsl:import href="../sections/category.xsl" />
	<xsl:import href="../sections/product.xsl" />

<!--
	Content
-->
	<xsl:template match="data" mode='content'>
		<xsl:choose>
			<xsl:when test="$mode = 'category'">
				<xsl:apply-templates select='/data' mode='product-list' />
			</xsl:when>
			<xsl:when test="$mode = 'product'">
				<xsl:apply-templates select='/data' mode='product' />
			</xsl:when>
		</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>