function [normal] = checkNormality(input, test)
% check "data" normality with significance level alpha = 0.05
% 
% return: 
% 1 - data normal
% 0 - data not normal
normal = 0;
if nargin<2
  test=1;
end 
    if(test==1)  %normality - SW test       
        [H, pValue, SWstatistic]=  swtest(input, 0.05);
        if(H==0) 
           disp(['SW: grades are normal']);
           normal = 1;
        else
           disp(['SW: grades are NOT normal']);
        end
    elseif(test==2) 
        [H, pValue, SWstatistic]=  adtest(input, 'Alpha', 0.05);
        if(H==0) 
           disp(['AD: grades are normal']);
           normal = 1;
        else
           disp(['AD: grades are NOT normal']);
        end
    else
        %normality - KS test
        [H,p,ksstat,cv] = kstest((input-mean(input))/std(input), 'Alpha',0.05) %if input is normal distribution with mean input and std input? 0 for yes, 1 for no
        if(H==0) 
           disp(['SW: grades are normal']);
           normal = 1;
        else
           disp(['SW: grades are NOT normal']);
        end
    end
    
    
end