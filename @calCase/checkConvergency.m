function ok = checkConvergency( theCase )
%myFun - Description
%
% Syntax: ok = checkConvergency(index, theCase)
%
% Long description
        % the convergency criterion
        if ( theCase.varFyHstry(theCase.index) < 1e-3 )&&( theCase.varFzHstry(theCase.index) < 1e-3 )
                
                fprintf('the loop converges! Good convergency criterion reached! \n');
                fprintf('It takes %d iterations to reach the convergency! \n', theCase.index );                
                ok = true;
        else
                ok = false;
        end
end