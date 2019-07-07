function [case_library] = retain_fuzzy(case_library, new_case, index, test_cases)

    new_row = {new_case.Pregnancies, new_case.Glucose, new_case.BloodPressure, new_case.SkinThickness, new_case.Insulin, ...
               new_case.BMI, new_case.DiabetesPedigreeFunction, new_case.Age, new_case.Outcome};
            
    fprintf('Add the new case to the library? (y/n)\n');
    option = input('Option: ', 's');

    if option == 'y' || option == 'Y'    
        
        Tnew = [case_library; new_row];
        
        writetable(Tnew, 'TemaCBR_diabetes_final.csv');
        
        test_cases(index, :) = [];
        
        writetable(test_cases, 'TestCases.csv');
        
    end
end

