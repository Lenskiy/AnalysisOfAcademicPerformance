function [gpaBeforeBreak, gpaAfterBreak, studentsInd] = calcBeforeAndAfterTheBreakGPA(records, minBreakLength, minNumberOfSemestersAfterTheBreak, semesterBreak)
    % find the first break that satisfies the conditions    
    n = 0;
    gpaBeforeBreak =[];
    gpaAfterBreak = [];
    studentsInd = [];
    for k = 1:length(records) 
        leaveParams = locateBreaks(records{k});
        gpas{k} = gpaPerInterval(leaveParams, records{k});
        if(isempty(leaveParams))
            continue;
        end

        [theLongestBreak, theLongestBreakInd] = max(leaveParams(:,2));
        if(theLongestBreak >=  minBreakLength)        
           %ind = find(leaveParams(:,2) >= minBreakLength);
           %if(gpas{k}(ind(1) + 1, 1) >= minNumberOfSemestersAfterTheBreak)
           if(gpas{k}(theLongestBreakInd + 1, 1) >= minNumberOfSemestersAfterTheBreak)
               if(sum(leaveParams(theLongestBreakInd, 1) == semesterBreak))
                    n = n + 1;
    %                gpaBeforeBreak(n) = gpas{k}(ind(1), 2);
    %                gpaAfterBreak(n) = gpas{k}(ind(1) + 1, 2);
                    gpaBeforeBreak(n) = gpas{k}(theLongestBreakInd, 2);
                    gpaAfterBreak(n) = gpas{k}(theLongestBreakInd + 1, 2);
                    studentsInd = [studentsInd, k];
               end
           end
        end
    end
end