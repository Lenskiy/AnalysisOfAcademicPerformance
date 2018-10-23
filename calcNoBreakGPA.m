function [gpaNoBreak, studentsIndWithNoBreaks] = calcNoBreakGPA(records, minTotalNumberOfSemesters)
    % find the first break that satisfies the conditions    
    n = 0;
    for k = 1:length(records) 
        [leaveParams, numCompletedSemesters]= locateBreaks(records{k});
        if(isempty(leaveParams) && minTotalNumberOfSemesters <= numCompletedSemesters) % no need: || (size(leaveParams,1) == 2 && leaveParams(1,1) == 0)
            n = n + 1;
            grades = avgGradesPerSemester(records{k});
            gpaNoBreak(n) = mean(grades(grades~=0));
            studentsIndWithNoBreaks(n) = k;
        end
    end
end