function table = readStudentCSV2(path, elementsPerRow)
    if(nargin() == 1)
        elementsPerRow = 10;
    end
    
    f = fopen(path ,'r','l','KS_C_5601-1987');
    rawcontent = fread(f,'*char')';
    
    % the following loop takes care of "??\n??", where \n is a newline symbol 
    % replaced by space
    quotesPos = findstr(rawcontent, '"');
    for k = 1:length(quotesPos)-1
        rawcontent(quotesPos(k):quotesPos(k+1)) = strrep(strrep(rawcontent(quotesPos(k):quotesPos(k+1)), char(10), ' '), '"', ' ');
    end
    % split into rows
    rows = splitlines(rawcontent);
    % split each rows into fields separated by commas
    for k = 1:length(rows)
        comaSeparated =  split(rows{k},',');
        for l = 1 :elementsPerRow
            if(l <= length(comaSeparated))
                table(k, l) = comaSeparated(l);
            else
                table(k, l) = '';
            end
        end
    end
end