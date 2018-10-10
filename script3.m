girlsData = girls.Variables;
boysData = boys.Variables;

girlsGradeDynamics = zeros(8, 2); 
for k = 4:11
    nonNaNinds = ~isnan(girlsData(:,k));
    girlsGradeDynamics(k - 3, 1) = mean(girlsData(nonNaNinds,k));
    girlsGradeDynamics(k - 3, 2) = std(girlsData(nonNaNinds,k));
end

boysGradeDynamics = zeros(8, 2); 
for k = 4:11
    nonNaNinds = ~isnan(boysData(:,k));
    boysGradeDynamics(k - 3, 1) = mean(boysData(nonNaNinds,k));
    boysGradeDynamics(k - 3, 2) = std(boysData(nonNaNinds,k));
end


figure, hold on;
errorbar(1:8, girlsGradeDynamics(:, 1), girlsGradeDynamics(:, 2));
errorbar(1:8, boysGradeDynamics(:, 1), boysGradeDynamics(:, 2));
axis([1, 8, 1, 4.5])

bins = [2:0.25:4.5];
g1 = hist(girlsData(:,2),bins);
b1 = hist(boysData(:,2),bins);

figure, hold on;
bar(bins, g1/sum(g1))
bar(bins, b1/sum(b1))
alpha(0.5);
legend({'f', 'm'});
[mean(girlsData(:,2)), mean(boysData(:,2))]
