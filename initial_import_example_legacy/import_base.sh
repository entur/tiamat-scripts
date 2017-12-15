echo "---------------- import base/initial ------------------------"

#Initial import
echo AdminNor
curl -H "Content-Type: application/xml" -XPOST -d@admin-units-from-sosi.xml "http://localhost:1997/services/stop_places/netex?importType=INITIAL&skipOutput=true" &&

echo AdminForeign
curl -H "Content-Type: application/xml" -XPOST -d@neighbouring-countries_from_geosjon.xml "http://localhost:1997/services/stop_places/netex?importType=INITIAL&skipOutput=true" &&

echo NSB
curl -H "Content-Type: application/xml" -XPOST -d@NSB_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?importType=INITIAL&skipOutput=true" &&

echo Avinor
curl -H "Content-Type: application/xml" -XPOST -d@Avinor_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?importType=INITIAL&skipOutput=true" &&

echo Østfold
curl -H "Content-Type: application/xml" -XPOST -d@Ostfold_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:01&importType=INITIAL&skipOutput=true" &&

echo Ruter
curl -H "Content-Type: application/xml" -XPOST -d@Ruter_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:02&targetTopographicPlaces=KVE:TopographicPlace:03&importType=INITIAL&skipOutput=true" &&

echo Hedmark
curl -H "Content-Type: application/xml" -XPOST -d@Hedmark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:04&targetTopographicPlaces=WOF:TopographicPlace:85633789&importType=INITIAL&skipOutput=true" &&

echo Oppland
curl -H "Content-Type: application/xml" -XPOST -d@Oppland_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:05&importType=INITIAL&skipOutput=true" &&

echo Brakar
curl -H "Content-Type: application/xml" -XPOST -d@Brakar_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:06&importType=INITIAL&skipOutput=true" &&

echo Vestfold
curl -H "Content-Type: application/xml" -XPOST -d@Vestfold_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:07&importType=INITIAL&skipOutput=true" &&

echo Telemark
curl -H "Content-Type: application/xml" -XPOST -d@Telemark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:08&importType=INITIAL&skipOutput=true" &&

echo Agder
curl -H "Content-Type: application/xml" -XPOST -d@Agder_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:09&targetTopographicPlaces=KVE:TopographicPlace:10&importType=INITIAL&skipOutput=true" &&

echo Kolumbus
curl -H "Content-Type: application/xml" -XPOST -d@Kolumbus_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:11&importType=INITIAL&skipOutput=true" &&

echo Skyss
curl -H "Content-Type: application/xml" -XPOST -d@Skyss_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:12&importType=INITIAL&skipOutput=true" &&

echo SOF
curl -H "Content-Type: application/xml" -XPOST -d@SognOgFjordane_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:14&importType=INITIAL&skipOutput=true" &&

echo MOR
curl -H "Content-Type: application/xml" -XPOST -d@MoreOgRomsdal_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:15&importType=INITIAL&skipOutput=true" &&

echo ATB
curl -H "Content-Type: application/xml" -XPOST -d@Atb_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:16&importType=INITIAL&skipOutput=true" &&

echo NordTr
curl -H "Content-Type: application/xml" -XPOST -d@NordTrondelag_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:17&targetTopographicPlaces=WOF:TopographicPlace:85633789&importType=INITIAL&skipOutput=true" &&

echo Nordla
curl -H "Content-Type: application/xml" -XPOST -d@Nordland_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:18&importType=INITIAL&skipOutput=true" &&

echo Troms
curl -H "Content-Type: application/xml" -XPOST -d@Troms_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:19&importType=INITIAL&skipOutput=true" &&

echo Finnmark
curl -H "Content-Type: application/xml" -XPOST -d@Finnmark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?targetTopographicPlaces=KVE:TopographicPlace:20&targetTopographicPlaces=WOF:TopographicPlace:85632685&targetTopographicPlaces=WOF:TopographicPlace:85633143&importType=INITIAL&skipOutput=true"
