function [] = cbr()

    similarity_threshold = 0.6;
    formatSpec = '%f%f%f%f%f%f%f%f%f%f';
    
    tableLog = readtable('Historico.csv','Delimiter', ',','Format', ...
        formatSpec);
    
    formatSpec = '%f%f%f%f%f%f%f%f%f';
    
    case_library = readtable('TemaCBR_diabetes.csv', ...
        'Delimiter', ',', ...
        'Format', formatSpec);
    
    new_case.Pregnancies = 2;
    new_case.Glucose = 23;
    new_case.BloodPressure = 48;
    new_case.SkinThickness = 28;
    new_case.Insulin = 52;
    new_case.BMI = 17.2;
    new_case.DiabetesPedigreeFunction = 0.7;
    new_case.Age = 25;
    
    fprintf('\nA começar a fase de Retrieve...\n\n');
    
    [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, ...
                                    similarity_threshold);
    
    retrieved_cases = case_library(retrieved_indexes, :);
    
    retrieved_cases.Similarity = similarities';  
    
    fprintf('\nTerminou a fase de Retrieve...\n\n');
    
    disp(retrieved_cases);
    
    fprintf('\nA começar a fase de Reuse...\n\n');
    
    [new_outcome] = reuse(retrieved_cases, new_case);
    
    new_case.Outcome = new_outcome;

    fprintf('\n\nTérmino da fase de Reuse...\n');
    
    fprintf('\nA começar fase de Revise...\n\n');
    
    revise(new_case,tableLog);
    
    fprintf('\nTérmino da fase de Revise...\n');
    
    fprintf('\nTérmino do programa.\n\n');

end

