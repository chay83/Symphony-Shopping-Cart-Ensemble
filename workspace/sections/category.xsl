<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Content
-->
	<xsl:template match="data" mode='product-list'>
		<xsl:attribute name='class'>main-container col3-layout</xsl:attribute>
		<div class="main">
			<div class="col-left sidebar">
				<xsl:apply-templates select='/data' mode='left-sidebar' />
			</div>
			<div class="col-main">
				<xsl:apply-templates select='read-category-information/entry' mode='main' />
			</div>
			<div class="col-right sidebar">
				<xsl:apply-templates select='/data' mode='right-sidebar' />
			</div>
		</div>			
	</xsl:template>
	
	<xsl:template match="data" mode='left-sidebar'>
		<xsl:apply-templates select='/data' mode='tag-block' />
	</xsl:template>
	
	<xsl:template match="data" mode='right-sidebar'>
		<xsl:apply-templates select='shopping-cart' mode='cart-block' />
	</xsl:template>
	
	<xsl:template match="entry" mode='main'>
		<div class="page-title category-title">
			<h1><xsl:value-of select="name"  /></h1>
		</div>
		<div class="category-description">
			<xsl:apply-templates select='description/*' mode='output' />
		</div>
		<xsl:apply-templates select='/data' mode='filter-bar' />
		<ul class="products-grid">
			<xsl:apply-templates select='/data/read-products-for-category-and-subcategories/entry' mode='product-list-grid' />
		</ul>
	</xsl:template>
	
	<xsl:template match="entry" mode='product-list-grid'>
		<li class="item first">
			<a href="{title/@handle}" title="{title}" class="product-image">
				<img src="{$root}/image/2/170/170/5{image/@path}/{image/filename}" />
			</a>
			<h2 class="product-name">
				<a href="{title/@handle}" title="{title}"><xsl:value-of select="title"  /></a>
			</h2>
			<div class="price-box">
				<span class="regular-price" id="product-price-41">
					<span class="price">$<xsl:value-of select="price"  /></span>
				</span>
			</div>
			<div class="actions">
				<form method="post" class="add-cart">
					<input type="hidden" name="id" value="{@id}"/>
					<input type="hidden" name="cart-action" value="add" />
					<button class="button btn-cart" title="Add to Cart" type="submit">
						<span><span>Add to Cart</span></span>
					</button>
				</form>
				<!--<ul class="add-to-links">
					<li>
						<a href="/wishlist/index/add/product/41/" class="link-wishlist">Add to Wishlist</a>
					</li>
					<li>
						<span class="separator">|</span>
						<a href="#" class="link-compare">Add to Compare</a>
					</li>
				</ul>-->
			</div>
		</li>
	</xsl:template>
	
	<xsl:template match="data" mode='filter-bar'>
		<div class="toolbar">
			<div class="pager">
				<p class="amount">
					<strong>6 Item(s)</strong>
				</p>
				<div class="limiter">
					<label>Show</label>
					<select>
						<option value="?limit=9" selected="selected">9</option>
						<option value="?limit=15">15</option>
						<option value="?limit=30">30</option>
					</select>
					<xsl:text> per page </xsl:text>       
				</div>
			</div>
			<div class="sorter">
				<p class="view-mode">
					<label>View as:</label>
					<strong title="Grid" class="grid">Grid</strong>
					<a href="?mode=list" title="List" class="list">List</a>
				</p>
				<div class="sort-by">
					<label>Sort By</label>
					<select onchange="setLocation(this.value)">
						<option value="?dir=asc&amp;order=position" selected="selected">Position</option>
						<option value="?dir=asc&amp;order=name">Name</option>
						<option value="?dir=asc&amp;order=price">Price</option>
					</select>
					<a href="?dir=desc&amp;order=position" title="Set Descending Direction">
						<img src="http://demos.hellothemes.com/skin/frontend/default/hellowired/images/i_asc_arrow.gif" alt="Set Descending Direction" class="v-middle"/>
					</a>
				</div>
			</div>
		</div>
	</xsl:template>
	
	
</xsl:stylesheet>