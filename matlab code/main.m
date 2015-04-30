% This is the main script that needs to be executed in order to extract the
% features from the raw dataset 'train.csv' under the folder 'datasets', to a
% file 'train.arff' under the folder 'extracted_features'

fprintf('Loading the dataset ... \n');
lines = csvread('../datasets/train_short.csv');
fprintf('Dataset loaded. \n');
fprintf('Extracting features... \n');

subject = lines(:,1);    
isRecognized = lines(:,2);
lines = lines(:,3:end);

lines = projectStartToOrigin(lines);
lines = reflectionOverXAxis(lines);

ATTR = [];
for i = 1 : size(lines,1)
    attributes = getAttributes(lines(i,:),isRecognized(i),subject(i));
    ATTR = cat(2,ATTR,attributes);
    i;
end
fprintf('Extracting finished. \n');

fprintf('Creating .arff file ... \n');
toArff(ATTR,'../extracted_features/train_short.arff');
fprintf('Done! \n');
