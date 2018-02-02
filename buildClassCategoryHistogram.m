function cathist = buildClassCategoryHistogram(records)
    types = {'100', '101', '102', '103', '130', '131', '132', '133', '134', 'ARB', 'ARD', 'SHA', 'SHB', 'INS', 'ITA', 'ITC', 'ITE', 'ITT', 'ITP', 'IFA', 'IFB', 'IFC', 'IFD', 'IFE', 'IMA', 'IMB', 'INA', 'INI',  'INM', 'IDA', 'IMC', 'IME', 'EDU',  'BSM', 'TAM', 'LAN', 'CCT', 'CON', 'HRD', 'MSA', 'MCA', 'MTB', 'MTD', 'MTE', 'MTF','MEB', 'MEC', 'MEF', 'CPA', 'CPC', 'CPS'};
    clear cathist;
    cathist = zeros(size(records,2), size(types, 2));
    for j = 1:size(records,2)
        for k = 1:size(records{j},1)
            flag = 0;
            code = string(records{j}{k,2});
            type = code.char;
            type = type(1:3);
            for l = 1:length(types)
                if(strcmp(type, types{l}) == 1)
                    flag = 1;
                    cathist(j, l) = cathist(j, l) + 1; 
                    break;
                end
            end
            if flag == 0
                disp(['unknown type:', type]);
                break;
            end
        end
    end
end