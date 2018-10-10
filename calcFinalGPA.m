function [finalGPA] = calcFinalGPA(records, inds)
    % find the first break that satisfies the conditions    
    n = 0;
    finalGPA = [];
    for k = 1:length(inds) 
        n = n + 1;
        grades = avgGradesPerSemester(records{inds(k)});
        finalGPA(n) = mean(grades(grades ~= 0));
    end
end