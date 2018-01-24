function [gpaNoBreak] = calcNoBreakGPA(records)
    % find the first break that satisfies the conditions    
    n = 0;
    for k = 1:length(records) 
        leaveParams = locateBreaks(records{k});
        if(size(leaveParams,1) == 1 ) % no need: || (size(leaveParams,1) == 2 && leaveParams(1,1) == 0)
            n = n + 1;
            grades = avgGradesPerSemester(records{k});
            gpaNoBreak(n) = mean(grades(grades~=0));
        end
    end
end