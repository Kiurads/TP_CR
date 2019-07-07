function [new_case] = revise(new_case, outcome)

    fprintf('\nUpdate your patient outcome with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');

    if option == 'y' || option == 'Y'
        new_case.Outcome = outcome;
    end
end

