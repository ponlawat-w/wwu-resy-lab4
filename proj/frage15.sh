#!/bin/bash

# Define variables

units='mm'

original1='7.595940 51.969210'
proj1_2008='7.5959400243 51.9692100003'
proj1_1988='7.5959327770 51.9692094341'

original2='29.004432 41.020935'
proj2_2008='29.0044320105 41.0209350026'
proj2_1988='29.0044267057 41.0209352612'

# Run `invgeod` to calculate geodesic distance

result1_2008=$(echo $original1 $proj1_2008 | invgeod +ellps=GRS80 +units=${units})
result1_1988=$(echo $original1 $proj1_1988 | invgeod +ellps=GRS80 +units=${units})
result2_2008=$(echo $original2 $proj2_2008 | invgeod +ellps=GRS80 +units=${units})
result2_1988=$(echo $original2 $proj2_1988 | invgeod +ellps=GRS80 +units=${units})

# Format result (keep only last number of each result)

distance1_2008=$(echo $result1_2008 | rev | cut -d " " -f1 | rev)
distance1_1988=$(echo $result1_1988 | rev | cut -d " " -f1 | rev)
distance2_2008=$(echo $result2_2008 | rev | cut -d " " -f1 | rev)
distance2_1988=$(echo $result2_1988 | rev | cut -d " " -f1 | rev)

# Display result

echo "Distance of GEO 1 south-east corner between ITRF 2014, 2008 = ${distance1_2008}${units}"
echo "Distance of GEO 1 south-east corner between ITRF 2014, 1988 = ${distance1_1988}${units}"
echo "Distance of Kiz Kulesi (Maiden Tower) between ITRF 2014, 2008 = ${distance2_2008}${units}"
echo "Distance of Kiz Kulesi (Maiden Tower) between ITRF 2014, 1988 = ${distance2_1988}${units}"
