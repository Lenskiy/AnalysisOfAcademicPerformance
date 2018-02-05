[recordsDICE, tablesDICE] = readRecords('./Data/DICE/');
[recordsElectrical, tablesElectrical] = readRecords('./Data/Electrical/');
[recordsElectronics, tablesElectronics] = readRecords('./Data/Electronics/');
allRecords = [recordsDICE recordsElectrical recordsElectronics];
minBreakLength = 4;
minNumberOfSemestersAfterTheBreak = 4;
%For all students
[gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(allRecords, minBreakLength, minNumberOfSemestersAfterTheBreak);
[gpaNoBreak] = calcNoBreakGPA(allRecords);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, 'ALL: GPA before and after', 'before', 'after');
visualizeGPAHistogramBeforeAndAfter(gpaNoBreak, (gpaBeforeBreak + gpaAfterBreak) / 2,'Effect of a break', 'no break', 'break');
statisticalAnalysis(gpaBeforeBreak, gpaAfterBreak, 'off');


%For DICE
[gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(recordsDICE, minBreakLength, minNumberOfSemestersAfterTheBreak);
[gpaNoBreak] = calcNoBreakGPA(recordsDICE);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, 'DICE: GPA before and after', 'before', 'after');
visualizeGPAHistogramBeforeAndAfter(gpaNoBreak, (gpaBeforeBreak + gpaAfterBreak) / 2,'DICE: Effect of a break', 'no break', 'break');
statisticalAnalysis(gpaBeforeBreak, gpaAfterBreak, 'off');

%For Electrical2083.52304212 
[gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(recordsElectrical, minBreakLength, minNumberOfSemestersAfterTheBreak);
[gpaNoBreak] = calcNoBreakGPA(recordsElectrical);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, 'Electrical: GPA before and after', 'before', 'after');
visualizeGPAHistogramBeforeAndAfter(gpaNoBreak, (gpaBeforeBreak + gpaAfterBreak) / 2,'Electrical: Effect of a break', 'no break', 'break');
statisticalAnalysis(gpaBeforeBreak, gpaAfterBreak, 'off');

%For Electronics
[gpaBeforeBreak, gpaAfterBreak] = calcBeforeAndAfterTheBreakGPA(recordsElectronics, minBreakLength, minNumberOfSemestersAfterTheBreak);
[gpaNoBreak] = calcNoBreakGPA(recordsElectronics);
% figure, hold on;
% plot(gpaBeforeBreak)
% plot(gpaAfterBreak)
visualizeGPAHistogramBeforeAndAfter(gpaBeforeBreak, gpaAfterBreak, 'Electronics: GPA before and after', 'before', 'after');
visualizeGPAHistogramBeforeAndAfter(gpaNoBreak, (gpaBeforeBreak + gpaAfterBreak) / 2,'Electronics: Effect of a break', 'no break', 'break');

% Class categories 
types = {'100', '101', '102', '103', '130', '131', '132', '133', '134', 'ARB', 'ARD', 'SHA', 'SHB', 'INS', 'ITA', 'ITC', 'ITE', 'ITT', 'ITP', 'IFA', 'IFB', 'IFC', 'IFD', 'IFE', 'IMA', 'IMB', 'INA', 'INI',  'INM', 'IDA', 'IMC', 'IME', 'EDU',  'BSM', 'TAM', 'LAN', 'CCT', 'CON', 'HRD', 'MSA', 'MCA', 'MTB', 'MTD', 'MTE', 'MTF','MEB', 'MEC', 'MEF', 'CPA', 'CPC', 'CPS'};

%build a histogram of classes categories
cathist = buildClassCategoryHistogram(allRecords, types);

% remove categories that appear rarely
catInds = find(sum(cathist) >= 10);

rcathist = cathist(:, catInds);
% selected types labels
for k = 1:length(catInds)
    stypes{k} = types{catInds(k)};
end

% Select what records you want to use
tempRecordings = recordsDICE;

% claculte overall GPA for each student 
gpaOveral = calcOverAllGPA(tempRecordings);
% Normalize GPA to [0, 1] to be able to use it as a color
gpaOveralNorm = (gpaOveral - min(gpaOveral)) / (max(gpaOveral) - min(gpaOveral));


figure, hold on, grid on;
for k = 1:size(tempRecordings,2)
   plot3(k * ones(1, size(rcathist(k, :),2)), 1:size(rcathist(k, :),2), rcathist(k, :), 'color', [gpaOveralNorm(k), 1 - gpaOveralNorm(k), 0], 'marker', '.')
end
xlabel('students');
ylabel('categories');
zlabel('times');
axis([1, size(tempRecordings,2), 1, length(stypes), 0, max(max(rcathist))]);
ax = gca;
ax.YTick = [1:length(stypes)];
ax.YTickLabel = stypes;
set(gca, 'YTickLabelRotation', 45)
    
% Find principal components
[pc, score, latent, tsquare] = pca(rcathist);

reduced = rcathist * pc(:,1:3);

figure, hold on, grid on;
for k = 1:size(tempRecordings,2)
    plot3(reduced(k,1), reduced(k,2), reduced(k,3), 'color', [gpaOveralNorm(k), 1 - gpaOveralNorm(k), 0], 'marker', '.');
end
xlabel('component 1');
ylabel('component 2');
zlabel('component 3');
