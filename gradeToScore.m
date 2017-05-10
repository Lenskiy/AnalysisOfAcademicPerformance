function score = gradeToScore(grade)
    gradeLabels = {'A+', 'Ao', 'B+', 'Bo', 'C+', 'Co', 'D+', 'Do', 'F'};
    gradeScore = [4.5, 4.0, 3.5, 3.0, 2.5, 2.0, 1.5, 1.0, 0];
    
    for k = 1:length(gradeLabels)
        if strcmp(grade, gradeLabels(k))
            break
        end
    end
    score = gradeScore(k);
end
