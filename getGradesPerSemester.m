function grades = getGradesPerSemester(courses, semester)
    allSemesters = cell2mat(courses(:,1));
    grades = 0;
    % find first and last years 
    firstYear = min(allSemesters);
    lastYear = max(allSemesters);
    totalSemesters = (lastYear - firstYear + 0.5)/0.5;
    if(semester <= totalSemesters)
        grades = cell2mat(courses(find(allSemesters == firstYear + (semester - 1) * .5),7));
    end
end

% 1 2 10 13 14 15 16 17