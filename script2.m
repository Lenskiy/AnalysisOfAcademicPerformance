[recordsDICE, tablesDICE] = readRecords('./Data/DICE/');
[recordsElectrical, tablesElectrical] = readRecords('./Data/Electrical/');
[recordsElectronics, tablesElectronics] = readRecords('./Data/Electronics/');
allRecords = [recordsDICE recordsElectrical recordsElectronics];
minBreakLength = 4;
minNumberOfSemestersAfterTheBreak = 2;
minTotalNumberOfSemesters = 8;
breakSemester = 2;
%For all students
% [gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(allRecords, minBreakLength, minNumberOfSemestersAfterTheBreak);
[gpaBeforeBreak, gpaAfterBreak, studentsIndWithBreaks] = calcBeforeAndAfterTheBreakOneSemesterGPA(allRecords, minBreakLength, minNumberOfSemestersAfterTheBreak, breakSemester);
finalGPANoBreak = calcFinalGPA(allRecords, studentsIndWithBreaks); % final GPA of students with long breaks

[finalGPABreak, studentsIndWithNoBreaks] = calcNoBreakGPA(allRecords, minTotalNumberOfSemesters);  % final GPA of students with no breaks and minimum studied semesters
[gpaBeforeSemester, gpaAtSemester] = gpaBeforeAndAtSemester(allRecords, breakSemester, studentsIndWithNoBreaks);


% [gpaNoBreak] = calcNoBreakGPA(allRecords);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, ['All: GPA before and after long-term break at N = ', num2str(breakSemester) ,' semester'], 'before', 'after');
statisticalAnalysis(gpaBeforeBreak, gpaAfterBreak, 'off');
visualizeGPAHistogramBeforeAndAfter(gpaBeforeSemester, gpaAtSemester,['All: GPA before and at N = ', num2str(breakSemester) ,' semester'], 'before', 'at');
statisticalAnalysis(gpaBeforeVirtualBreak, gpaBeforeVirtualBreak, 'off');


visualizeGPAHistogramBeforeAndAfter(finalGPANoBreak, finalGPABreak,'All: Effect of a break', 'no break', 'break');






%For DICE
%[gpaBeforeBreak, gpaAfterBreak, studentsInd] = calcBeforeAndAfterTheBreakGPA(recordsDICE, minBreakLength, minNumberOfSemestersAfterTheBreak, breakSemester);
% [gpaBeforeBreak, gpaAfterBreak, studentsInd] = calcBeforeAndAfterTheBreakOneSemesterGPA(recordsDICE, minBreakLength, minNumberOfSemestersAfterTheBreak, breakSemester);
% fGPA = calcFinalGPA(recordsDICE, studentsInd);
% [gpaNoBreak] = calcNoBreakGPA(recordsDICE);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
% visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, ['DICE: GPA before and after long-term break at N = ', num2str(breakSemester) ,' semester'], 'before', 'after');
% visualizeGPAHistogramBeforeAndAfter(gpaNoBreak, fGPA,'DICE: Effect of a break', 'no break', 'break');
% statisticalAnalysis(gpaBeforeBreak, gpaAfterBreak, 'off');


%For Electrical2083.52304212 
%[gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(recordsElectrical, minBreakLength, minNumberOfSemestersAfterTheBreak);
%[gpaNoBreak] = calcNoBreakGPA(recordsElectrical);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
%visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, 'Electrical: GPA before and after', 'before', 'after');
%visualizeGPAHistogramBeforeAndAfter(gpaNoBreak, (gpaBeforeBreak + gpaAfterBreak) / 2,'Electrical: Effect of a break', 'no break', 'break');
%statisticalAnalysis(gpaBeforeBreak, gpaAfterBreak, 'off');

%For Electronics
%[gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(recordsElectronics, minBreakLength, minNumberOfSemestersAfterTheBreak);
%[gpaNoBreak] = calcNoBreakGPA(recordsElectronics);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
%visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, 'Electronics: GPA before and after', 'before', 'after');
%visualizeGPAHistogramBeforeAndAfter(gpaNoBreak, (gpaBeforeBreak + gpaAfterBreak) / 2,'Electronics: Effect of a break', 'no break', 'break');

% Class categories 
types = {'100', '101', '102', '103', '130', '131', '132', '133', '134', 'ARB', 'ARD', 'SHA', 'SHB', 'INS', 'ITA', 'ITC', 'ITE', 'ITT', 'ITP', 'IFA', 'IFB', 'IFC', 'IFD', 'IFE', 'IMA', 'IMB', 'INA', 'INI',  'INM', 'IDA', 'IMC', 'IME', 'EDU',  'BSM', 'TAM', 'LAN', 'CCT', 'CON', 'HRD', 'MSA', 'MCA', 'MTB', 'MTD', 'MTE', 'MTF','MEB', 'MEC', 'MEF', 'CPA', 'CPC', 'CPS'};

% Select what records you want to use
tempRecordings = recordsElectronics; %recordsDICE, recordsElectrical, recordsElectronics

%build a histogram of classes categories
cathist = buildClassCategoryHistogram(tempRecordings, types);

% remove categories that appear rarely
catInds = find(sum(cathist) >= 10);

rcathist = cathist(:, catInds);
% selected types labels
for k = 1:length(catInds)
    stypes{k} = types{catInds(k)};
end

% claculte overall GPA for each student 
gpaOveral = calcOverAllGPA(tempRecordings);
% Normalize GPA to [0, 1] to be able to use it as a color
gpaOveralNorm = (gpaOveral - min(gpaOveral)) / (max(gpaOveral) - min(gpaOveral));
[grades, gradeSortedInds] = sort(gpaOveralNorm);

figure, hold on, grid on;
for k = 1:size(tempRecordings,2)
   stem3(k * ones(1, size(rcathist(gradeSortedInds(k), :),2)), 1:size(rcathist(gradeSortedInds(k), :),2), rcathist(gradeSortedInds(k), :), 'color', [gpaOveralNorm(gradeSortedInds(k)), 1 - gpaOveralNorm(gradeSortedInds(k)), 0], 'marker', '.')
end
xlabel('students');
ylabel('categories');
zlabel('times');
axis([1, size(tempRecordings,2), 1, length(catInds), 0, max(max(rcathist))]);
ax = gca;
ax.YTick = [1:length(catInds)];
ax.YTickLabel = types(catInds);
set(gca, 'YTickLabelRotation', 45)
    
% Find principal components
[pc, score, latent, tsquare] = pca(rcathist);

reduced = rcathist * pc(:,1:3);

figure, hold on, grid on;
for k = 1:size(tempRecordings,2)
    plot3(reduced(gradeSortedInds(k),1), reduced(gradeSortedInds(k),2), reduced(gradeSortedInds(k),3), 'color', [gpaOveralNorm(gradeSortedInds(k)), 1 - gpaOveralNorm(gradeSortedInds(k)), 0], 'marker', '.', 'markersize', 5);
end
xlabel('component 1');
ylabel('component 2');
zlabel('component 3');
