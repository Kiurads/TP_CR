function [] = cbr()

    formatSpec = '%f%f%f%f%f%f%f%f%f';
    
    case_library = readtable('TemaCBR_diabetes.csv', ...
        'Delimiter', ',', ...
        'Format', formatSpec)
    
    new_case.Pregnancies = 1;
    new_case.Glucose = 96;
    new_case.BloodPressure = 85;
    new_case.SkinThickness = 35;
    new_case.Insulin = 230;
    new_case.BMI = 32.7;
    new_case.DiabetesPedigreeFunction = 0.245;
    new_case.Age = 42;
    
    fprintf('\nA come�ar a fase de Retrieve...\n\n');
    
%     [retrieved_indexes, new_case] = retrieve(case_library, new_case);
    
%     retrieved_cases = case_library(retrieved_indexes, :);
    
    fprintf('\nC�lculo dos Graus de Perten�a...\n\n');
    
%     [retrieved_cases] = a(retrieved_cases); 
    
    fprintf('\nA Terminar o C�lculo dos Graus de Perten�a...\n\n');   
    
    fprintf('\nTerminou a fase de Retrieve...\n\n');
    
%     disp(retrieved_cases);
    
    fprintf('\nA come�ar a fase de Reuse...\n\n');
    
%     [new_outcome] = reuse(retrieved_cases, new_case);
    
%     new_case.Outcome = new_outcome;

    fprintf('\n\nT�rmino da fase de Reuse...\n');
    
    fprintf('\nA come�ar fase de Revise...\n\n');
    
%     revise(new_case,tableLog);
    
    fprintf('\nT�rmino da fase de Revise...\n');
    
    fprintf('\nT�rmino do programa.\n\n');

end

