<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#"
	xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:nie="http://www.semanticdesktop.org/ontologies/2007/01/19/nie#"
	xmlns:nfo="http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:dita="http://purl.org/dita/ns#"
	xmlns:schema="http://schema.org/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:colin="http://colin.maudry.com/"
	xmlns:doc="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:ot="http://www.idiominc.com/opentopic"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema#" exclude-result-prefixes="xs doc colin">
	
	<!-- Map specific functions -->
	<xsl:function name="colin:getKeyUri">
		<xsl:param name="documentUri"/>
		<xsl:param name="keyname"/>
		<xsl:value-of select="concat($documentUri,'/keys/',$keyname)"/>
	</xsl:function>
	
	<xsl:template match="@keys">
		<xsl:param name="documentUri" tunnel="yes"/>
		<xsl:variable name="base" select="translate(../@xtrf,'\','/')"/>
		<xsl:variable name="relative" select="../@href"></xsl:variable>
		<xsl:for-each select="tokenize(.,' ')">
			<dita:key>
				<dita:Key rdf:about="{colin:getKeyUri($documentUri,.)}">
					<dita:href rdf:resource="{resolve-uri($relative,$base)}"/>
				</dita:Key>
			</dita:key>
		</xsl:for-each>
	</xsl:template>
	<doc:doc>
		<doc:desc>Passthrough template for maps</doc:desc>
	</doc:doc>
	<xsl:template match="*[contains(@class, ' map/topicmeta ')]">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
