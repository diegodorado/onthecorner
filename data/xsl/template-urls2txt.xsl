<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="text" omit-xml-declaration="yes" encoding="utf-8" indent="no"/>

  <xsl:template match="/atom:feed">
    <xsl:for-each select="atom:entry">
      <xsl:variable name="url" select="atom:link[@rel = 'alternate' and @type = 'text/html']/@href"/>
      <xsl:value-of select="substring-before(substring-after($url,'http://'),'.blogspot.com/')"/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select="atom:link[@rel = 'http://schemas.google.com/blogger/2008#template']/@href"/>
      <xsl:text>&#x0a;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="text()|@*"/>

</xsl:stylesheet>
