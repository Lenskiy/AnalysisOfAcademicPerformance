function [GPA, hist]= calculateGPA(stTable)
    gradeLabels = {'A+', 'Ao', 'B+', 'Bo', 'C+', 'Co', 'D+', 'Do', 'F'};
    gradeScore = [4.5, 4.0, 3.5, 3.0, 2.5, 2.0, 1.5, 1.0, 0];
    gradesColumn = stTable(:,8);
    
    for k = 1:length(gradeLabels)
        hist(k) = sum(gradesColumn == gradeLabels{k});
    end
    
    GPA = gradeScore*hist'/sum(hist);
end