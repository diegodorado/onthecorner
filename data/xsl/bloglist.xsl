<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="text" omit-xml-declaration="yes" encoding="utf-8" indent="no"/>

  <xsl:template match="//atom:entry/atom:link[@rel='alternate' and @type='text/html']">
    <xsl:value-of select="@href"/>
    <xsl:text>&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template match="text()|@*"/>
</xsl:stylesheet>
