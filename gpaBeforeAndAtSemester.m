function [gpaBeforeSemester, gpaAtSemester] = gpaBeforeAndAtSemester(records, breakSemester, studentsInds)
    for k = 1:length(studentsInds)
        avgGrade = avgGradesPerSemester(records{studentsInds(k)});
        gpaBeforeSemester(k) = avgGrade(breakSemester - 1);
        gpaAtSemester(k) = avgGrade(breakSemester);
    end
end