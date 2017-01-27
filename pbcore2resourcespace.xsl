<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:pbc="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" xsi:schemaLoaction="http://www.pbcore.org/PBCore/PBCoreNamespace.html" exclude-result-prefixes="pbc">
  <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
  <xsl:template match="//pbc:pbcoreDescriptionDocument">
    <resourceset>
      <resource>
        <xsl:attribute name="type">3</xsl:attribute>
        <keyfield>
          <xsl:attribute name="ref">8</xsl:attribute>
          <xsl:value-of select="$id"/>
        </keyfield>
        <!-- collectionid comes from an xsltproc stringparam -->
        <xsl:if test="$collectionid">
          <collection>
            <xsl:value-of select="$collectionid"/>
          </collection>
        </xsl:if>
        <field>
          <xsl:attribute name="ref">78</xsl:attribute>
          <!-- identifiers -->
          <xsl:for-each select="pbc:pbcoreIdentifier">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="@source"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">77</xsl:attribute>
          <!-- assettype -->
          <xsl:for-each select="pbc:pbcoreAssetType">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">93</xsl:attribute>
          <!-- coverage -->
          <xsl:for-each select="pbc:pbcoreCoverage">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="@coverageType"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">82</xsl:attribute>
          <!-- dates -->
          <xsl:for-each select="pbc:pbcoreAssetDate">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="@dateType"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">73</xsl:attribute>
          <!-- title series -->
          <xsl:value-of select="pbc:pbcoreTitle[@titleType='Series']|pbc:pbcoreTitle[@titleType='Program']"/>
        </field>
        <field>
          <xsl:attribute name="ref">76</xsl:attribute>
          <!-- title episode -->
          <xsl:value-of select="pbc:pbcoreTitle[@titleType='Episode']"/>
        </field>
        <field>
          <xsl:attribute name="ref">111</xsl:attribute>
          <!-- titles -->
          <xsl:for-each select="pbc:pbcoreTitle">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="@titleType"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">84</xsl:attribute>
          <!-- descriptions -->
          <xsl:for-each select="pbc:pbcoreDescription">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="@descriptionType"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">86</xsl:attribute>
          <!-- creators -->
          <xsl:for-each select="pbc:pbcoreCreator">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="pbc:creator"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="@creatorRole"/>
            <!-- is this right -->
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">90</xsl:attribute>
          <!-- contributors -->
          <xsl:for-each select="pbc:pbcoreContributor">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="pbc:contributor"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="pbc:contributor/@affiliation"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="pbc:contributorrRole"/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">91</xsl:attribute>
          <!-- publishers -->
          <xsl:for-each select="pbc:pbcorePublisher">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="pbc:publisher"/>
            <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="pbc:publisherRole"/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
        <field>
          <xsl:attribute name="ref">116</xsl:attribute>
          <!-- instantiations -->
          <xsl:for-each select="pbc:pbcoreInstantiation">
            <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text>
            <xsl:value-of select="pbc:instantiationIdentifier[@source='Material ID']"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="pbc:instantiationTimeStart"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="pbc:instantiationDuration"/>
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
          </xsl:for-each>
        </field>
      </resource>
    </resourceset>
  </xsl:template>
</xsl:stylesheet>
