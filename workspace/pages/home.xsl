<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../utilities/master.xsl" />

<!--
	Content
-->
	<xsl:template match="data" mode='content'>
		<xsl:attribute name='class'>main-container col3-layout</xsl:attribute>
		<div class="main">
			<div class="col-main">
				<div class="std">
					<div class="wired-home">
						<div class="promo">
							<xsl:apply-templates select='/data' mode='promo' />
						</div>
						<div class="subpromo">
							<xsl:apply-templates select='/data' mode='subpromo' />
						</div>
						<div class="promo-bottom">
							<xsl:apply-templates select='/data' mode='promo-bottom' />
						</div>
						<div class="featured-social">
							<xsl:apply-templates select='/data' mode='featured-social' />
						</div>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="data" mode='promo'>
		<div id="slider-wrapper">
			<div id="slider">
				<xsl:apply-templates select='read-home-page-heros/entry' mode='hero-item' />
				<div id="controls"> </div>
			</div>
		</div>
		<div class="promo-right">
			<xsl:apply-templates select='read-promos/entry' mode='promo-right' />
		</div>
	</xsl:template>
	
	<xsl:template match="entry" mode='hero-item'>
		<div class="panel">
			<img src="{$workspace}/uploads/homehero/01.jpg" alt="Flowing Rock" />
			<span class="comment">This is the comment</span>
		</div>
	</xsl:template>
	
	<xsl:template match="entry" mode='promo-right'>
		<a href="{link}">
			<img src="{$workspace}/{image/@path}/{image/filename}" alt="Flowing Rock" />
		</a>
	</xsl:template>
	
	<xsl:template match="data" mode='subpromo'>
		<div class="offers">
			<a href="#">
				<img src="{$workspace}/uploads/helloslide/promo6.jpg" alt="Promotion 2"/>
			</a>
			<a href="#">
				<img src="{$workspace}/uploads/helloslide/promo7.jpg" alt="Promotion 2"/>
			</a>
		</div>
		<div class="brands">
			<a href="#">
				<img src="{$workspace}/uploads/helloslide/promo5.jpg" alt="Promotion 2"/>
			</a>
		</div>
	</xsl:template>
	
	<xsl:template match="data" mode='promo-bottom'>
		<a href="#">
			<img src="{$workspace}/uploads/helloslide/promo4.jpg" alt="Promotion 4"/>
		</a>
	</xsl:template>
	
	<xsl:template match="data" mode='featured-social'>
		<ul id="featured" class="jcarousel-skin-tango">
			<xsl:apply-templates select='featured-products/entry' mode='featured-product' />
		</ul>
		<div class="subscribe">
			<strong>Stay Connected</strong>
			<p>Receive Promotions and Discounts, sign up today to receive yours!</p>
			<form action="http://demos.hellothemes.com/hellowired/newsletter/subscriber/new/" method="post" id="newsletter-validate-detail">
				<div class="form-subscribe">
					<label for="newsletter">Newsletter Sign-up:</label>
					<div class="input-box">
						<input type="text" name="email" id="newsletter" title="Sign up for our newsletter" class="input-text required-entry validate-email"/>
					</div>
					<button type="submit" title="Submit" class="button">
						<span><span>Submit</span></span>
					</button>
				</div>
			</form>
		</div>
	</xsl:template>
	
	<xsl:template match="entry" mode='featured-product'>
		<li>
			<a class="preview" rel="http://demos.hellothemes.com/media/catalog/product/cache/32/small_image/300x300/9df78eab33525d08d6e5fb8d27136e95/g/a/gaming-computer.jpg" href="http://demos.hellothemes.com/hellowired/gaming-computer.html" title="Gaming Computer">
				<img src="http://demos.hellothemes.com/media/catalog/product/cache/32/small_image/105x105/9df78eab33525d08d6e5fb8d27136e95/g/a/gaming-computer.jpg" width="105" height="105" alt="Gaming Computer"/>
			</a>
		</li>
	</xsl:template>	

</xsl:stylesheet>
