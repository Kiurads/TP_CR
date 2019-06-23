function [outcome] = reuse(retrieved_cases, new_case)

    x1 = retrieved_cases{:,1}; % Pregnancies
    x2 = retrieved_cases{:,2}; % Glucose
    x3 = retrieved_cases{:,3}; % BloodPressure
    x4 = retrieved_cases{:,4}; % SkinThickness
    x5 = retrieved_cases{:,5}; % Insulin
    x6 = retrieved_cases{:,6}; % BMI
    x7 = retrieved_cases{:,7}; % DiabetesPedigreeFunction
    x8 = retrieved_cases{:,8}; % Age

    y = retrieved_cases{:,9};   %Outcome
    % y = y'
    % Multiple Regression
    % Adapted from https://www.mathworks.com/examples/matlab/mw/matlab-ex88655142-multiple-regression

    %Train
     X = [ones(size(x1)) x1 x2 x3 x4 x5 x6 x7 x8];
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
    outcome = b(1)+b(2)*new_case.Pregnancies+b(3)*new_case.Glucose+b(4)*new_case.BloodPressure+...
              b(5)*new_case.SkinThickness+b(6)*new_case.Insulin+b(7)*new_case.BMI + ...
              b(8)*new_case.DiabetesPedigreeFunction + b(9)*new_case.Age;

    fprintf('original value: %.3f\n', outcome);

    if outcome >= 0.5
        outcome = 1;
    else
        outcome =0;
    end
    fprintf(['Based on the attributes of the retrieved cases,\n', ...
                'the estimated outcome for the new case is %d\n'], outcome);


end

