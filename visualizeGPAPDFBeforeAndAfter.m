function visualizeGPAPDFBeforeAndAfter(gpaGroup1, gpaGroup2, histTitle, legend1, legend2)
    dummy = gcf;
    colors = dummy.Colormap;
    %close(dummy);
    figure('Position', [100, 100, 400, 200]), hold on;
    pdf1 = kde(gpaGroup1, .1 );
    pdf2 = kde(gpaGroup2, .1 );
    x = 1:.05:4.5;
    y1 = evaluate(pdf1, x);
    y2 = evaluate(pdf2, x);
    C1 = plot(x, y1, 'linewidth', 2, 'color', colors(1,:));
    C2 = plot(x, y2, 'linewidth', 2, 'color', colors(45,:));
    H1 = area(x, y1);
    set(H1,'FaceColor', colors(2,:), 'FaceAlpha', 0.6);
    H2 = area(x, y2);
    set(H2,'FaceColor', colors(46,:), 'FaceAlpha', 0.6);    
  
    title({histTitle;...
           ['(', num2str(length(gpaGroup1)),', ', num2str(length(gpaGroup2)) '): ',...
           '  $\mu_1$ = ', num2str(mean(gpaGroup1), 3),...
           ' $\pm$ ', num2str(std(gpaGroup1), 3),...           
           ', $\mu_2$ = ', num2str(mean(gpaGroup2), 3),...
           ' $\pm$ ', num2str(std(gpaGroup2), 3)]}, 'Interpreter', 'Latex');
    legend({legend1, legend2},'Location','NorthWest');
    xticklabels({'D+', 'Co', 'C+', 'Bo', 'B+', 'Ao', 'A+'}); % 'F','Do','D+',
    xticks(1.5:0.5:4.5);
    xlim([1.5 4.5]);
    legend boxoff 
    hold off;
    
end