# Example from real life netex stop places import

See the scripts which were run in the following order:
* `import_base.sh`
* `import_inverse.sh`
* `import_merge.sh`

The reason for importing multiple times (base, inverse, merge) was basically because of duplicate stops from different providers.
A provider sometimes relates to a county. If a neighbour county has stops inside a county, stops should be matched. When base and inverse were executed, there were some missing stops (Stops from a neighbour county that did not exist in the county itself). So, the last stage was to execute merge. After this, some manual cleanup had to be done.
