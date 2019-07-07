function [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, similarity_threshold)
    
    max_values = get_max_values(case_library);
    
    retrieved_indexes = [];
    similarities = []; 
    
    %waitbar
    %f = waitbar(0,'1','Name','A calcular Similaridades...',...
        %'CreateCancelBtn','setappdata(gcbf,''cancealing'',1)');

    %setappdata(f,'cancealing',0);

    %steps = size(case_library,1);
    
    for i=1:size(case_library,1)
        
        weighting_factors = [1; 4; 4; 2; 4; 5; 3; 2];
        
        distances = zeros(1,8);
        
        distances(1,1) = calculate_absolute_distance(...
                                case_library{i,'Pregnancies'} / max_values('Pregnancies'), ...
                                new_case.Pregnancies / max_values('Pregnancies'));
                            
        if case_library{i,'Glucose'} > 0
            distances(1,2) = calculate_absolute_distance(...
                                case_library{i,'Glucose'} / max_values('Glucose'), ...
                                new_case.Glucose / max_values('Glucose'));
        end
        
        if case_library{i,'BloodPressure'} > 0
            distances(1,3) = calculate_absolute_distance( ...
                                case_library{i,'BloodPressure'} / max_values('BloodPressure'), ...
                                new_case.Glucose / max_values('BloodPressure'));
        end        
        
        if case_library{i,'SkinThickness'} > 0
            distances(1,4) = calculate_absolute_distance(...
                                case_library{i,'SkinThickness'} / max_values('SkinThickness'), ...
                                new_case.SkinThickness / max_values('SkinThickness'));
        end  
        
        if case_library{i,'Insulin'} >0
        distances(1,5) = calculate_absolute_distance(...
                                case_library{i,'Insulin'} / max_values('Insulin'), ...
                                new_case.Glucose / max_values('Insulin'));
        end
        
        if case_library{i,'BMI'} > 0
        distances(1,6) = calculate_absolute_distance(...
                                case_library{i,'BMI'} / max_values('BMI'), ...
                                new_case.BMI / max_values('BMI'));
        end
        
        if case_library{i,'DiabetesPedigreeFunction'} > 0
        distances(1,7) = calculate_absolute_distance(...
                                case_library{i,'DiabetesPedigreeFunction'} / max_values('DiabetesPedigreeFunction'), ...
                                new_case.DiabetesPedigreeFunction / max_values('DiabetesPedigreeFunction'));
        end
        
        distances(1,8) = calculate_absolute_distance(...
                                case_library{i,'Age'} / max_values('Age'), ...
                                new_case.Age / max_values('Age'));
                
                            
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
        
        %waitbar(i/steps,f,sprintf('%.0f de %.0f',i,size(case_library,1)));
        
        %fprintf('Case %d out of %d has a similarity of %.2f%%...\n', i, size(case_library,1), final_similarity*100);
    end
    %delete(f);
    
    %disp(max_values('Glucose'));
    %disp(max_values('Insulin'));
    %disp(max_values('BMI'));
    %disp(max_values('Age'));
end

function [max_values] = get_max_values(case_library)

    key_set = {'Pregnancies', ...
        'Glucose', ...
        'BloodPressure', ...
        'SkinThickness', ...
        'Insulin', ...
        'BMI', ...
        'DiabetesPedigreeFunction', ...
        'Age'};
    value_set = {max(case_library{:,'Pregnancies'}), ...
        max(case_library{:,'Glucose'}), ...
        max(case_library{:,'BloodPressure'}),...
        max(case_library{:,'SkinThickness'}),...
        max(case_library{:,'Insulin'}),...
        max(case_library{:,'BMI'}),...
        max(case_library{:,'DiabetesPedigreeFunction'}),...
        max(case_library{:,'Age'}),...
        };
    max_values = containers.Map(key_set, value_set);
end

function [res] = calculate_absolute_distance(val1, val2)

    diff = abs(val1 - val2);
    res = sum(diff)/length(diff);
end

