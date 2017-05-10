function [GPAs, totalSemesters]= getGPA(courses, semesters)
    GPAs = 0;
    allSemesters = cell2mat(courses(:,1));
    % find first and last years 
    firstYear = min(allSemesters);
    lastYear = max(allSemesters);
    totalSemesters = (lastYear - firstYear)/0.5;
    for k = 1:length(semesters)
        grades = getGradesPerSemester(courses, semesters(k));
        GPAs(k) = mean(grades);
    end
end