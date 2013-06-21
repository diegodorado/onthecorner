<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="xml" omit-xml-declaration="no" encoding="utf-8" indent="no"/>

  <xsl:template match="/">
    <xsl:apply-templates select="atom:feed/atom:entry"/>
  </xsl:template>

  <xsl:template match="atom:content">
    <xsl:copy>
      <xsl:value-of select="document($templatefile)/content"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="processing-instruction()|comment()"/>
</xsl:stylesheet>
