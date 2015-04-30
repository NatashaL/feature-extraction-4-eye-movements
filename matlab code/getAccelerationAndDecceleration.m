function [acc,decc] = getAccelerationAndDecceleration( saccadePoints, vel )
% Calculates the acceleration and decceleration of the movement described
% with the points in 'saccadePoints' parameter.

n = size(saccadePoints,2)/2;

acc = [];
decc = [];
for i = 3:2:size(saccadePoints,2)
    
    x1 = saccadePoints(1,i-2);
    y1 = saccadePoints(1,i-1);
    
    x2 = saccadePoints(1,i);
    y2 = saccadePoints(1,i+1);
    
    d = distance(x1,y1,x2,y2);
    
    acc = (d - vel * 0.001)/(0.001 * 0.001);
    
    if acc > 0
        acc = cat(2,acc, [acc]);
    else
        decc = cat(2,decc,[acc]);
    end
    
    
    vel = (vel * n + velocity(x1,y1,x2,y2))/(n + 1);
    n = n + 1;

end

end

