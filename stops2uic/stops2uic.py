#!/usr/bin/env python3

from csv import reader
from urllib.request import urlopen, Request
import json
import sys

api='https://api.entur.io/stop-places/v1/graphql'

query="""
    query StopPlace($id:String) {
        stopPlace(id:$id) {
            id
            keyValues {key values}
            ... on ParentStopPlace {
                children {
                    id
                    keyValues {key values}
                }
            }
        }  
    }
"""

headers={
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Et-Client-Name': 'Entur - stops2uic'
}

if len(sys.argv) < 3:
    sys.exit('Usage: ./stops2uic.py <in_file> <out_file>')

in_file = sys.argv[1]
out_file = sys.argv[2]

out_file_stream = open(out_file, 'a')

def process_row(row):
    mapping_id = row[0]
    netex_id = mapping_id

    if netex_id.startswith('NSR:Quay:'):
        netex_id = row[9]

    request_data = get_request_data(netex_id)
    httprequest = Request(
        api,
        data=request_data,
        headers=headers,
        method='POST'
    )
    with urlopen(httprequest) as response:
        data = json.loads(response.read().decode())['data']
        process_stop_place_data(data, netex_id, mapping_id)

def get_request_data(stop_place_id):
    return bytes(
        json.dumps(
            {
                'query': query,
                'variables': {
                    'id': stop_place_id
                }
            }
        ),
        encoding='utf-8'
    )

def process_stop_place_data(data, stop_place_id, mapping_id):
    parent = data['stopPlace'][0]
    uic_code = None
    if parent['id'] == stop_place_id:
        uic_code = find_uic_code(stop_place_id, parent)
    elif 'children' in parent:
        uic_code = find_uic_code_in_children(stop_place_id, parent['children'])
    else:
        if mapping_id.startswith('NSR:Quay:'):
            print('Could not find stop place with id ' + stop_place_id +  ' which is parent of quay with id ' + mapping_id)
        else:
            print('Could not find stop place with id ' + stop_place_id)

    if uic_code is not None:
        write_to_file(mapping_id, uic_code)
    else:
        if mapping_id.startswith('NSR:Quay:'):
            print('Could not find uic code for stop place with id ' + stop_place_id + ' which is parent of quay with id ' + mapping_id)
        else:
            print('Could not find uic code for stop place with id ' + stop_place_id)

def find_uic_code_in_children(stop_place_id, children):
    for stop_place in children:
        if stop_place['id'] == stop_place_id:
            uic_code = find_uic_code(stop_place_id, stop_place)
            if uic_code is not None:
                return uic_code
    return None


def find_uic_code(stop_place_id, stop_place):
    if stop_place['id'] == stop_place_id:
        for keyValues in stop_place['keyValues']:
            if keyValues['key'] == 'uicCode':
                uic_code = keyValues['values'][0]
                return uic_code
    return None

def write_to_file(stop_place_id, uic_code):
    out_file_stream.write(stop_place_id + ',00' + uic_code + '\n')

with open(in_file, 'r') as read_obj:
    csv_reader = reader(read_obj)
    header = next(csv_reader)
    if header != None:
        for row in csv_reader:
            process_row(row)


out_file_stream.close()