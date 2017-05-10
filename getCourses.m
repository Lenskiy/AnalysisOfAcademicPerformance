function sortedCourses = getCourses(table)
    years = table(:,1).double;
    inds = find((2000 < years) & (years < 2018));
    %courses{length(inds), size(table,2) -1 } = [];
    %sortedCourses{length(inds), size(table,2) -1 } = [];
    n = 1;
    for l = 1:length(inds)
           tmp = table(inds(l),2).char;
%            if(strcmp(tmp, '??'))
%                courses{l, 1} = years(inds(l)) + 0.75;
%            end
%            strcmp(tmp, '1??')
%            if (strcmp(tmp, '1??'))
%                courses{l, 1} = years(inds(l)); 
%            end
%            if (strcmp(tmp, '2??'))
%                courses{l, 1} = years(inds(l)) + 0.5;
%            end
           if(~isempty(str2num(tmp(1))))
                courses{n, 1} = years(inds(l)) + (str2num(tmp(1)) - 1)/2;   % year
           else
               continue; % skip summer/winter courses 
               %courses{l, 1} = years(inds(l)) + 0.75; % for summer/winter, add 0.75;
           end
           courses{n, 2} = table(inds(l),3); % course code
           courses{n, 3} = table(inds(l),4); % egineering certification
           courses{n, 4} = table(inds(l),5); % course title
           if(table(inds(l),6).strlength ~= 0)
            courses{n, 5} = table(inds(l),6).double;
           end          
           if(table(inds(l),7).strlength ~= 0)
            courses{n, 6} = table(inds(l),7).double; % points per course
           else
            courses{n, 6} = 0;
           end
           courses{n, 7} = gradeToScore(table(inds(l),8).strip);
           if(courses{n, 7} == 0)
               continue; % skip pass/fail courses
           end
           courses{n, 8} = table(inds(l),9); %??
           courses{n, 9}= table(inds(l), 10);% ??
           n = n + 1;
    end
    [~, sinds] = sort(cell2mat(courses(:,1)));
    
    for k = 1:size(courses,1)
        sortedCourses(k, :) = courses(sinds(k), :);
    end
end