function [breakSemesters, numCompletedSemesters] = locateBreaks(record) 
        avgGradeEvolution = avgGradesPerSemester(record);
        nBreak = 0;
        breakLength = 0;
        breakSemesters = [];
        for l = 1:length(avgGradeEvolution)
            if (avgGradeEvolution(l) == 0) % those with zero indicate a break
                if(breakLength == 0)
                    nBreak = nBreak + 1;
                    breakSemesters(nBreak, :) = [l, 0];
                end
                breakLength = breakLength + 1;
            elseif (breakLength ~= 0)
                breakSemesters(nBreak, 2) = breakLength;
                breakLength = 0;
            end      
        end
        
        numCompletedSemesters = sum(avgGradeEvolution ~= 0);
end