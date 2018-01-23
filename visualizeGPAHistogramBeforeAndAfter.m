function visualizeGPAHistogramBeforeAndAfter(gpaGroup1, gpaGroup2, histTitle, legend1, legend2)
    figure('Position', [100, 100, 400, 200]), hold on;
    h1 = histogram(gpaGroup1, 10);
    h1.BinWidth = 0.25;
    h1.Normalization = 'probability';    
    h2 = histogram(gpaGroup2, 10);
    h2.BinWidth = 0.25;
    h2.Normalization = 'probability';    
    title({histTitle;...
           ['Number of records: (', num2str(length(gpaGroup1)),', ', num2str(length(gpaGroup2)) '), ',...
           '  $\mu_1$ = ', num2str(mean(gpaGroup1)),...
           ' $\pm$ ', num2str(std(gpaGroup1)),...           
           ', $\mu_2$ = ', num2str(mean(gpaGroup2)),...
           ' $\pm$ ', num2str(std(gpaGroup2))]}, 'Interpreter', 'Latex');
    legend({legend1, legend2});
    xticklabels({'F','Do','D+','Co','C+','Bo','B+', 'Ao', 'A+'})
    xticks([0 1:0.5:4.5]);
    hold off;
end