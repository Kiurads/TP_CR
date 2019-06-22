function revise(new_case, tableLog)
    
%     criar nova coluna para novo campo
    nomes = {'Added'};
    column = cell2table(cell(1,1),'VariableNames',nomes);

    disp(new_case)
%     adicionar nova coluna ao caso a adicionar para ficar compativel
    Names = {'Pregnancies', ...
        'Glucose', ...
        'BloodPressure', ...
        'SkinThickness', ...
        'Insulin', ...
        'BMI', ...
        'DiabetesPedigreeFunction', ...
        'Age', ...
        'Outcome', ...
        'Added'};
    new_case = struct2table(new_case);
    new_case = [new_case column];
    new_case.Properties.VariableNames = Names;
    new_case.Added = 0.0;
    
    tableLog = [tableLog;new_case]; % adiciona nova linha a tabela
    
    writetable(tableLog,'Historico.csv');
    
    disp(new_case);
    disp(tableLog);
end

