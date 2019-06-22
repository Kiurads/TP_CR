function [new_outcome] = reuse(retrieved_cases, new_case)

    max = 0;
    Msemelhante = retrieved_cases(1,:);
    
    f = waitbar(0,'1','Name','A calcular Caso mais semelhante...',...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

    setappdata(f,'canceling',0);

    steps = size(retrieved_cases,1);
    
    for i=1:size(retrieved_cases,1)
        if getappdata(f,'canceling')
            break
        end
        
        if(retrieved_cases{i,'Similarity'} > max)
            max = retrieved_cases{i,'Similarity'};
            Msemelhante = retrieved_cases(i,:);
        end 
        waitbar(i/steps,f,sprintf('%.0f de %.0f',i,size(retrieved_cases,1)));
    end  
    delete(f);
    new_outcome = Msemelhante{1, 'Outcome'};
    
    fprintf('Most similar case\n');
    disp(Msemelhante);

end

