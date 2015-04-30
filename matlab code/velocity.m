function v = velocity( x1, y1, x2, y2 )
%Velocity of eye movement from point (x1,y1) to point (x2, y2)

v = distance( x1, y1, x2, y2 ) / 0.001;

end

