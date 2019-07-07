
function [retrieved_indexes, similarities, fuzzy_new] = retrieve_fuzzy(new_case,...
    similarity_threshold, fuzify_library)
    
    fuzzy_new = fuzify_new(new_case);
    
    retrieved_indexes = [];
    similarities = []; 
    
    %waitbar
    %f = waitbar(0,'1','Name','A calcular Similaridades...',...
        %'CreateCancelBtn','setappdata(gcbf,''cancealing'',1)');

    %setappdata(f,'cancealing',0);

    %steps = size(fuzify_library,1);
    
    for i=1:size(fuzify_library,1)
        
        weighting_factors = [1; 1; 1; ... %pregnancies
                         4; 4; 4; ... %glucose
                         4; 4; 4; 4; ... %pressure
                         2; 2; ... %thickness
                         4; 4; 4; ... %insulin
                         5; 5; 5; ... %BMI
                         3; 3; 3; ... %pedigree
                         2; 2; 2; 2]; %age
                     
        distances = zeros(1,25);
        
        
        distances(1,1) = calculate_absolute_distance(fuzify_library{i,'pregnan_low'}, fuzzy_new.pregnan_low);
        distances(1,2) = calculate_absolute_distance(fuzify_library{i,'pregnan_med'}, fuzzy_new.pregnan_med);
        distances(1,3) = calculate_absolute_distance(fuzify_library{i,'pregnan_high'}, fuzzy_new.pregnan_med);
        
        
        if (fuzify_library{i,'glucose_low'} == 0 ...
                    && fuzify_library{i,'glucose_med'} == 0 ...
                    && fuzify_library{i,'glucose_high'} == 0) ...
                    || (fuzzy_new.glucose_low == 0 ...
                    && fuzzy_new.glucose_med == 0 ...
                    && fuzzy_new.glucose_high == 0)
            distances(1,4) = 0;
            distances(1,5) = 0;
            distances(1,6) = 0;
        else
            distances(1,4) = calculate_absolute_distance(fuzify_library{i,'glucose_low'}, fuzzy_new.glucose_low);
            distances(1,5) = calculate_absolute_distance(fuzify_library{i,'glucose_med'}, fuzzy_new.glucose_med);
            distances(1,6) = calculate_absolute_distance(fuzify_library{i,'glucose_high'}, fuzzy_new.glucose_high);
        end
        
        if (fuzify_library{i,'press_low'} == 0 ...
                && fuzify_library{i,'press_med'} == 0 ...
                && fuzify_library{i,'press_high'} == 0 ...
                && fuzify_library{i,'press_crit'} == 0) ...
                || (fuzzy_new.press_low == 0 ...
                && fuzzy_new.press_med == 0 ...
                && fuzzy_new.press_high == 0)
            
            distances(1,7) = 0;
            distances(1,8) = 0;
            distances(1,9) = 0;
            distances(1,10) = 0;
        else
            distances(1,7) = calculate_absolute_distance(fuzify_library{i,'press_low'}, fuzzy_new.press_low);
            distances(1,8) = calculate_absolute_distance(fuzify_library{i,'press_med'}, fuzzy_new.press_med);
            distances(1,9) = calculate_absolute_distance(fuzify_library{i,'press_high'}, fuzzy_new.press_high);
            distances(1,10) = calculate_absolute_distance(fuzify_library{i,'press_crit'}, fuzzy_new.press_crit);
        end
        
        if (fuzify_library{i,'thick_low'} == 0 ...
                && fuzify_library{i,'thick_high'} == 0) ...
                || (fuzzy_new.thick_low == 0 ...
                && fuzzy_new.thick_high == 0)
            distances(1,11) = 0;
            distances(1,12) = 0;
        else
            distances(1,11) = calculate_absolute_distance(fuzify_library{i,'thick_low'}, fuzzy_new.thick_low);
            distances(1,12) = calculate_absolute_distance(fuzify_library{i,'thick_high'}, fuzzy_new.thick_high);
        end
        
        if (fuzify_library{i,'insulin_low'} == 0 ...
                && fuzify_library{i,'insulin_med'} == 0 ...
                && fuzify_library{i,'insulin_high'} == 0)...
                || (fuzzy_new.insulin_low == 0 ...
                && fuzzy_new.insulin_med == 0 ...
                && fuzzy_new.insulin_high == 0)
            
            distances(1,13) = 0;
            distances(1,14) = 0;
            distances(1,15) = 0;
        else
            distances(1,13) = calculate_absolute_distance(fuzify_library{i,'insulin_low'}, fuzzy_new.insulin_low);
            distances(1,14) = calculate_absolute_distance(fuzify_library{i,'insulin_med'}, fuzzy_new.insulin_med);
            distances(1,15) = calculate_absolute_distance(fuzify_library{i,'insulin_high'}, fuzzy_new.insulin_high);
        end
        
        if (fuzify_library{i,'BMI_low'} == 0 ...
                && fuzify_library{i,'BMI_med'} == 0 ...
                && fuzify_library{i,'BMI_high'} == 0) ...
                || (fuzzy_new.BMI_low == 0 ...
                && fuzzy_new.BMI_med == 0 ...
                && fuzzy_new.BMI_high == 0)
            distances(1,16) = 0;
            distances(1,17) = 0;
            distances(1,18) = 0;
        else
            distances(1,16) = calculate_absolute_distance(fuzify_library{i,'BMI_low'}, fuzzy_new.BMI_low);
            distances(1,17) = calculate_absolute_distance(fuzify_library{i,'BMI_med'}, fuzzy_new.BMI_med);
            distances(1,18) = calculate_absolute_distance(fuzify_library{i,'BMI_high'}, fuzzy_new.BMI_high);
        end
        
        
        distances(1,19) = calculate_absolute_distance(fuzify_library{i,'pedigree_low'}, fuzzy_new.pedigree_low);
        distances(1,20) = calculate_absolute_distance(fuzify_library{i,'pedigree_med'}, fuzzy_new.pedigree_med);
        distances(1,21) = calculate_absolute_distance(fuzify_library{i,'pedigree_high'}, fuzzy_new.pedigree_high);
        
        distances(1,22) = calculate_absolute_distance(fuzify_library{i,'Age_young'}, fuzzy_new.Age_young);
        distances(1,23) = calculate_absolute_distance(fuzify_library{i,'Age_youngadult'}, fuzzy_new.Age_youngadult);
        distances(1,24) = calculate_absolute_distance(fuzify_library{i,'Age_adult'}, fuzzy_new.Age_adult);
        distances(1,25) = calculate_absolute_distance(fuzify_library{i,'Age_elder'}, fuzzy_new.Age_elder);
        
        for j=1:size(distances)
            if distances(1,j) == 0
                weighing_factors(j) = 0;
            end
        end
        
        final_similarity = 1 - ((distances * weighting_factors) / sum(weighting_factors));
        %subtrair 1 para converter asemelhan?a em semelhan?a
        
        if final_similarity >= similarity_threshold
            retrieved_indexes = [retrieved_indexes i];
            similarities = [similarities final_similarity];
        end
        
        %waitbar(i/steps,f,sprintf('%.0f de %.0f',i,size(fuzify_library,1)));
        
        %fprintf('Case %d out of %d has a similarity of %.2f%%...\n', i, size(fuzify_library,1), final_similarity*100);
    end
    %delete(f);
end


function [res] = calculate_absolute_distance(val1, val2)
    diff = abs(val1 - val2);
    res = sum(diff)/length(diff);
end

function [fuzzy_new] = fuzify_new(new_case)
                    
        if new_case.DiabetesPedigreeFunction <= 0
            fuzified_pedigree = [0 0 0];
        else
            fuzified_pedigree = [gaussmf(new_case.DiabetesPedigreeFunction,[0.2 0.275]) ...
                                 gaussmf(new_case.DiabetesPedigreeFunction,[0.2 1]) ...
                                 gaussmf(new_case.DiabetesPedigreeFunction,[0.2 2])];
        end
           
        
        fuzified_preg = [gaussmf(new_case.Pregnancies,[1.5 2.5]) ... 
                         gaussmf(new_case.Pregnancies,[1.5 7.5]) ...
                         gaussmf(new_case.Pregnancies,[1.5 15])];
        
        if new_case.Glucose <= 0
            fuzified_glucose = [0 0 0];
        else
            fuzified_glucose = [gaussmf(new_case.Glucose, [30 50]) ...
                                gaussmf(new_case.Glucose, [30 132]) ...
                                gaussmf(new_case.Glucose, [30, 200])];
        end 
        
        if new_case.BloodPressure <= 0
            fuzified_press = [0 0 0 0];
        else
            fuzified_press = [gaussmf(new_case.BloodPressure,[10 40]) ...
                              gaussmf(new_case.BloodPressure,[10 70]) ...
                              gaussmf(new_case.BloodPressure,[10 85]) ...
                              gaussmf(new_case.BloodPressure,[10 107])];
        end
        
        if new_case.SkinThickness <= 0
            fuzified_thick = [0 0];
        else
            fuzified_thick = [gaussmf(new_case.SkinThickness,[10 17.5]) ...
                              gaussmf(new_case.SkinThickness,[10 50])];
        end
        
        if new_case.Insulin <= 0
            fuzified_insulin = [0 0 0];
        else
            fuzified_insulin = [gaussmf(new_case.Insulin, [200 10]) ...
                                gaussmf(new_case.Insulin, [200 450]) ...
                                gaussmf(new_case.Insulin, [200 900])];
        end        
        
        if new_case.BMI <= 0
            fuzified_bmi = [0 0 0];
        else
            fuzified_bmi = [gaussmf(new_case.BMI, [1.5 21.5]) ...
                            gaussmf(new_case.BMI, [1.5 27]) ...
                            gaussmf(new_case.BMI, [1.5 32.5])];
        end
        
        fuzified_age = [gaussmf(new_case.Age, [10.35 21]) ...
                        gaussmf(new_case.Age, [10.35 44]) ...
                        gaussmf(new_case.Age, [10.35 67]) ...
                        gaussmf(new_case.Age, [10.35 90])];
                
     fuzzy_new.pregnan_low = fuzified_preg(1);
     fuzzy_new.pregnan_med = fuzified_preg(2);
     fuzzy_new.pregnan_high = fuzified_preg(3);
     
     fuzzy_new.glucose_low = fuzified_glucose(1);
     fuzzy_new.glucose_med = fuzified_glucose(2);
     fuzzy_new.glucose_high = fuzified_glucose(3);
     
     fuzzy_new.press_low = fuzified_press(1);
     fuzzy_new.press_med = fuzified_press(2);
     fuzzy_new.press_high = fuzified_press(3);
     fuzzy_new.press_crit = fuzified_press(4);
     
     fuzzy_new.thick_low = fuzified_thick(1);
     fuzzy_new.thick_high = fuzified_thick(2);
     
     fuzzy_new.insulin_low = fuzified_insulin(1);
     fuzzy_new.insulin_med = fuzified_insulin(2);
     fuzzy_new.insulin_high = fuzified_insulin(3);
     
     fuzzy_new.BMI_low = fuzified_bmi(1);
     fuzzy_new.BMI_med = fuzified_bmi(2);
     fuzzy_new.BMI_high = fuzified_bmi(3);
     
     fuzzy_new.pedigree_low = fuzified_pedigree(1);
     fuzzy_new.pedigree_med = fuzified_pedigree(2);
     fuzzy_new.pedigree_high = fuzified_pedigree(3);
     
     fuzzy_new.Age_young = fuzified_age(1);
     fuzzy_new.Age_youngadult = fuzified_age(2);
     fuzzy_new.Age_adult = fuzified_age(3);
     fuzzy_new.Age_elder = fuzified_age(4);
end

