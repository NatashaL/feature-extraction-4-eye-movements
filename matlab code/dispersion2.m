function D = dispersion2( points )
%Calculates the dispersion of a set of points as the mean distance of each
%point from the center of the cluster.

x = points(1,1:2:end);
y = points(1,2:2:end);

midx = mean(x);
midy = mean(y);
d = [];
%size(points)

%size(x)
%size(y)

for i=1:size(x,2)
    d(1,i) = distance(x(1,i),y(1,i),midx,midy);
end
D = mean(d);

end

