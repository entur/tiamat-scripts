# Transform kml to netex tariff zones

Transforms the kml to a netex publication delivery with tariff zones.
Swaps x/y from polygon and removed third dimension.

Run with saxon:
```
saxon -s:doc.kml -xsl:transformation.xsl -o:output.xml
```

Validate with xmllint:
```
xmllint --noout --schema /path/to/netex/schema/xsd/NeTEx_publication.xsd output.xml
```
