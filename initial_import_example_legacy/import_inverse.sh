echo "---------------- import inverse ------------------------"


echo Flytoget
curl -H "Content-Type: application/xml" -XPOST -d@Flytoget_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?importType=MATCH&skipOutput=true" &&

echo Ostfold
curl -H "Content-Type: application/xml" -XPOST -d@Ostfold_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:01&importType=MATCH&skipOutput=true" &&

echo Ruter
curl -H "Content-Type: application/xml" -XPOST -d@Ruter_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:02&onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:03&importType=MATCH&skipOutput=true" &&

echo Hedmark
curl -H "Content-Type: application/xml" -XPOST -d@Hedmark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:04&importType=MATCH&skipOutput=true" &&

echo Oppland
curl -H "Content-Type: application/xml" -XPOST -d@Oppland_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:05&importType=MATCH&skipOutput=true" &&

echo Brakar
curl -H "Content-Type: application/xml" -XPOST -d@Brakar_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:06&importType=MATCH&skipOutput=true" &&

echo Vestfold
curl -H "Content-Type: application/xml" -XPOST -d@Vestfold_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:07&importType=MATCH&skipOutput=true" &&

echo Telemark
curl -H "Content-Type: application/xml" -XPOST -d@Telemark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:08&importType=MATCH&skipOutput=true" &&

echo Agder
curl -H "Content-Type: application/xml" -XPOST -d@Agder_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:09&onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:10&importType=MATCH&skipOutput=true" &&

echo Kolumbus
curl -H "Content-Type: application/xml" -XPOST -d@Kolumbus_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:11&importType=MATCH&skipOutput=true" &&

echo Skyss
curl -H "Content-Type: application/xml" -XPOST -d@Skyss_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:12&importType=MATCH&skipOutput=true" &&

echo SOF
curl -H "Content-Type: application/xml" -XPOST -d@SognOgFjordane_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:14&importType=MATCH&skipOutput=true" &&

echo MOR
curl -H "Content-Type: application/xml" -XPOST -d@MoreOgRomsdal_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:15&importType=MATCH&skipOutput=true" &&

echo ATB
curl -H "Content-Type: application/xml" -XPOST -d@Atb_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:16&importType=MATCH&skipOutput=true" &&

echo NordTrøndelag
curl -H "Content-Type: application/xml" -XPOST -d@NordTrondelag_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:17&importType=MATCH&skipOutput=true" &&

echo Nordland
curl -H "Content-Type: application/xml" -XPOST -d@Nordland_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:18&importType=MATCH&skipOutput=true" &&

echo Troms
curl -H "Content-Type: application/xml" -XPOST -d@Troms_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:19&importType=MATCH&skipOutput=true" &&

echo Finnmark
curl -H "Content-Type: application/xml" -XPOST -d@Finnmark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:20&onlyMatchOutsideTopographicPlaces=WOF:TopographicPlace:85632685&onlyMatchOutsideTopographicPlaces=WOF:TopographicPlace:85633143&importType=MATCH&skipOutput=true"
