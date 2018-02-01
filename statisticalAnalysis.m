function [resp] = statisticalAnalysis(gpaGroup1, gpaGroup2, dispOpt)
    % applies statistical test on group1 and group2 in order to determine 
    % if they come from the same distribution. If data is normal then ANOVA is used, 
    % if not then some other test.
    %
    % input: gpaGroup1, gpaGroup2 = vectors or rows of numbers
    %        dispOpt = 'on' or 'off' - plot BoxPlot of Anova (or other test)
    % return: 0 - data comes from the same distribution
    %         1 - data comes from different distribution
resp = 0;

if nargin<3
  dispOpt='off';
end 
    
if isrow(gpaGroup1)
    gpaGroup1 = gpaGroup1';
end
if isrow(gpaGroup2)
    gpaGroup2 = gpaGroup2';
end
    
g1normal = checkNormality(gpaGroup1, 2);
g2normal = checkNormality(gpaGroup2, 2);
    
data = [gpaGroup1 gpaGroup2];

if g1normal==1 && g2normal == 1
    [P,ANOVATAB,STATS] = anova1(data,[], dispOpt); 
    if(P<0.05) 
        alpha = num2str(P);
        df1 = num2str(cell2mat(ANOVATAB(2,3)));
        df2 = num2str(cell2mat(ANOVATAB(3,3)));
        F = num2str(cell2mat(ANOVATAB(2,5)));
        disp(['[ANOVA]: distributions are different with F(alpha,d1,d2) = F(',alpha,',',df1,',',df2,')=',F]);
        resp = 1;
    end
else
    [P,ANOVATAB,STATS] = anova1(data,[],  dispOpt); 
    if(P<0.05) 
        alpha = num2str(P);
        df1 = num2str(cell2mat(ANOVATAB(2,3)));
        df2 = num2str(cell2mat(ANOVATAB(3,3)));
        F = num2str(cell2mat(ANOVATAB(2,5)));
        disp(['[ANOVA]: distributions are different with F(alpha,d1,d2) = F(',alpha,',',df1,',',df2,')=',F]);
        resp = 1;
    end
end

if(resp==0)
    disp('Distributions of grades before and after are the same :( !') 
end
