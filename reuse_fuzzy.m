function [outcome] = reuse_fuzzy(retrieved_cases, new_case)

    x1 = retrieved_cases{:,1}; % Pregnancies1
    x2 = retrieved_cases{:,2}; % Pregnancies2
    x3 = retrieved_cases{:,3}; % Pregnancies3
    x4 = retrieved_cases{:,4}; % Glucose1
    x5 = retrieved_cases{:,5}; % Glucose2
    x6 = retrieved_cases{:,6}; % Glucose3
    x7 = retrieved_cases{:,7}; % BloodPressure1
    x8 = retrieved_cases{:,8}; % BloodPressure2
    x9 = retrieved_cases{:,9}; % BloodPressure3
    x10 = retrieved_cases{:,10}; % BloodPressure4
    x11 = retrieved_cases{:,11}; % SkinThickness1
    x12 = retrieved_cases{:,12}; % SkinThickness2
    x13 = retrieved_cases{:,13}; % Insulin1
    x14 = retrieved_cases{:,14}; % Insulin2
    x15 = retrieved_cases{:,15}; % Insulin3
    x16 = retrieved_cases{:,16}; % BMI1
    x17 = retrieved_cases{:,17}; % BMI2
    x18 = retrieved_cases{:,18}; % BMI3
    x19 = retrieved_cases{:,19}; % DiabetesPedigreeFunction1
    x20 = retrieved_cases{:,20}; % DiabetesPedigreeFunction2
    x21 = retrieved_cases{:,21}; % DiabetesPedigreeFunction3
    x22 = retrieved_cases{:,22}; % Age1
    x23 = retrieved_cases{:,23}; % Age2
    x24 = retrieved_cases{:,24}; % Age3
    x25 = retrieved_cases{:,25}; % Age4

    y = retrieved_cases{:,26};   %Outcome
    % y = y'
    % Multiple Regression
    % Adapted from https://www.mathworks.com/examples/matlab/mw/matlab-ex88655142-multiple-regression

    %Train
     X = [ones(size(x1)) x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25];
     %X = [ones(size(x2)) x1 x2 x5];
     %y = y';
     for i=1:size(y)
         if(y(i)==1)
             y(i) = 0.9999;
         else
             y(i) = 0.0001;
         end
     end
     %y = y';
     b = X\y;

    %fprintf('%d  |  %d',size(X),size(y));
    outcome =  b(1)...
              +b(2)*new_case.pregnan_low+b(3)*new_case.pregnan_med+b(4)*new_case.pregnan_high...
              +b(5)*new_case.glucose_low+b(6)*new_case.glucose_med+b(7)*new_case.glucose_high...
              +b(8)*new_case.press_low+b(9)*new_case.press_med+b(10)*new_case.press_high+b(11)*new_case.press_crit...
              +b(12)*new_case.thick_low+b(13)*new_case.thick_high...
              +b(14)*new_case.insulin_low+b(15)*new_case.insulin_med+b(16)*new_case.insulin_high...
              +b(17)*new_case.BMI_low+b(18)*new_case.BMI_med+b(19)*new_case.BMI_high... 
              +b(20)*new_case.pedigree_low+b(21)*new_case.pedigree_med+b(22)*new_case.pedigree_high...
              +b(23)*new_case.Age_young+b(24)*new_case.Age_youngadult+b(25)*new_case.Age_adult+b(26)*new_case.Age_elder;
              
    fprintf('original value: %.3f\n', outcome);

    if outcome >= 0.5
        outcome = 1;
    else
        outcome =0;
    end
    fprintf(['Based on the attributes of the retrieved cases,\n', ...
                'the estimated outcome for the new case is %d\n'], outcome);


end

