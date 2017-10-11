function setVpXOmg(VpXOmg, inputForm, flowModel)
%myFun - Description
%
% Syntax: setInitCd(initCd, inputForm, Model)
%
% Long description
        vpX = VpXOmg.vpX;
        omgX= VpXOmg.omgX;
        omgY= VpXOmg.omgY;
        omgZ= VpXOmg.omgZ;

        vpXStr        = [ num2str(vpX, inputForm), '[m/s]'];
        omgXStr       = [ num2str(omgX,inputForm), '[rad/s]'];
        omgYStr       = [ num2str(omgY,inputForm), '[rad/s]'];
        omgZStr       = [ num2str(omgZ,inputForm), '[rad/s]'];

        flowModel.param.set('Vp_x',    vpXStr );        
        flowModel.param.set('Omega_x', omgXStr);        
        flowModel.param.set('Omega_y', omgYStr);
        flowModel.param.set('Omega_z', omgZStr);
        
end