<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html http://pbcore.org/xsd/pbcore-2.0.xsd">
<xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
  <xsl:template match="temp_pbcore">
    <pbcoreDescriptionDocument>

      <!-- assess outcomes for assetTypes and titleTypes -->
      <xsl:variable name="assetType">
        <xsl:choose>
          <xsl:when test="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='asset_type']/preceding-sibling::*)+1]='P'">Program</xsl:when>
          <xsl:otherwise>Episode</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="primaryTitleType">
        <xsl:choose>
          <xsl:when test="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='asset_type']/preceding-sibling::*)+1]='P'">Program</xsl:when>
          <xsl:otherwise>Series</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="secondaryTitleType">
        <xsl:choose>
          <xsl:when test="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='asset_type']/preceding-sibling::*)+1]='P'">Subtitle</xsl:when>
          <xsl:otherwise>Episode</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      
      <!-- assetTypes -->
      <pbcoreAssetType>
        <xsl:value-of select="$assetType"/>
      </pbcoreAssetType>
      
      <!-- identifiers -->
      <xsl:call-template name="identifier">
        <xsl:with-param name="identifier" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='vsn_serial']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="source">vsn_serial</xsl:with-param>
        <xsl:with-param name="annotation">protrack</xsl:with-param>
      </xsl:call-template>

      <!-- titles -->
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='series_title']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType" select="$primaryTitleType"/>
      </xsl:call-template>
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='episode_title']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType" select="$secondaryTitleType"/>
      </xsl:call-template>
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='series_title_cap']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType" select="$primaryTitleType"/>
        <xsl:with-param name="titleTypeAnnotation">Uppercase Formatting</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="title">
        <xsl:with-param name="title" select="table[@note='titles']/tr[2]/td[count(../../tr[1]/th[.='episode_title_cap']/preceding-sibling::*)+1]"/>
        <xsl:with-param name="titleType" select="$secondaryTitleType"/>
        <xsl:with-param name="titleTypeAnnotation">Uppercase Formatting</xsl:with-param>
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
          <!-- todo: remove the last occurrence of the above space -->
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
          <!-- todo: remove the last occurrence of the above space -->
        </xsl:for-each>
      </xsl:variable>
      <xsl:call-template name="description">
        <xsl:with-param name="description" select="$catdescription_series"/>
        <xsl:with-param name="descriptionType">Series</xsl:with-param>
      </xsl:call-template>

      <!-- instantiations -->
      <xsl:for-each select="table[@note='linkinfo']/tr">
        <xsl:call-template name="instantiation">
          <xsl:with-param name="timestart" select="td[count(../../tr[1]/th[.='timestart']/preceding-sibling::*)+1]"/>
          <xsl:with-param name="duration" select="td[count(../../tr[1]/th[.='duration']/preceding-sibling::*)+1]"/>
          <xsl:with-param name="material_id" select="td[count(../../tr[1]/th[.='material_id']/preceding-sibling::*)+1]"/>
          <xsl:with-param name="use_for_air" select="td[count(../../tr[1]/th[.='use_for_air']/preceding-sibling::*)+1]"/>
          <xsl:with-param name="air_reason" select="td[count(../../tr[1]/th[.='air_reason']/preceding-sibling::*)+1]"/>
        </xsl:call-template>
      </xsl:for-each>

    </pbcoreDescriptionDocument>
  </xsl:template>
  <xsl:template name="identifier">
    <xsl:param name="identifier"/>
    <xsl:param name="source"/>
    <xsl:param name="annotation"/>
    <xsl:param name="ref"/>
    <xsl:if test="$identifier!=''">
      <pbcoreIdentifier>
        <xsl:if test="$source!=''">
          <xsl:attribute name="source">
            <xsl:value-of select="$source"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="$ref!=''">
          <xsl:attribute name="ref">
            <xsl:value-of select="$ref"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="$annotation!=''">
          <xsl:attribute name="annotation">
            <xsl:value-of select="$annotation"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="$source!=''">
          <xsl:attribute name="source">
            <xsl:value-of select="$source"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="$identifier"/>
      </pbcoreIdentifier>
    </xsl:if>
  </xsl:template>
  <xsl:template name="title">
    <xsl:param name="title"/>
    <xsl:param name="titleType"/>
    <xsl:param name="titleTypeAnnotation"/>
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
        <xsl:if test="$titleTypeAnnotation!=''">
          <xsl:attribute name="titleTypeAnnotation">
            <xsl:value-of select="$titleTypeAnnotation"/>
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
  <xsl:template name="instantiation">
    <xsl:param name="timestart"/>
    <xsl:param name="duration"/>
    <xsl:param name="material_id"/>
    <xsl:param name="use_for_air"/>
    <xsl:param name="air_reason"/>
    <xsl:if test="$material_id!=''">
      <pbcoreInstantiaion>
        <instantiationIdentifier>
          <xsl:attribute name="identifierSource">Material ID</xsl:attribute>
          <xsl:value-of select="$material_id"/>
        </instantiationIdentifier>
        <xsl:if test="$timestart!=''">
          <instantiationTimeStart>
            <xsl:value-of select="$timestart"/>
          </instantiationTimeStart>
        </xsl:if>
        <xsl:if test="$duration!=''">
          <instantiationDuration>
            <xsl:value-of select="$duration"/>
          </instantiationDuration>
        </xsl:if>
        <xsl:if test="$use_for_air='0'">
          <instantiationAnnotation>
            <xsl:attribute name="annotationType">accessRestriction</xsl:attribute>
            <xsl:text>Restricted</xsl:text>
          </instantiationAnnotation>
        </xsl:if>
        <xsl:if test="string-length($air_reason)>'0'">
          <instantiationAnnotation>
            <xsl:attribute name="annotationType">notes</xsl:attribute>
            <xsl:value-of select="$air_reason"/>
          </instantiationAnnotation>
        </xsl:if>
      </pbcoreInstantiaion>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
