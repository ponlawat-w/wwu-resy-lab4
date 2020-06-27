#!/bin/bash -x

# Frage 11

# Task 2

## GEO1:2014->2008
echo 7.595940 51.969210 107 | cct +proj=pipeline \
  +step +proj=cart +ellps=GRS80 \
  +step +proj=helmert \
    +convention=position_vector \
    +x=.0016 +y=.0019 +z=.0024 \
    +rx=.0 +ry=.0 +rz=.0 \
    +s=-.00002 \
  +step +inv +proj=cart +ellps=GRS80
### 7.5959400243 51.9692100003 107.0029

## GEO1:2014->1988
echo 7.595940 51.969210 107 | cct +proj=pipeline \
  +step +proj=cart +ellps=GRS80 \
  +step +proj=helmert \
    +convention=position_vector \
    +x=.0254 +y=-.5 +z=-.1548 \
    +rx=.0001 +ry=.0 +rz=.00026 \
    +s=.01129 \
  +step +inv +proj=cart +ellps=GRS80
### 7.5959327770 51.9692094341 106.9247

## MAIDEN:2014->2008
echo 29.004432 41.020935 37.3 | cct +proj=pipeline \
  +step +proj=cart +ellps=GRS80 \
  +step +proj=helmert \
    +convention=position_vector \
    +x=.0016 +y=.0019 +z=.0024 \
    +rx=.0 +ry=.0 +rz=.0 \
    +s=-.00002 \
  +step +inv +proj=cart +ellps=GRS80
### 29.0044320105 41.0209350026 37.3032

## MAIDEN:2014->1988
echo 29.004432 41.020935 37.3 | cct +proj=pipeline \
  +step +proj=cart +ellps=GRS80 \
  +step +proj=helmert \
    +convention=position_vector \
    +x=.0254 +y=-.5 +z=-.1548 \
    +rx=.0001 +ry=.0 +rz=.00026 \
    +s=.01129 \
  +step +inv +proj=cart +ellps=GRS80
### 29.0044267057 41.0209352612 37.1042
