function lines = reflectionOverXAxis( lines )
% transforming the points from the input by mirroring them by the X axis

for i = 1 : size(lines,1)
   for j = 2 : size(lines,2)
       lines(i,j) = - lines(i,j);
       j = j+1;
   end
end

end

