function ok = checkConvergency(index, theCase)
%myFun - Description
%
% Syntax: ok = checkConvergency(index, theCase)
%
% Long description
        % the convergency criterion
        if ( theCase.varFyHstry(index) < 1e-3 )&&( theCase.varFzHstry(index) < 1e-3 )
                
                fprintf('the loop converges! Good convergency criterion reached! \n');
                fprintf('It takes %d iterations to reach the convergency! \n', index );                
                ok = true;
        else
                ok = false;
        end
end