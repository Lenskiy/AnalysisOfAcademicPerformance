function [gpaNoBreak] = calcNoBreakGPA(records)
    % find the first break that satisfies the conditions    
    n = 0;
    for k = 1:length(records) 
        leaveParams = locateBreaks(records{k});
        if(isempty(leaveParams))
            n = n + 1;
            gpaNoBreak(n) = mean(avgGradesPerSemester(records{k}));
        end
    end
end