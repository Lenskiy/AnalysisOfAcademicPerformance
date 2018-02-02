function [gpaOverall] = calcOverAllGPA(records)
    % find the first break that satisfies the conditions    
    for k = 1:length(records) 
        grades = avgGradesPerSemester(records{k});
        gpaOverall(k) = mean(grades(grades~=0));
    end
end