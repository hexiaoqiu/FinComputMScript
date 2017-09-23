function setVpOmg(initCd, inputForm, flowModel)
%myFun - Description
%
% Syntax: setInitCd(initCd, inputForm, Model)
%
% Long description
        Vp_x        = initCd(1,1);
        Omega_x     = initCd(1,2);
        Omega_y     = initCd(1,3);
        Omega_z     = initCd(1,4);    

        vStr        = [ num2str(Vp_x,   inputForm), '[m/s]'];
        omgXStr     = [ num2str(Omega_x,inputForm), '[rad/s]'];
        omgYStr     = [ num2str(Omega_y,inputForm), '[rad/s]'];
        omgZStr     = [ num2str(Omega_z,inputForm), '[rad/s]'];

        flowModel.param.set('Vp_x',    vStr   );        
        flowModel.param.set('Omega_x', omgXStr);        
        flowModel.param.set('Omega_y', omgYStr);
        flowModel.param.set('Omega_z', omgZStr);
        
end