<xsl:transform version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:output indent="yes" encoding="UTF-8"/>

  <xsl:variable name="prefix" select="'RUT'" />


  <xsl:template match="/">
    <PublicationDelivery xmlns="http://www.netex.org.uk/netex">
      <PublicationTimestamp>
        <xsl:value-of select="current-dateTime()"/>
      </PublicationTimestamp>
      <ParticipantRef><xsl:value-of select="$prefix"/></ParticipantRef>
      <Description>
        <xsl:value-of select="kml:kml/kml:Document/kml:Folder/kml:description" />
      </Description>
      <dataObjects>
        <SiteFrame version="1">
          <xsl:attribute name="id">
            <xsl:value-of disable-output-escaping="yes" select="concat($prefix, ':SiteFrame:1')"/>
          </xsl:attribute>
          <tariffZones>
            <xsl:for-each select="kml:kml/kml:Document/kml:Folder/kml:Placemark">
              <TariffZone version="1">
                <xsl:attribute name="id">
                  <xsl:value-of disable-output-escaping="yes" select="concat($prefix, ':TariffZone:',kml:name)"/>
                </xsl:attribute>
                <Name>
                  <xsl:value-of disable-output-escaping="yes" select="kml:name"/>
                </Name>
                <Description>
                  <xsl:value-of select="@id"/>
                </Description>
                <gml:Polygon xmlns:gml="http://www.opengis.net/gml/3.2" srsName="EPSG:4326" srsDimension="2">
                  <xsl:attribute name="gml:id">
                    <xsl:value-of disable-output-escaping="yes" select="concat($prefix, position())"/>
                  </xsl:attribute>
                  <gml:exterior>
                    <gml:LinearRing>
                      <gml:posList>
                        <xsl:call-template name="polygon"/>
                      </gml:posList>
                    </gml:LinearRing>
                  </gml:exterior>
                </gml:Polygon>
              </TariffZone>
            </xsl:for-each>
          </tariffZones>
        </SiteFrame>
      </dataObjects>
    </PublicationDelivery>
  </xsl:template>

  <xsl:template match="/kml:MultiGeometry/kml:Polygon/kml:outerBoundaryIs/kml:LinearRing/kml:coordinates" name="polygon">
    <xsl:for-each select="kml:MultiGeometry/kml:Polygon/kml:outerBoundaryIs/kml:LinearRing/kml:coordinates">
      <xsl:value-of disable-output-escaping="yes" select="fn:replace(., '(\d+\.\d+),(\d+\.\d+),0\s?', '$2 $1 ')"/>
    </xsl:for-each>
  </xsl:template>
</xsl:transform>
