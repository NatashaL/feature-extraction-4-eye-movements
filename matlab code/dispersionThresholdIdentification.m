function result = dispersionThresholdIdentification( data )
%Simple implementation of I-DT algorithm
%The result is a vector of x indices with a matching vector of y indices
%which represent the fixation points corresponding to the eye movement
%'data'
%DISP is a vector, where DISP(i) corresponds to the dispersion in the
%fixation found around ( rezx(i) , rezy(i) )

Dispersion = [];
Dispersion2 = [];
duration = [];
rezx = [];
rezy = [];
areaOfFixation = [];
velocity = [];
saccadeAmplitudes = [];
acceleration = [];
decceleration = [];

dispersionThreshold = 50;
minwindowsize = 70;

x = data(1,1:2:end);
y = data(1,2:2:end);

if size(x) ~= size(y)
    printf('hmm');
    return;
end

i = 1;

previousfixation = [x(1) y(1)];
fixationend = 1;

while i + minwindowsize*2 <= size(data,2)
    windowsize = minwindowsize;
    currentpoints = data(1,i:i+windowsize*2 - 1);
    
    disp = dispersion(currentpoints);
    while (disp < dispersionThreshold) & (i + windowsize*2) < size(data,2) - 1
        windowsize = windowsize + 1;
        currentpoints = data(1,i:i+windowsize*2 - 1);
        disp = dispersion(currentpoints);
    end
    
    if windowsize <= minwindowsize
        i = i + 2;
        continue 
    else
        %%% the fixation
        
        xx = mean(currentpoints(1:2:end-2));
        yy = mean(currentpoints(2:2:end-2));
        rezx = cat(2,rezx,[xx]);
        rezy = cat(2,rezy,[yy]);
        Dispersion = cat(2,Dispersion,[disp]);
        duration = cat(2,duration,size(currentpoints,2)/2);
        [meanVel,a,b] = velocityStats(currentpoints);
        velocity = cat(2,velocity,[meanVel]);
        Dispersion2 = cat(2,Dispersion2,dispersion2(currentpoints));
        
        X = currentpoints(1,1:2:end);
        Y = currentpoints(1,2:2:end);
        k = convhull(X,Y);
        area = polyarea(X(k),Y(k));
        
        areaOfFixation = cat(2,areaOfFixation, [area]);
        
        i = i + windowsize * 2;
        
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


result = getAttrInStruct(rezx,rezy,Dispersion,Dispersion2,duration,velocity,areaOfFixation,saccadeAmplitudes,acceleration,decceleration );

end

