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
statisticalAnalysis(gpaBeforeBreak, gpaAfterBreak, 'off');

