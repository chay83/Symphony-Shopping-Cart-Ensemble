<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl"
                version="1.0">
	<xsl:param name='ds-system-sub-navigation-active' />
	<xsl:param name="handle" select="false()" />
	<xsl:param name="tag" />

	<!-- Breadcrumbs -->
	<xsl:template match="data" mode="breadcrumbs">
		<xsl:param name="item" select="false()" />

		<nav id='breadcrumbs'>
			<ul class='inline'>
				<li>
					<a href="{$root}" class='home-breadcrumb'>Home</a>
				</li>

				<xsl:apply-templates select='.' mode='breadcrumb-items' />
			</ul>
		</nav>
	</xsl:template>

	<xsl:template match='data' mode='breadcrumb-items' name='breadcrumb-items'>
		<xsl:if test="$current-page != 'home'">
			<xsl:apply-templates select="system-navigation/entry[@id = $ds-system-navigation-active and name/@handle != 'home'] | system-sub-navigation//entry[@id = $ds-system-sub-navigation-active]" mode="breadcrumb"/>
		</xsl:if>
	</xsl:template>

<!--
	Breadcrumb items
-->
	<xsl:template match="entry" mode="breadcrumb">
		<xsl:choose>
			<xsl:when test="name/@handle = $handle">
				<li><xsl:value-of select="name"/></li>
			</xsl:when>
			<xsl:when test="name/@handle = $current-page and not($handle)">
				<li><xsl:value-of select="name"/></li>
			</xsl:when>
			<xsl:when test='no-index = "Yes"'>
				<li><xsl:value-of select="name" /></li>
				<xsl:apply-templates select="system-navigation/entry[@id = $ds-system-navigation-active] | system-sub-navigation//entry[@id = $ds-system-sub-navigation-active]" mode='breadcrumb' />
			</xsl:when>
			<xsl:otherwise>
				<li><a href="{$root}{link}/"><xsl:value-of select="name" /></a></li>
				<xsl:apply-templates select="system-navigation/entry[@id = $ds-system-navigation-active] | system-sub-navigation//entry[@id = $ds-system-sub-navigation-active]" mode='breadcrumb' />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Main nav wrapper -->
	<xsl:template match="data" mode='navigation'>
		<xsl:param name='type' />
		<xsl:param name='inline' select='true()' />

		<nav id='nav-{$type}'>
			<xsl:if test='$inline'>
				<xsl:attribute name='class'>inline</xsl:attribute>
			</xsl:if>

			<ol>
				<xsl:if test="$type = 'skyline'">
					<xsl:apply-templates select='system-sub-navigation/parent/entry[skyline="Yes"]' mode='nav-item'>
						<xsl:with-param name='type' select="$type" />
					</xsl:apply-templates>
				</xsl:if>

				<xsl:apply-templates select='system-navigation/entry/*[local-name() = $type][text() = "Yes"]/parent::entry' mode='nav-item'>
					<xsl:with-param name='type' select="$type" />
				</xsl:apply-templates>
			</ol>
		</nav>
	</xsl:template>

	<!-- Sub Navigation -->
	<xsl:template match="parent" mode='sub-navigation'>
		<xsl:param name='type' />

		<nav class='sub-nav inline'>
			<ol>
				<xsl:apply-templates select='entry/*[local-name() = $type][text() = "Yes"]/parent::entry' mode='nav-item'>
					<xsl:with-param name='type' select="'sub'" />
				</xsl:apply-templates>
			</ol>
		</nav>
	</xsl:template>

	<!-- Top level -->
	<xsl:template match='entry' mode='nav-item'>
		<xsl:param name='type' />

		<li>
			<!-- Active ? -->
			<xsl:choose>
				<xsl:when test='@id = $ds-system-navigation-active or @id = $ds-system-sub-navigation-active'>
					<xsl:attribute name="class"><xsl:value-of select='concat($type,"-",name/@handle)' /> active</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class"><xsl:value-of select='concat($type,"-",name/@handle)' /></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test='no-index = "Yes"'>
					<xsl:value-of select='name' />
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select='.' mode='nav-guts' />
				</xsl:otherwise>
			</xsl:choose>

			<!-- Stupid Hack to stop News Archives from appearing in the skyline -->
			<xsl:if test='name/@handle != "news"'>
				<xsl:apply-templates select='/data/system-sub-navigation/parent[@link-id = current()/@id]' mode='sub-navigation'>
					<xsl:with-param name='type' select='$type' />
				</xsl:apply-templates>
			</xsl:if>
		</li>
	</xsl:template>

	<!-- Sub-nav, identical minus element/@id and sub nav check -->
	<xsl:template match='entry' mode='sub-item'>
		<li>
			<xsl:apply-templates select='.' mode='nav-guts' />
		</li>
	</xsl:template>

	<xsl:template name='randb'>
		<li class='static'>
			<a href='http://www.randb.com.au' rel='external' class='randb'>Site by R&amp;B</a>
		</li>
	</xsl:template>

	<!-- Common to all navigation elements (header/footer) -->
	<xsl:template match='entry' mode='nav-guts'>
		<a>
			<!-- External ? -->
			<xsl:choose>
				<xsl:when test='starts-with(link, "http")'>
					<xsl:attribute name='href'>
						<xsl:value-of select='link' />
					</xsl:attribute>
					<xsl:attribute name='rel'>
						<xsl:text>external</xsl:text>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name='href'>
						<xsl:choose>
							<xsl:when test='contains(link,"#")'>
								<xsl:value-of select='concat($root,link)' />
							</xsl:when>
							<xsl:when test='link = "/"'>
								<xsl:value-of select='concat($root,"/")' />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select='concat($root,link,"/")' />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>

			<!-- Active ? -->
			<xsl:if test='$ds-system-navigation-active = @id'>
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>

			<xsl:value-of select='name' />
		</a>
	</xsl:template>
	
	<!-- Main Category nav wrapper -->
	<xsl:template match="data" mode='navigation'>
		<ul class='sf-menu'>
			<li class="home"><a href="{$root}"><span>Home</span></a></li>
			<xsl:apply-templates select='read-categories-for-navigation/entry[not(parent)]' mode='cat-nav-item'>
			</xsl:apply-templates>
		</ul>
	</xsl:template>

	<xsl:template match="entry" mode="cat-nav-item">
		<xsl:param name="parent" />
		
		<xsl:variable name="parent-nodes" >
			<nodes>
				<xsl:apply-templates select="." mode="parent-node" />
			</nodes>
		</xsl:variable>
		
		<xsl:variable name="parent-path" >
			<xsl:for-each select="exsl:node-set($parent-nodes)/nodes/node">
				<xsl:sort select="@id" data-type="number" order="ascending" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="."  />
			</xsl:for-each>
		</xsl:variable>
		
		<li>
			<xsl:attribute name="class">
				<xsl:text>level</xsl:text>
				<xsl:value-of select="count(exsl:node-set($parent-nodes)/nodes/node)"  />
			</xsl:attribute>
			<a href="{$root}/shop{$parent-path}/{name/@handle}">
				<span><xsl:value-of select="name"  /></span>
			</a>
			<xsl:if test="../entry[parent/item/@id = current()/@id]">
				<ul>
					<xsl:apply-templates select='../entry[parent/item/@id = current()/@id]' mode='cat-nav-item'>
						<xsl:with-param name="parent" />
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>
	
	<xsl:template match="entry" mode="parent-node" >
		<xsl:variable name="number">
			<xsl:number />
		</xsl:variable>
		
		<xsl:if test="../entry[@id = current()/parent/item/@id]">
			<xsl:apply-templates select='../entry[@id = current()/parent/item/@id]' mode='parent-node' />
		</xsl:if>
		
		<xsl:if test="parent/item">
			<node id="{$number}"><xsl:value-of select="parent/item/@handle"  /></node>
		</xsl:if>
		
		
		
	</xsl:template>
	
	
</xsl:stylesheet>