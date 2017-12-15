echo "---------------- import merge ------------------------"

echo Flytoget
curl -H "Content-Type: application/xml" -XPOST -d@Flytoget_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?importType=MERGE&skipOutput=true" &&

echo Ostfold
curl -H "Content-Type: application/xml" -XPOST -d@Ostfold_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:01&importType=MERGE&skipOutput=true" &&

echo Ruter
curl -H "Content-Type: application/xml" -XPOST -d@Ruter_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:02&onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:03&importType=MERGE&skipOutput=true" &&

echo Hedmark
curl -H "Content-Type: application/xml" -XPOST -d@Hedmark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:04&importType=MERGE&skipOutput=true" &&

echo Oppland
curl -H "Content-Type: application/xml" -XPOST -d@Oppland_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:05&importType=MERGE&skipOutput=true" &&

echo Brakar
curl -H "Content-Type: application/xml" -XPOST -d@Brakar_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:06&importType=MERGE&skipOutput=true" &&

echo Vestfold
curl -H "Content-Type: application/xml" -XPOST -d@Vestfold_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:07&importType=MERGE&skipOutput=true" &&

echo Telemark
curl -H "Content-Type: application/xml" -XPOST -d@Telemark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:08&importType=MERGE&skipOutput=true" &&

echo Agder
curl -H "Content-Type: application/xml" -XPOST -d@Agder_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:09&onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:10&importType=MERGE&skipOutput=true" &&

echo Kolumbus
curl -H "Content-Type: application/xml" -XPOST -d@Kolumbus_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:11&importType=MERGE&skipOutput=true" &&

echo Skyss
curl -H "Content-Type: application/xml" -XPOST -d@Skyss_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:12&importType=MERGE&skipOutput=true" &&

echo SOF
curl -H "Content-Type: application/xml" -XPOST -d@SognOgFjordane_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:14&importType=MERGE&skipOutput=true" &&

echo MOR
curl -H "Content-Type: application/xml" -XPOST -d@MoreOgRomsdal_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:15&importType=MERGE&skipOutput=true" &&

echo ATB
curl -H "Content-Type: application/xml" -XPOST -d@Atb_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:16&importType=MERGE&skipOutput=true" &&

echo NordTrøndelag
curl -H "Content-Type: application/xml" -XPOST -d@NordTrondelag_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:17&importType=MERGE&skipOutput=true" &&

echo Nordland
curl -H "Content-Type: application/xml" -XPOST -d@Nordland_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:18&importType=MERGE&skipOutput=true" &&

echo Troms
curl -H "Content-Type: application/xml" -XPOST -d@Troms_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:19&importType=MERGE&skipOutput=true" &&

echo Finnmark
curl -H "Content-Type: application/xml" -XPOST -d@Finnmark_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?onlyMatchOutsideTopographicPlaces=KVE:TopographicPlace:20&onlyMatchOutsideTopographicPlaces=WOF:TopographicPlace:85632685&onlyMatchOutsideTopographicPlaces=WOF:TopographicPlace:85633143&importType=MERGE&skipOutput=true"

#echo NRI
#curl -H "Content-Type: application/xml" -XPOST -d@NRI_Netex.xml_Enriched.xml "http://localhost:1997/services/stop_places/netex?importType=MERGE&skipOutput=true"
