function [fuzzy_library] = getFuzzy(case_library)

    fuzzy_values = [];
    pedigree_low = [];
    pedigree_med = [];
    pedigree_high = [];
    pregnan_low = [];
    pregnan_med = [];
    pregnan_high = [];
    press_low = [];
    press_med = [];
    press_high = [];
    press_crit = [];
    thick_low = [];
    thick_high = [];
    glucose_low = [];
    glucose_med = [];
    glucose_high = [];
    insulin_low = [];
    insulin_med = [];
    insulin_high = [];
    BMI_low = [];
    BMI_med = [];
    BMI_high = [];
    Age_young = [];
    Age_youngadult = [];
    Age_adult = [];
    Age_elder = [];
    Outcome = [];

    for i=1:size(case_library,1)
        
        fuzified_pedigree = [gaussmf(case_library{i,'DiabetesPedigreeFunction'},[0.2 0.275]) ...
                          gaussmf(case_library{i,'DiabetesPedigreeFunction'},[0.2 1]) ...
                          gaussmf(case_library{i,'DiabetesPedigreeFunction'},[0.2 2])];
                      
        fuzified_preg = [gaussmf(case_library{i,'Pregnancies'},[1.5 2.5]) ... 
                       gaussmf(case_library{i,'Pregnancies'},[1.5 7.5]) ...
                       gaussmf(case_library{i,'Pregnancies'},[1.5 15])];
        
        fuzified_glucose = [gaussmf(case_library{i,'Glucose'}, [30 50]) ...
                            gaussmf(case_library{i,'Glucose'}, [30 132]) ...
                            gaussmf(case_library{i,'Glucose'}, [30, 200])];
                        
        fuzified_press = [gaussmf(case_library{i,'BloodPressure'},[10 40]) ...
                        gaussmf(case_library{i,'BloodPressure'},[10 70]) ...
                        gaussmf(case_library{i,'BloodPressure'},[10 85]) ...
                        gaussmf(case_library{i,'BloodPressure'},[10 107])];
                        
        fuzified_thick = [gaussmf(case_library{i,'SkinThickness'},[10 17.5]) ...
                        gaussmf(case_library{i,'SkinThickness'},[10 50])];
                        
        fuzified_insulin = [gaussmf(case_library{i,'Insulin'}, [200 10]) ...
                            gaussmf(case_library{i,'Insulin'}, [200 450]) ...
                            gaussmf(case_library{i,'Insulin'}, [200 900])];
                        
        fuzified_bmi = [gaussmf(case_library{i,'BMI'}, [1.5 21.5]) ...
                        gaussmf(case_library{i,'BMI'}, [1.5 27]) ...
                        gaussmf(case_library{i,'BMI'}, [1.5 32.5])];
                    
        fuzified_age = [gaussmf(case_library{i,'Age'}, [10.35 21]) ...
                        gaussmf(case_library{i,'Age'}, [10.35 44]) ...
                        gaussmf(case_library{i,'Age'}, [10.35 67]) ...
                        gaussmf(case_library{i,'Age'}, [10.35 90])];
        
        glucose_low = [fuzified_glucose(1); glucose_low];
        glucose_med = [fuzified_glucose(2); glucose_med];
        glucose_high = [fuzified_glucose(3); glucose_high];
        
        insulin_low = [fuzified_insulin(1); insulin_low];
        insulin_med = [fuzified_insulin(2); insulin_med];
        insulin_high = [fuzified_insulin(3); insulin_high];
        
        BMI_low = [fuzified_bmi(1); BMI_low];
        BMI_med = [fuzified_bmi(2); BMI_med];
        BMI_high = [fuzified_bmi(3); BMI_high];
        
        Age_young = [fuzified_age(1); Age_young];
        Age_youngadult = [fuzified_age(2); Age_youngadult];
        Age_adult = [fuzified_age(3); Age_adult];
        Age_elder = [fuzified_age(4); Age_elder];
        
        pedigree_low = [fuzified_pedigree(1); pedigree_low];
        pedigree_med = [fuzified_pedigree(2); pedigree_med];
        pedigree_high = [fuzified_pedigree(3); pedigree_high];
        
        pregnan_low = [fuzified_preg(1); pregnan_low];
        pregnan_med = [fuzified_preg(2); pregnan_med];
        pregnan_high = [fuzified_preg(3); pregnan_high];
        
        press_low = [fuzified_press(1); press_low];
        press_med = [fuzified_press(2); press_med];
        press_high = [fuzified_press(3); press_high];
        press_crit = [fuzified_press(4); press_crit];
        
        thick_low = [fuzified_thick(1); thick_low];
        thick_high = [fuzified_thick(2); thick_high];
        
        Outcome = [case_library{i,'Outcome'}; Outcome];
    end
    fuzzy_library = table(pregnan_low,pregnan_med,pregnan_high,...
        glucose_low,glucose_med,glucose_high,...
        press_low,press_med,press_high,press_crit,...
        thick_low,thick_high,...
        insulin_low,insulin_med,insulin_high,...
        BMI_low,BMI_med,BMI_high,...
        pedigree_low,pedigree_med,pedigree_high,...
        Age_young,Age_youngadult,Age_adult, Age_elder,...
        Outcome);
    %writetable(fuzzy_table,'Teste.csv');
end
    