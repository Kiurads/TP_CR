function [] = cbr()

    similarity_threshold = 0.6;
    formatSpec = '%f%f%f%f%f%f%f%f%f';
    
    case_library = readtable('TemaCBR_diabetes.csv', ...
        'Delimiter', ',', ...
        'Format', formatSpec)
    
%     % New case data
%     new_case.Suburb = 'Brighton';
%     new_case.Adress = '119 North Rd';
%     new_case.Rooms = 4.0;
%     new_case.Type = 'h';
%     new_case.Price = 3050000.0;
%     new_case.Method = 'SP';
%     new_case.SellerG = 'Buxton';
%     new_case.Date = '2017-02-25 00:00:00';
%     new_case.Distance = 11.2;
%     new_case.Postcode = 3186.0;
%     new_case.Bedroom2 = 10.0;
%     new_case.Bathroom = 6.0;
%     new_case.Car = 2.0;
%     new_case.Landsize = 578.0;
%     new_case.BuildingArea = 319.0;
%     new_case.YearBuilt = 1995.0;
%     new_case.Lattitude = -37.9;
%     new_case.Longtitude = 145.0;
%     new_case.RegionName = 'Southern Metropolitan';
%     new_case.PropertyCount = 10579.0;
%     %new_case.Mykey = 21260737.00;
%     if(Historico{end,'MyKey'}>case_library{end,'MyKey'})
%         new_case.MyKey = Historico{end,'MyKey'}+1;
%     else
%         new_case.MyKey = case_library{end,'MyKey'}+1;
%     end
%     new_case.CouncilArea = 'Bayside City Council';
%     
%     
%     fprintf('\nA come?ar a fase de Retrieve...\n\n');
%     
%     [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, similarity_threshold);
%     
%     retrieved_cases = case_library(retrieved_indexes, :);
%     
%     retrieved_cases.Similarity = similarities';
%     
%     fprintf('\nC?lculo dos Graus de Perten?a...\n\n');
%     
%     [retrieved_cases] = a(retrieved_cases); 
%     
%     fprintf('\nA Terminar o C?lculo dos Graus de Perten?a...\n\n');   
%     
%     fprintf('\nTerminou a fase de Retrieve...\n\n');
%     
%     disp(retrieved_cases);
%     
%     fprintf('\nA come?ar a fase de Reuse...\n\n');
%     
%     [new_price] = reuse(retrieved_cases,new_case,councilsLoc);
%     
%     new_case.Price = new_price;
% 
%     fprintf('\n\nT?rmino da fase de Reuse...\n');
%     
%     fprintf('\nA come?ar fase de Revise...\n\n');
%     
%     revise(new_case,tableLog);
%     
%     fprintf('\nT?rmino da fase de Revise...\n');
%     
%     fprintf('\nT?rmino do programa.\n\n');

end

