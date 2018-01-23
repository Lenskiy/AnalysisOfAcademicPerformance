function [gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(records, minBreakLength, minNumberOfSemestersAfterTheBreak)
    % find the first break that satisfies the conditions    
    n = 0;
    for k = 1:length(records) 
        leaveParams = locateBreaks(records{k});
        gpas{k} = gpaPerInterval(leaveParams, records{k});
        if(isempty(leaveParams))
            continue;
        end

        if(leaveParams(:,2) >  minBreakLength)        
           ind = find(leaveParams(:,2) > minBreakLength);
           if(gpas{k}(ind(1) + 1, 1) > minNumberOfSemestersAfterTheBreak)
               n = n + 1;
               gpaBeforeBreak(n) = gpas{k}(ind(1), 2);
               gpaAfterBreak(n) = gpas{k}(ind(1) + 1, 2);
           end
        end
    end
end