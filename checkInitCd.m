function ok = checkInitCd( initCd )
%myFun - Description
%
% Syntax: ok = checkInitCd( initCd )
%
% Long description

        ok = isstruct( initCd );
        if ok == false
                printf('the initial condition is not a structure!');
                return;
        end
        names = fieldnames( initCd );
        ok = (names(1) == 'vpX') && (names(2) == 'omgX') && (names(3) == 'omgY') && (names(4) == 'omgZ');
        if ok == false
                printf('the initial condition is not in a proper form!');
                return;
        end
        
end