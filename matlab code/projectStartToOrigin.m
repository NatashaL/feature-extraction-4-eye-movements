function REZ = projectStartToOrigin(data)
% Re-mapping all the points to the first quadrant from Descartes's system.

REZ = zeros(size(data));

for i=1:size(data,1)
    lowx = min(data(i,1:2:end));
    lowy = min(data(i,2:2:end));
    
    for j=1:2:size(data,2)-1
        
        if data(i,j) ~= 0 | data(i,j+1) ~= 0
            REZ(i,j) = data(i,j) - lowx;
        end
    end
    for j=2:2:size(data,2)-1
        if data(i,j) ~= 0 | data(i,j+1) ~= 0
            REZ(i,j) = data(i,j) - lowy;
        end
    end
    
     j = size(data,2)-1;       
     if mod(j,2) == 0
         low = lowy;
     else
         low = lowx;
     end
     if data(i,j) ~= 0
        REZ(i,j) = data(i,j) - low;
     end
end
end



