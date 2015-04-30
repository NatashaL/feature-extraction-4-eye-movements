function result = getAttrInStruct( rezx,rezy,dispersion1,dispersion2,duration,velocity,areaOfFixation,saccadeAmplitudes,acc,decc )
%This function takes the features extracted for ONE sample, and returns
%them in a Struct object


result = struct;

result.numberOfFixations = size(rezx,2);

%numeric values

result.meanDispersion1 = mean(dispersion1);
result.maxDispersion1 = max(dispersion1);
result.minDispersion1 = min(dispersion1);

result.meanDispersion2 = mean(dispersion2);
result.maxDispersion2 = max(dispersion2);
result.minDispersion2 = min(dispersion2);

result.meanDuration = mean(duration);
result.maxDuration = max(duration);
result.minDuration = min(duration);

result.meanAreaOfFixation = mean(areaOfFixation);
result.maxAreaOfFixation = max(areaOfFixation);
result.minAreaOfFixation = min(areaOfFixation);

result.meanMeanVelocity = mean(velocity);
result.maxMeanVelocity = max(velocity);
result.minMeanVelocity = min(velocity);

result.meanSaccadeAmplitude = mean(saccadeAmplitudes);
result.maxSaccadeAmplitude = max(saccadeAmplitudes);
result.minSaccadeAmplitude = min(saccadeAmplitudes);

result.meanAcceleration = mean(acc);
result.maxAcceleration = max(acc);
result.minAcceleration = min(acc);

result.meanDecceleration = mean(decc);
result.maxDecceleration = max(decc);
result.minDecceleration = min(decc);

end

