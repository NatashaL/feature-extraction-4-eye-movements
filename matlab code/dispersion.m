function D = dispersion( points )
%Calculates the dispersion of the points, based od the paper: 
%Identifying Fixations and Saccades in Eye-Tracking Protocols
%by Dario D. Salvucci and Joseph H. Goldberg
% D is the manhattan distance between the 2 points describing the rectangle
% that surrounds the points "points"

D = max(points(1,1:2:end)) - min(points(1,1:2:end)) + max(points(1,2:2:end)) - min(points(1,2:2:end));


end

