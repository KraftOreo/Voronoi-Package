# Usage for the voronoi 3D 
## Contents
This package contains 6 files:

1. Voronoi_3D.m
2. centroid.m
3. faceinbound.m
4. intersectionfordouble.m
5. max_dist.m
6. cvt.m

### Voronoi_3D.m
This file is to generate the 3D voronoi grains in a given bound, namely the shape of the object and export the positional information to excel.
### centroid.m
This is a function to calculate the centroid of a ploygon given the boundry of all vertices
### faceinbound.m & intersectionfordouble.m
They are the basic functions imported by centroid.m. No need to change them.
### max_dist.m
This is to calculate the max distance between two bijective group of points.
### cvt.m
This is the main function. With this we can generate the 3D voronoi structure with given seeds and rearrange them to a quasi-uniform distribution. 