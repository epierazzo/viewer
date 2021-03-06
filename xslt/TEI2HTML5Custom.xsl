<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="xs t"
  version="2.0">
  <xsl:output indent="no" omit-xml-declaration="yes" method="xml"/>
  <xsl:param name="base"></xsl:param><!-- http://digitallatin.github.io/viewer/ -->
  <xsl:include href="DLL-viewer.xsl"/>
  
  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
    <html>
      <head>
        <link rel="stylesheet" href="{$base}css/tei-html.css"/>
        <link rel="stylesheet" href="{$base}js/jquery-ui-1.11.4.custom/jquery-ui.css"/>
        <script type="text/javascript" src="{$base}js/elements.js"></script>
        <script type="text/javascript">
          if (document.registerElement) {
            TEI_CE.registerAll(["<xsl:value-of select="string-join(distinct-values(//*/local-name()), '&quot;,&quot;')"/>"]);
          }
        </script>
        <script type="text/javascript" src="{$base}js/jquery/jquery-1.11.3.js"></script>
        <script type="text/javascript" src="{$base}js/jquery-ui-1.11.4.custom/jquery-ui.js"></script>
        <script type="text/javascript" src="{$base}js/appcrit.js"></script>
      </head>
      <body>
        <xsl:call-template name="front"/>
        <xsl:apply-templates/>
        <xsl:call-template name="back"/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="*" xml:space="preserve"><xsl:element name="tei-{local-name(.)}"><xsl:apply-templates select="@*"/><xsl:apply-templates select="node()"/></xsl:element></xsl:template>
  
  <xsl:template match="*[@n and not(@xml:id)]"><xsl:element name="tei-{local-name(.)}"><xsl:apply-templates select="@*"/><xsl:attribute name="id"></xsl:attribute><xsl:apply-templates select="node()"/></xsl:element></xsl:template>
    
  <xsl:template match="@xml:id">
    <xsl:copy/>
    <xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@xml:lang">
    <xsl:copy/>
    <xsl:attribute name="lang"><xsl:value-of select="."/></xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@xml:space">
    <xsl:copy/>
    <xsl:attribute name="xml-space"><xsl:value-of select="."/></xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@*">
    <xsl:copy-of select="."></xsl:copy-of>
  </xsl:template>
  
</xsl:stylesheet>