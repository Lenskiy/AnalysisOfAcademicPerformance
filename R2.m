function R2_ = R2(x,y)
%     x = [1:8];
% 
%     for k = 1:8
%         y(k) = mean(gpa(~isnan(gpa(:, k)), k));
%     end

    ymean = mean(y);

    SStot = sum((y - ymean).^2);
    p = polyfit(x, y, 1);
    f = @(x) p(1) * x + p(2);
    SSreg = sum((f(x) - ymean).^2);
    SSres = sum((y - f(x)).^2);
    R2_ = 1 - SSres/SStot;

end

figure, hold on;
plot(x, y, 'o');

plot([x(1), x(end)], [x(1)*p(1) + p(2), x(end)*p(1) + p(2)])