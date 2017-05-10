% specify path to the folder with CSV files
path = '/Users/artemlenskiy/Dropbox/Development/Matlab/EduAn/Data/All2/';
filenames = dir(path);
n = 1;
clear stRecords;
clear courses
% Parse CSV files and store student info in the cell array courses
for k = 1:size(filenames,1)
    if ~isempty(strfind(filenames(k).name, '.csv'))
        % tables contains content of CSV files in the same format
        tables{n} = readStudentCSV2([path, '/', filenames(k).name]);
        %[gpa, hist] = calculateGPA(tables{n});
        % structure contains parsed info, for now only GPA, and grades histogram
        % stRecords{n} = struct('id', tables{n}(2,2), 'GPA', gpa, 'gradeshist', hist);
        courses{n} = getCourses(tables{n});
        n = n + 1;
    end
end


earlierGraduation = []; % less than 8 semesters in total
clear leaveParams;
clear gpaBefore;
clear gpaAfter;
n = 1;
studentsCompletedCoursesIndexes = 0;
for k = 1:length(courses)
    avgGradeEvolution = avgGradesPerSemester(courses{k});
    lastSemester = find(avgGradeEvolution == 0);
    if(isempty(lastSemester))
        lastSemester = length(avgGradeEvolution);
    else
        lastSemester = lastSemester(1) - 1;    
    end
    numCompletedSemesters = sum(avgGradeEvolution ~= 0 & ~isnan(avgGradeEvolution));
    if(numCompletedSemesters < 8)
        % skip students that completed less than 8
        % semesters
        earlierGraduation = [earlierGraduation, k];
        continue; 
    end
    
    semestersAttended = 1:lastSemester;
    semestersAttended(isnan(avgGradeEvolution)) = [];
    [breakLength_, breakSemester_] = max(diff(semestersAttended));
    breakLength = breakLength_ - 1;
    breakSemester = semestersAttended(breakSemester_)  + 1;
    leaveParams(n, :) = [breakLength, breakSemester];
    gpaBefore(n) = avgGradeEvolution(breakSemester - 1);
    gpaAfter(n) = avgGradeEvolution(breakSemester + breakLength);   
    studentsCompletedCoursesIndexes(n) = k;
    n = n + 1;
end



% Visualize distribution of GPAs for students before and after the break at 
% different semesters
hadLongBreak = find(leaveParams(:,1) >= 4);
for k = 2:5
    breakSemester = k;
    breakSemesterInd = find(leaveParams(hadLongBreak,2) == breakSemester);
    %gpaBefore(hadLongBreak(breakSemesterInd))
    %gpaAfter(hadLongBreak(breakSemesterInd))
    
    figure('Position', [100, 100, 400, 200]), hold on;
    h1 = histogram(gpaBefore(hadLongBreak(breakSemesterInd)), 10);
    h1.BinWidth = 0.25;
    h1.Normalization = 'probability';    
    h2 = histogram(gpaAfter(hadLongBreak(breakSemesterInd)), 10);
    h2.BinWidth = 0.25;
    h2.Normalization = 'probability';    
    title({['          Break after  ', num2str(k-1),' semester'];...
           ['Total ', num2str(length(breakSemesterInd)),' students, ',...
           '  $\mu_1$ = ', num2str(mean(gpaBefore(hadLongBreak(breakSemesterInd)))),...
           ' $\pm$ ', num2str(std(gpaAfter(hadLongBreak(breakSemesterInd)))),...           
           ', $\mu_2$ = ', num2str(mean(gpaAfter(hadLongBreak(breakSemesterInd)))),...
           ' $\pm$ ', num2str(std(gpaAfter(hadLongBreak(breakSemesterInd))))]}, 'Interpreter', 'Latex');
    legend({'before', 'after'});
    xticklabels({'F','Do','D+','Co','C+','Bo','B+', 'Ao', 'A+'})
    xticks([0 1:0.5:4.5]);
    hold off;
end

% Visulaize distribution of differences of GPAs for studens who have had a 
% long break, and who did not have a long break. 
noOrShortBreak = find(leaveParams(:,1) <= 2);
for k = 1:length(noOrShortBreak)
    avgGradeEvolutionNoBreak(k, :) = avgGradesPerSemester(courses{studentsCompletedCoursesIndexes(noOrShortBreak(k))});
end

for breakSemester = 2:5
    difNoBreak = avgGradeEvolutionNoBreak(:,breakSemester) - avgGradeEvolutionNoBreak(:,breakSemester - 1);

    breakSemesterInd = find(leaveParams(hadLongBreak,2) == breakSemester);
    difBreak = (gpaAfter(hadLongBreak(breakSemesterInd)) - gpaBefore(hadLongBreak(breakSemesterInd)))';
    
    figure('Position', [100, 100, 400, 200]), hold on;
    title({['          Break after  ', num2str(breakSemester - 1),' semester'];...
           ['Total ', num2str(length(breakSemesterInd)),' students, ',...
           '  $\mu_1$ = ', num2str(mean(difNoBreak(~isnan(difNoBreak)))),...
           ' $\pm$ ', num2str(std(difNoBreak(~isnan(difNoBreak)))),...           
           ', $\mu_2$ = ', num2str(mean(difBreak(~isnan(difBreak)))),...
           ' $\pm$ ', num2str(std(difBreak(~isnan(difBreak))))]}, 'Interpreter', 'Latex');    
    
    h1 = histogram(difNoBreak, 10);
    h1.BinWidth = 0.25;
    h1.Normalization = 'probability';
    h2 = histogram(difBreak, 10);
    h2.BinWidth = 0.25;
    h2.Normalization = 'probability';
    legend({'no or short break', 'long break'}); 

    hold off;
end
% test
avgGradesPerSemester(courses{studentsCompletedCoursesIndexes(hadLongBreak(1))})

hadLongBreak = find(leaveParams(:,1) >= 4);
stdInds = find(leaveParams(hadLongBreak,2) == 8);
length(stdInds)
before = gpaBefore(hadLongBreak(stdInds));
after = gpaAfter(hadLongBreak(stdInds));
mean(before)
mean(after)




% 
% hist([gpaBefore(hadLongBreak); gpaAfter(hadLongBreak)]');
% title(['$\mu_1$ = ', num2str(mean(gpaBefore(hadLongBreak))), ', $\mu_2$ = ', num2str(mean(gpaAfter(hadLongBreak)))], 'Interpreter', 'Latex');
% legend({'befor', 'after'});
% xticklabels({'F','Do','D+','Co','C+','Bo','B+', 'Ao', 'A+'})
% xticks([0 1:0.5:4.5]);
%     
% noBreak = find(leaveParams(:,1) == .5);
% clear gpaBeforeAndAfterLeave;
% for k = 1:8
%     leaveSemester{k} = find(leaveParams(hadLongBreak,2) == k);
%     for l = 1:length(leaveSemester{k})
%         gpaBeforeAndAfterLeave{k}(l, 1) = mean(avgGradeEvolution{leaveSemester{k}(l)}(2,1:leaveParams(k, 2)));
%         gpaBeforeAndAfterLeave{k}(l, 2) = mean(avgGradeEvolution{leaveSemester{k}(l)}(2,leaveParams(k, 2)+1:end));
%     end
% end

%compare students' GPA who had a break and did not have a break

% figure, hold on;
% for k = 1:4
%    plot(gpaBeforeAndAfterLeave{k}(:,1), gpaBeforeAndAfterLeave{k}(:, 2), '.', 'markersize', 10);
% end
% 
% 
% figure, hold on; 
% for k = 1:4 
%     x = gpaBeforeAndAfterLeave{k}(:, 1);
%     y = gpaBeforeAndAfterLeave{k}(:, 2);
%     %figure; plot(x,y , '.', 'markersize', 10);
%    
%     [r,p] = corrcoef(x,y);
%     figure(k); plot(x,y,'.', 'Marker', '.', 'color', 'r', 'markersize', 20, 'linewidth',3);
%     yticklabels({'F','Do','D+','Co','C+','Bo','B+', 'Ao', 'A'})
%     yticks([0 1:0.5:4.5]);
%     xticklabels({'F','Do','D+','Co','C+','Bo','B+', 'Ao', 'A'})
%     xticks([0 1:0.5:4.5]);
%     %axis([0.3 1.4 1.6 8.6])
%     hold on
%     a = polyfit(x,y,1); %fit polynomial using MSE (find a and b of y=ax+b)
%     yhat=a(1)*x+a(2); %regression line
%     plot(x,yhat, 'linewidth',3)
%     %txt = mat2cell(good_ind,1,ones(1,size(good_ind,2)));
%     %text(x-0.02,y+0.3, txt, 'color', 'black', 'fontsize',10);
%     ylabel('GPA after the leave');
%     xlabel('GPA before the leave');
%     title(['Took a leave after semester ', int2str(k), ', $R$ =', num2str(r(1,2)),' with $p$ = ', num2str(p(1,2)), ' Slope = ', num2str(a(1))],'Interpreter','latex');
%     grid on;
% 
% end







% visualize histogram for N students
% N = 10;
% for k = 1:N
%     figure, bar(stRecords{k}.gradeshist);
%     title(['Student: ', stRecords{k}.id])
%     xticks([1:9]);
%     xticklabels({'A+','Ao','B+','Bo','C+','Co','D+', 'Do', 'F'})
% end