function gpas = gpaPerInterval(leaveParams, record)
    avgGradeEvolution = avgGradesPerSemester(record);
    if(isempty(leaveParams))
        gpas = [length(avgGradeEvolution), mean(avgGradeEvolution)];
        return;
    end
    startInd = 1;
    for k = 1:size(leaveParams,1)
        if(k <= size(leaveParams,1))
        	gpas(k, :) = [length(startInd:(leaveParams(k, 1)-1)), mean(avgGradeEvolution(startInd:(leaveParams(k, 1)-1)))];
            startInd = leaveParams(k, 1) + leaveParams(k, 2);
        else
        	gpas(k, :) = [length(avgGradeEvolution(startInd:end)), mean(avgGradeEvolution(startInd:end))];
        end
    end
end