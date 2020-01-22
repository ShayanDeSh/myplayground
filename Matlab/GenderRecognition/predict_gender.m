function predict_gender(location)
    files = dir(fullfile(location, '*.mp3'));
    location = strcat(location, '/');
    names = files.name;
    for i=1:length(files)
        loc = strcat(location, files(i).name);
        p = peak(loc);
        if p > 85 && p < 165
            fprintf('%s male\n', loc);
        elseif p > 180 && p < 255
            fprintf('%s female\n', loc);
        else
            fprintf('%s no prediction\n', loc);
        end
    end
end