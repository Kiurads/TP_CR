function [] = cbr()

    similarity_threshold = 0.6;
    option = 0;
    formatSpec = '%f%f%f%f%f%f%f%f%f%f';
    
    tableLog = readtable('Historico.csv','Delimiter', ',','Format', ...
        formatSpec);
    
    formatSpec = '%f%f%f%f%f%f%f%f%f';
    
    case_library = readtable('TemaCBR_diabetes.csv', ...
        'Delimiter', ',', ...
        'Format', formatSpec);
    
     fprintf('Use Fuzzy Logic? (y/n)\n');
     option = input('Option: ', 's');
     
     if option == 'y' || option == 'Y'
         fuzzy_values = getFuzzy(case_library);
         option = 1;
     else
         option = 0;
     end
        
%     fprintf('How many pregnancies?\n');
%     new_case.Pregnancies = input('Option: ');
%     
%     fprintf('Glucose Levels?\n');
%     new_case.Glucose = input('Option: ');
%     
%     fprintf('Blood Pressure?\n');
%     new_case.BloodPressure = input('Option: ');
%     
%     fprintf('Skin Thickness?\n');
%     new_case.SkinThickness = input('Option: ');
%     
%     fprintf('Insulin Levels?\n');
%     new_case.Insulin = input('Option: ');
%     
%     fprintf('BMI?\n');
%     new_case.BMI = input('Option: ');
%     
%     fprintf('Diabetes Pedigree Function?\n');
%     new_case.DiabetesPedigreeFunction = input('Option: ');
%     
%     fprintf('Age?\n');
%     new_case.Age = input('Option: ');

    new_case.Pregnancies = 2;
    new_case.Glucose = 20;
    new_case.BloodPressure = 20;
    new_case.SkinThickness = 18;
    new_case.Insulin = 20;
    new_case.BMI = 15;
    new_case.DiabetesPedigreeFunction = 0.7;
    new_case.Age = 60;

    fprintf('\nA come�ar a fase de Retrieve...\n\n');
    
    if option == 0
        [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, ...
                                    similarity_threshold);
    else
        [retrieved_indexes, similarities, fuzzy_new] = retrieve_fuzzy(new_case, ...
                                    similarity_threshold, fuzzy_values);
    end
    
    if option == 0
        retrieved_cases = case_library(retrieved_indexes, :);
    else
        retrieved_cases = fuzzy_values(retrieved_indexes, :);
    end
    
    retrieved_cases.Similarity = similarities';  
    
    fprintf('\nTerminou a fase de Retrieve...\n\n');
    
    disp(retrieved_cases);
    
    fprintf('\nA come�ar a fase de Reuse...\n\n');
    
if option == 0
    [new_outcome] = reuse(retrieved_cases, new_case);
    new_case.Outcome = new_outcome;
else
    [new_outcome] = reuse_fuzzy(retrieved_cases, fuzzy_new);
    fuzzy_new.Outcome = new_outcome;
end
    
    fprintf('\n\nT�rmino da fase de Reuse...\n');
    
    fprintf('\nA come�ar fase de Revise...\n\n');
    
if option == 0
    revise(new_case,tableLog);
else
    revise(fuzzy_new,tableLog);
end
    
    fprintf('\nT�rmino da fase de Revise...\n');
    
    fprintf('\nT�rmino do programa.\n\n');

end

