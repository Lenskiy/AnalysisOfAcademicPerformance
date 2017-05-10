function avgGradeEvolution = avgGradesPerSemester(courses, topSemester)
    if(nargin() == 1)
        topSemester = 20;
    end
     avgGradeEvolution = getGPA(courses, 1:topSemester);
%     for k = 1:length(courses)
%         years = cell2mat(courses{k}(:,1));
%         listYears = unique(years);
%         nanInd = [];
%         for l = 1:length(listYears)
%             grds = cell2mat(courses{k}(years == listYears(l),7));
%             avgGrades(l) = sum(grds)/sum(grds ~= 0);
%             nanInd = [nanInd, find(isnan(avgGrades))];
%         end
%         avgGrades(nanInd) = [];
%         listYears(nanInd) = [];
%         avgGradeEvolution{k} = [listYears'; avgGrades];
%         clear avgGrades;
%     end
end