<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
Name: Data Source Pagination
Version: 1.2
Author: Nick Dunn <nick@nick-dunn.co.uk>
URL: http://symphony-cms.com/downloads/xslt/file/20482/

Parameters:
* pagination-element (required) XPath to the DS pagination element
* url (required) the URL for page links, $ is replaced with page number
* display-number (optional) how many pages to list until "..."
* next (optional) custom "Next" label text
* previous (optional) custom "Previous" label text
-->

<xsl:template name="pagination">
	<xsl:param name="pagination-element"/>
	<xsl:param name="url"/>
	<xsl:param name="display-number"/>
	<xsl:param name="next"/>
	<xsl:param name="previous"/>

	<xsl:variable name="display-number">
		<xsl:choose>
			<xsl:when test="$display-number &lt; 3">3</xsl:when>
			<xsl:when test="$display-number &lt; $pagination-element/@total-pages">
				<xsl:value-of select="$display-number"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pagination-element/@total-pages - 1"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:if test="$pagination-element/@total-pages &gt; 1">
		<xsl:variable name="next-label">
			<xsl:choose>
				<xsl:when test="$next=''">Next &#187;</xsl:when>
				<xsl:otherwise><xsl:value-of select="$next"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="previous-label">
			<xsl:choose>
				<xsl:when test="$previous=''">&#171; Previous</xsl:when>
				<xsl:otherwise><xsl:value-of select="$previous"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="current-page">
			<xsl:choose>
				<xsl:when test="$pagination-element/@current-page = ''">1</xsl:when>
				<xsl:otherwise><xsl:value-of select="$pagination-element/@current-page"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="previous-page">
			<xsl:choose>
				<xsl:when test="$current-page = 1"><xsl:value-of select="$pagination-element/@total-pages" /></xsl:when>
				<xsl:otherwise><xsl:value-of select="$current-page - 1" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="next-page">
			<xsl:choose>
				<xsl:when test="$current-page = $pagination-element/@total-pages">1</xsl:when>
				<xsl:otherwise><xsl:value-of select="$current-page + 1" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="last-section">
			<xsl:value-of select="$pagination-element/@total-pages - $display-number" />
		</xsl:variable>

		<xsl:variable name="first-page">
			<xsl:choose>
				<xsl:when test="$current-page &gt;= 1 and $current-page &lt; $display-number">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:when test="$current-page &gt; $last-section and $current-page &lt;= $pagination-element/@total-pages">
					<xsl:value-of select="$last-section" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$current-page - (floor($display-number div 2))" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="last-page">
			<xsl:choose>
				<xsl:when test="$current-page &gt; $last-section and $current-page &lt;= $pagination-element/@total-pages">
					<xsl:value-of select="$first-page + $display-number"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$first-page + $display-number - 1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<nav class="pagination">
			<ul class='inline'>
				<li>
					<xsl:if test="$next-page = 2">
						<xsl:attribute name="class">disabled</xsl:attribute>
					</xsl:if>
					<a class="pagination-previous">
						<xsl:attribute name="href">
							<xsl:call-template name="pagination-url-replace">
								<xsl:with-param name="string" select="$url" />
								<xsl:with-param name="search" select="'$'" />
								<xsl:with-param name="replace" select="string($previous-page)" />
							</xsl:call-template>
						</xsl:attribute>
						<xsl:value-of select="$previous-label"/>
					</a>
				</li>

				<xsl:call-template name="pagination-numbers">
					<xsl:with-param name="first-page" select="$first-page"/>
					<xsl:with-param name="last-page" select="$last-page"/>
					<xsl:with-param name="current-page" select="$current-page"/>
					<xsl:with-param name="iterations" select="$last-page - $first-page"/>
					<xsl:with-param name="total-pages" select="$pagination-element/@total-pages"/>
					<xsl:with-param name="url" select="$url"/>
				</xsl:call-template>

				<li>
					<xsl:if test="$next-page = 1">
						<xsl:attribute name="class">disabled</xsl:attribute>
					</xsl:if>
					<a class="pagination-next">
						<xsl:attribute name="href">
							<xsl:call-template name="pagination-url-replace">
								<xsl:with-param name="string" select="$url" />
								<xsl:with-param name="search" select="'$'" />
								<xsl:with-param name="replace" select="string($next-page)" />
							</xsl:call-template>
						</xsl:attribute>
						<xsl:value-of select="$next-label"/>
					</a>
				</li>
			</ul>
		</nav>
	</xsl:if>

</xsl:template>

<xsl:template name="pagination-numbers">
	<xsl:param name="first-page" select="$first-page"/>
	<xsl:param name="last-page" select="$last-page"/>
	<xsl:param name="current-page" select="$current-page"/>
	<xsl:param name="iterations" select="$iterations"/>
	<xsl:param name="total-pages" select="$total-pages"/>
	<xsl:param name="url" select="$url"/>
	<xsl:param name="count" select="$iterations"/>

	<xsl:if test="$count &gt;= 0">

		<xsl:variable name="this-page" select="$first-page + ($iterations - $count)"/>

		<xsl:if test="$this-page = $first-page and $first-page &gt; 1">
			<li>
				<a class="page">
					<xsl:attribute name="href">
						<xsl:call-template name="pagination-url-replace">
							<xsl:with-param name="string" select="$url" />
							<xsl:with-param name="search" select="'$'" />
							<xsl:with-param name="replace" select="'1'" />
						</xsl:call-template>
					</xsl:attribute>
					<xsl:text>1</xsl:text>
				</a>
				<xsl:if test="$this-page != 2">
					<span>...</span>
				</xsl:if>
			</li>
		</xsl:if>

		<li>
			<xsl:if test="$this-page = $current-page">
				<xsl:attribute name="class">selected</xsl:attribute>
			</xsl:if>
			<a class="page">
				<xsl:attribute name="href">
					<xsl:call-template name="pagination-url-replace">
						<xsl:with-param name="string" select="$url"/>
						<xsl:with-param name="search" select="'$'"/>
						<xsl:with-param name="replace" select="string($this-page)"/>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:value-of select="$this-page"/>
			</a>
		</li>

		<xsl:if test="$this-page = $last-page and $last-page &lt; $total-pages">
			<li>
				<xsl:if test="$this-page != ($total-pages - 1)">
					<span>...</span>
				</xsl:if>
				<a class="page">
					<xsl:attribute name="href">
						<xsl:call-template name="pagination-url-replace">
							<xsl:with-param name="string" select="$url" />
							<xsl:with-param name="search" select="'$'" />
							<xsl:with-param name="replace" select="string($total-pages)" />
						</xsl:call-template>
					</xsl:attribute>
					<xsl:value-of select="$total-pages" />
				</a>
			</li>
		</xsl:if>

		<xsl:call-template name="pagination-numbers">
			<xsl:with-param name="count" select="$count - 1"/>
			<xsl:with-param name="first-page" select="$first-page"/>
			<xsl:with-param name="last-page" select="$last-page"/>
			<xsl:with-param name="current-page" select="$current-page"/>
			<xsl:with-param name="total-pages" select="$total-pages"/>
			<xsl:with-param name="url" select="$url"/>
			<xsl:with-param name="iterations" select="$iterations"/>
		</xsl:call-template>

	</xsl:if>

</xsl:template>

<xsl:template name="pagination-url-replace">
	<xsl:param name="string"/>
	<xsl:param name="search"/>
	<xsl:param name="replace"/>

	<xsl:value-of select="concat(substring-before($string,$search), $replace, substring-after($string,$search))"/>
</xsl:template>

</xsl:stylesheet>