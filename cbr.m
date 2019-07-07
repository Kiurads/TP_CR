function [] = cbr()

    similarity_threshold = 0.75;
    option = 0;
    formatSpec = '%f%f%f%f%f%f%f%f%f%f';
    
    formatSpec = '%f%f%f%f%f%f%f%f%f';
    
    test_cases = readtable('TestCases.csv',...
        'Delimiter', ',', ...
        'Format', formatSpec);
    
    case_library = readtable('TemaCBR_diabetes_final.csv', ...
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

%     new_case.Pregnancies = 7;
%     new_case.Glucose = 195;
%     new_case.BloodPressure = 70;
%     new_case.SkinThickness = 33;
%     new_case.Insulin = 145;
%     new_case.BMI = 25.1;
%     new_case.DiabetesPedigreeFunction = 0.163;
%     new_case.Age = 55;

    for i=1:size(test_cases)
        
        new_case.Pregnancies = test_cases{i,'Pregnancies'};
        new_case.Glucose = test_cases{i,'Glucose'};
        new_case.BloodPressure = test_cases{i,'BloodPressure'};
        new_case.SkinThickness = test_cases{i,'SkinThickness'};
        new_case.Insulin = test_cases{i,'Insulin'};
        new_case.BMI = test_cases{i,'BMI'};
        new_case.DiabetesPedigreeFunction = test_cases{i,'DiabetesPedigreeFunction'};
        new_case.Age = test_cases{i,'Age'};
        new_case.Outcome = -1;
        
        fprintf('\nA come?ar a fase de Retrieve...\n\n');

        if option == 0
            [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, ...
                                        similarity_threshold);
                                    
            retrieved_cases = case_library(retrieved_indexes, :);
            
            disp(new_case);

            fprintf('\nTerminou a fase de Retrieve...\n\n');

            fprintf('\nA come?ar a fase de Reuse...\n\n');
            
            [new_outcome] = reuse(retrieved_cases, new_case);
            
            new_case.Outcome = new_outcome;
            
            fprintf('\n\nT?rmino da fase de Reuse...\n');

%             fprintf('\nA come?ar fase de Revise...\n\n');
%             
%             revise(new_case, new_outcome);
%             
%             fprintf('\nT?rmino da fase de Revise...\n');
%  
        else
            [retrieved_indexes, similarities, fuzzy_new] = retrieve_fuzzy(new_case, ...
                                        similarity_threshold, fuzzy_values);
            
            retrieved_cases = fuzzy_values(retrieved_indexes, :);
            
            disp(new_case);

            fprintf('\nTerminou a fase de Retrieve...\n\n');

            fprintf('\nA come?ar a fase de Reuse...\n\n');
            
            [new_outcome] = reuse_fuzzy(retrieved_cases, fuzzy_new);
            
            fuzzy_new.Outcome = new_outcome;
            
            fprintf('\n\nT?rmino da fase de Reuse...\n');

%             fprintf('\nA come?ar fase de Revise...\n\n');
%             
%             revise(fuzzy_new, new_outcome);
%             
%             fprintf('\nT?rmino da fase de Revise...\n');
        end
        
%         fprintf('\nA come?ar fase de Retain...\n\n');
%             
%         [case_library] = retain(case_library, new_case, i, test_cases);
%         
%         fprintf('\nT?rmino da fase de Retain...\n');
    end
    
    fprintf('\nT?rmino do programa.\n\n');
end

