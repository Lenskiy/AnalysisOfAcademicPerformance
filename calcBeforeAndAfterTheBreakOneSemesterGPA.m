function [gpaBeforeBreak, gpaAfterBreak, studentsInd] = calcBeforeAndAfterTheBreakOneSemesterGPA(records, breakLength, semesterBreak) % minNumberOfSemestersAfterTheBreak
    % find the first break that satisfies the conditions    
    n = 0;
    gpaBeforeBreak =[];
    gpaAfterBreak = [];
    studentsInd = [];
    for k = 1:length(records) 
        clear leaveParams;
        leaveParams = locateBreaks(records{k}); % break semester, break length
        for l = 1:size(leaveParams, 1)
            if(~isempty(leaveParams))
                avgGrade = avgGradesPerSemester(records{k});
                                      
                leaveParams(l, 3:4) = [ avgGrade(leaveParams(l, 1) - 1),...                             % GPA before the break
                                        avgGrade(leaveParams(l, 1) + leaveParams(l, 2))];               % GPA after the break
            end
        end
        
        if(isempty(leaveParams) || leaveParams(1,2) == 0)
            continue;
        end
        
        [theLongestBreak, theLongestBreakInd] = max(leaveParams(:,2));
        if(sum(theLongestBreak == breakLength))        
           %if(leaveParams(theLongestBreakInd, 1) >= minNumberOfSemestersAfterTheBreak)
               if(sum(leaveParams(theLongestBreakInd, 1) == semesterBreak))
                    n = n + 1;
                    gpaBeforeBreak(n) = leaveParams(theLongestBreakInd, 3);
                    gpaAfterBreak(n) = leaveParams(theLongestBreakInd, 4);
                    studentsInd = [studentsInd, k];
               end
           %end
        end
    end
end