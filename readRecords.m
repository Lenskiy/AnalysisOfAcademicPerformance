function [courses, tables]= readRecords(path)
    % path specifies the path to the folder with CSV files
    filenames = dir(path);
    n = 1;
    % Parse CSV files and store student info in the cell array courses
    for k = 1:size(filenames,1)
        if ~isempty(strfind(filenames(k).name, '.csv'))
            % tables contains content of CSV files in the same format
            tables{n} = readStudentCSV2([path, '/', filenames(k).name]);
            %[gpa, hist] = calculateGPA(tables{n});
            courses{n} = getCourses(tables{n});
            n = n + 1;
        end
    end
end