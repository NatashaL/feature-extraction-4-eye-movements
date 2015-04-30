function toArff( data, filename )
% create an arff file 'filename' from data
% data - struct vector

% write to arff file
fid = fopen(filename, 'wt');

fprintf(fid, '@relation emvic_1\n\n');

fields = fieldnames(data(1));
fields = fields(2:end);

for i = 1 : numel(fields)
    if strcmp('class',fields{i})
        continue
    end
    fprintf(fid, '@attribute ''%s'' NUMERIC\n', fields{i});
end

fprintf(fid, '@attribute ''class'' {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34}\n\n');
fprintf(fid, '@data\n');

for i = 1 : size(data,2)    
    sample = data(i);
    for j = 1 : numel(fields)
        if strcmp('class',fields{j})
            continue
        end
        if isnan(sample.(fields{j}))
            fprintf(fid,'-1');
            continue
        end
        if isempty(sample.(fields{j}))
            fprintf(fid,'-1');
            continue
        end
        fprintf(fid,'%f,',sample.(fields{j}));
    end
    fprintf(fid,'%s\n',sample.class);
    
end

fclose(fid);

end

