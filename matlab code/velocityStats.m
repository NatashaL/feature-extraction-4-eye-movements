function [meann, maxx, minn] = velocityStats( points )
% Calculates the velocities between each pair (x(i),y(i)) (x(i+1),y(i+1))
% of consective points, and finds their mean value.

meann = [];
maxx = -999999;
minn = 999999;
for i = 1:2:size(points,2)-2
    v = velocity(points(i),points(i+1),points(i+2),points(i+3));
    meann = cat(2,meann,[v]);
    maxx = max(maxx,v);
    minn = min(minn,v);
end
meann = mean(meann);
end

