function [gpaBeforeBreak, gpaAfterBreak, studentsInd] = calcBeforeAndAfterTheBreakOneSemesterGPA(records, breakLength, minNumberOfSemestersAfterTheBreak, semesterBreak)
    % find the first break that satisfies the conditions    
    n = 0;
    gpaBeforeBreak =[];
    gpaAfterBreak = [];
    studentsInd = [];
    for k = 1:length(records) 
        leaveParams = locateBreaks(records{k});
        for l = 1:size(leaveParams, 1)
            if(leaveParams(l,2) ~= 0)
                avgGrade = avgGradesPerSemester(records{k});
                                      
                gpasPerStudens(l, :) = [leaveParams(l, 1) + leaveParams(l, 2) - (leaveParams(l, 1)),... % break legnth
                                        avgGrade(leaveParams(l, 1) - 1),...                             % GPA before the break
                                        avgGrade(leaveParams(l, 1) + leaveParams(l, 2))];               % GPA after the break
            end
        end
        
        if(isempty(leaveParams) || leaveParams(1,2) == 0)
            continue;
        end
        
        [theLongestBreak, theLongestBreakInd] = max(leaveParams(:,2));
        if(sum(theLongestBreak == breakLength))        
           if(gpasPerStudens(theLongestBreakInd, 1) >= minNumberOfSemestersAfterTheBreak)
               if(sum(leaveParams(theLongestBreakInd, 1) == semesterBreak))
                    n = n + 1;
                    gpaBeforeBreak(n) = gpasPerStudens(theLongestBreakInd, 2);
                    gpaAfterBreak(n) = gpasPerStudens(theLongestBreakInd, 3);
                    studentsInd = [studentsInd, k];
               end
           end
        end
    end
end