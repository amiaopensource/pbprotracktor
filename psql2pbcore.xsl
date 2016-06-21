<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html http://pbcore.org/xsd/pbcore-2.0.xsd">
<xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
  <xsl:template match="temp_pbcore">
    <pbcoreDescriptionDocument>

      <pbcoreAssetType>
        <xsl:choose>
          <xsl:when test="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='asset_type']/preceding-sibling::*)+1]='P'">
            <xsl:text>Program</xsl:text>
          </xsl:when>
          <xsl:otherwise>Episode</xsl:otherwise>
        </xsl:choose>
      </pbcoreAssetType>

      <!-- titles -->
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='series_title']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType">Series</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='episode_title']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType">Episode</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='series_title_cap']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType">Series (ALL CAPS)</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='episode_title_cap']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType">Episode (ALL CAPS)</xsl:with-param>
      </xsl:call-template>

      <!-- descriptions -->
      <xsl:for-each select="table[@note='proguide']/tr">
        <xsl:call-template name="description">
          <xsl:with-param name="description" select="td[count(../../tr[1]/th[.='description']/preceding-sibling::*)+1]"/>
          <xsl:with-param name="descriptionType" select="td[count(../../tr[1]/th[.='descriptiontype']/preceding-sibling::*)+1]"/>
        </xsl:call-template>
      </xsl:for-each>

      <xsl:variable name="catdescription_version">
        <xsl:for-each select="table[@note='progdesc_version']/tr/td[count(../../tr/th[.='description']/preceding-sibling::*)+1]">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:call-template name="description">
        <xsl:with-param name="description" select="$catdescription_version"/>
        <xsl:with-param name="descriptionType">Version</xsl:with-param>
      </xsl:call-template>

      <xsl:variable name="catdescription_series">
        <xsl:for-each select="table[@note='progdesc_series']/tr/td[count(../../tr/th[.='description']/preceding-sibling::*)+1]">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:call-template name="description">
        <xsl:with-param name="description" select="$catdescription_series"/>
        <xsl:with-param name="descriptionType">Series</xsl:with-param>
      </xsl:call-template>

    </pbcoreDescriptionDocument>
  </xsl:template>
  <xsl:template name="title">
    <xsl:param name="title"/>
    <xsl:param name="titleType"/>
    <xsl:param name="ref"/>
    <xsl:param name="source"/>
    <xsl:if test="$title!=''">
      <pbcoreTitle>
        <xsl:if test="$titleType!=''">
          <xsl:attribute name="titleType">
            <xsl:value-of select="$titleType"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="$ref!=''">
          <xsl:attribute name="ref">
            <xsl:value-of select="$ref"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="$source!=''">
          <xsl:attribute name="source">
            <xsl:value-of select="$source"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="$title"/>
      </pbcoreTitle>
    </xsl:if>
  </xsl:template>
  <xsl:template name="description">
    <xsl:param name="description"/>
    <xsl:param name="descriptionType"/>
    <xsl:param name="ref"/>
    <xsl:param name="source"/>
    <xsl:if test="$description!=''">
      <pbcoreDescription>
        <xsl:if test="$descriptionType!=''">
          <xsl:attribute name="descriptionType">
            <xsl:value-of select="$descriptionType"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="$ref!=''">
          <xsl:attribute name="ref">
            <xsl:value-of select="$ref"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="$source!=''">
          <xsl:attribute name="source">
            <xsl:value-of select="$source"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="$description"/>
      </pbcoreDescription>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
