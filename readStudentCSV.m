function table = readStudentCSV(path, elementsPerRow)
    if(nargin() == 1)
        elementsPerRow = 10;
    end
    
    f = fopen(path ,'r','l','KS_C_5601-1987');
    rawcontent = fread(f,'*char')';
    
    rows = splitlines(rawcontent);

    n = 1;
    k = 0;
    while (k  < size(rows,1) - 1)
        k = k + 1;
        comaSeparated =  split(rows{k},',');
        for l = 1 :elementsPerRow
            if(length(comaSeparated) < elementsPerRow && l == length(comaSeparated))
                k = k + 1;
                temp = split(rows{k},',');
                comaSeparated = [comaSeparated(1:end-1); strcat(comaSeparated{end}, 32 ,temp{1})];
                comaSeparated = [comaSeparated; temp(2:end)];
            end
            table(n, l) = strrep(comaSeparated(l), '"', '');
        end
        n = n + 1;
    end  
end