function result = getAttributes(rawdata,rec,class)
%Takes the raw data and calls all other methods that derive the features
%needed. It returns those results into Struct objects.

%delete ending zeros
eend = size(rawdata,2);
for i = size(rawdata,2)-1:-2:1
    if rawdata(1,i) == 0 & rawdata(1,i+1) == 0
        eend = eend - 2;
    end
end
rawdata = rawdata(1,1:eend);
%end delete ending zeros

d1result = dispersionThresholdIdentification(rawdata);
d2result = dispersionThresholdIdentification2(rawdata);
vresult = velocityThresholdIdentification(rawdata);

%%%areaOfMovement

X = rawdata(1,1:2:end);
Y = rawdata(1,2:2:end);
k = convhull(X,Y);
area = polyarea(X(k),Y(k));

%%%

result = struct;
result.class = sprintf('s%d',class);
result.recognized = rec;
result.sampleLength = size(rawdata,2);               
result.sampleArea = area;

fields = fieldnames(d1result);

for i=1:numel(fields)
  result = setfield(result,char(strcat('d1',fields(i))),d1result.(fields{i}));
end

fields = fieldnames(d2result);

for i=1:numel(fields)
  result = setfield(result,char(strcat('d2',fields(i))),d1result.(fields{i}));
end

fields = fieldnames(vresult);

for i=1:numel(fields)
  result = setfield(result,char(strcat('v',fields(i))),d1result.(fields{i}));
end


end

