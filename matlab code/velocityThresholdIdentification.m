function result = velocityThresholdIdentification( data )
%Simple implementation of I-VT algorithm
%The result is a vector of x indices with a matching vector of y indices
%which represent the fixation points corresponding to the eye movement
%'data'
%vel is a vector, where vel(i) corresponds to the meanvelocity in the
%fixation found around ( rezx(i), rezy(i) )

dispersion1 = [];
Dispersion2 = [];
vel = [];
duration = [];
rezx = [];
rezy = [];
areaOfFixation = [];
saccadeAmplitudes = [];
acceleration = [];
decceleration = [];

velocityThreshold = 7000;
x = data(1,1:2:end);
y = data(1,2:2:end);

if size(x) ~= size(y)
    printf('hmm');
    return;
end
%vector of type of points; 1 means fixation point; 2 means saccade
%point
type = zeros(size(x));
%point to point velocity vector
ptpvelocity = zeros(size(type));

for j=1:size(x,2)-1
    ptpvelocity(j) = velocity(x(j),y(j),x(j+1),y(j+1));
    if ptpvelocity(j) > velocityThreshold
        type(j+1) = 2;
    else
        type(j+1) = 1;
    end
end

currentpoints = [];
previousfixation = [x(1) y(1)];

for j=1:size(x,2)-1
    if type(j) == 1
        currentpoints = cat(2,currentpoints,[x(j) y(j)]);
    else
        if size(currentpoints) ~= [0 0] & size(currentpoints) ~= [1 2]
            midx = mean(currentpoints(1,1:2:end));
            midy = mean(currentpoints(1,2:2:end));
            currentpoints = [];
            rezx = cat(2,rezx,[midx]);
            rezy = cat(2,rezy,[midy]);
            [meanVel,a,b] = velocityStats(currentpoints);
            vel = cat(2,vel,meanVel);
            duration = cat(2,duration,size(currentpoints,2)/2);
            dispersion1 = cat(2,dispersion1,dispersion(currentpoints));
            Dispersion2 = cat(2,Dispersion2,dispersion2(currentpoints));
            
            X = currentpoints(1,1:2:end);
            Y = currentpoints(1,2:2:end);
            k = convhull(X,Y);
            area = polyarea(X(k),Y(k));

            areaOfFixation = cat(2,areaOfFixation, [area]);
            
            %%% the saccade = the distance between last point of previous
            %%% fixation and the first point of current fixation

            lastx = previousfixation(size(previousfixation,2) - 1);
            lasty = previousfixation(size(previousfixation,2));

            firstx = currentpoints(1);
            firsty = currentpoints(2);
            saccade = distance(lastx, lasty, firstx, firsty);
            saccadeAmplitudes = cat(2,saccadeAmplitudes,[saccade]);
            prevoiusfixation = currentpoints;
            
            %%% process saccade points
            if fixationend == 1
                fixationend = i + windowsize*2;
                continue;
            end

            saccadepoints = data(1,fixationend:(i - 1));
            [acc,decc] = getAccelerationAndDecceleration(saccadepoints,meanVel);
            acceleration = cat(2,acceleration,[acc]);
            decceleration = cat(2,decceleration,[decc]);

            saccadeduration = i - fixationend;

            fixationend = i + windowsize*2;
            
        end
    end
end

result = getAttrInStruct(rezx,rezy,dispersion1,Dispersion2,duration,vel,areaOfFixation,saccadeAmplitudes,acceleration,decceleration);


end

