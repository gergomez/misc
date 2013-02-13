def is_in_poly(p, poly):
    l = len(poly)
    i = 0
    cn = 0
    while i < l:
        v1 = poly[i]
        v2 = poly[(i+1)%l]
        if ((v1[1] <= p[1] and v2[1] > p[1])
         or (v1[1] > p[1] and v2[1] <= p[1])):
                # calc intersect x-coordinate of (v1->v2) with y=Py
                x = (v2[0] - v1[0])*(p[1] - v1[0])/(v2[1] - v1[1])
                if p[0] < x: # Cast rays to increasing x
                    cn += 1
        i += 1
    return cn&1  # Even outside, odd inside
