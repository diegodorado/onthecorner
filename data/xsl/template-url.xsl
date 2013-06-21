<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="text" omit-xml-declaration="yes" encoding="utf-8" indent="no"/>

  <xsl:template match="/">
    <xsl:value-of select="/atom:feed/atom:entry/atom:link[@rel='edit']/@href"/>
  </xsl:template>
</xsl:stylesheet>
