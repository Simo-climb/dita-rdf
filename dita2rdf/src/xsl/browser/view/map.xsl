<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:colin="http://colin.maudry.com/"
	xmlns:doc="http://www.oxygenxml.com/ns/doc/xsl" xmlns:s="http://www.w3.org/2005/sparql-results#" 
	exclude-result-prefixes="colin xs doc s">
	<xsl:template name="maps">
		<xsl:param name="data"/>
		<!-- This template goes through each data set and make an HTML file. -->
		<xsl:apply-templates select="$data/s:results/s:result" mode="map"/>	
		
	</xsl:template>
	
	<xsl:template mode="map" match="s:result">
		<xsl:param name="template" tunnel="yes"/>
		<xsl:variable name="targetFileUrl" select="concat($outputFolder,'/',colin:uri2path('map',s:binding[@name='thing']/s:uri))"/>
		<xsl:message select="$targetFileUrl"/>
		<xsl:if test="not(preceding-sibling::s:result) or preceding-sibling::s:result[1]/s:binding[@name='thing']/s:uri/text() != s:binding[@name='thing']/s:uri/text()">
				<xsl:result-document  method="xhtml" href="{$targetFileUrl}">
					<xsl:call-template name="mapPage">
						<xsl:with-param name="objectInfo" select="." tunnel="yes"/>
					</xsl:call-template>
				</xsl:result-document>		
			</xsl:if>
	</xsl:template>
	
	<xsl:template name="mapPage">
		<xsl:param name="objectInfo" tunnel="yes"/>
		<xsl:param name="template" tunnel="yes"/>
		<xsl:apply-templates select="$template/*">
			<xsl:with-param name="data" as="element()" tunnel="yes">
				<xsl:call-template name="colin:getData">
					<xsl:with-param name="queryName">map</xsl:with-param>
					<xsl:with-param name="uri" select="$objectInfo/s:binding[@name='thing']/s:uri"></xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="currentPageType" select="'map'" tunnel="yes"/>
		</xsl:apply-templates>
	</xsl:template>
	
	
	<xsl:template name="mapContent">
		<xsl:param name="objectInfo" tunnel="yes"/>
		<xsl:param name="data" tunnel="yes"/>
		<xsl:param name="title"/>
		<div class="well well-sm" id="datanav" style="position: fixed; width: 100%;">
			<h1><xsl:copy-of select="$title"/></h1>
			<a class="btn btn-primary" role="button" href="#links">Links</a>
			<a class="btn btn-primary" role="button" href="#metadata">Metadata</a>
		</div>
		<xsl:apply-templates select="$data" mode="table">
			<xsl:with-param name="location" select="'center'"/>
		</xsl:apply-templates>
		
		<!-- Stats blocks -->
		<xsl:call-template name="basicMetadataTable">
			<xsl:with-param name="uri" select="$objectInfo/s:binding[@name='thing']/s:uri"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
