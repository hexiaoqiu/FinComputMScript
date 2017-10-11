function outputInfo( fM )
%myFun - Description
%
% Syntax: outputInfo( fM)
%
% Long description
        
        fprintf('\n');
        fprintf('*************--------> INFO OUTPUT <--------------***************** \n');
        fprintf('------------> In COMSOL \n')
        fprintf('| Yp is     %s \n', char( fM.mphModel.param.get('Yp')    ) );
        fprintf('| Zp is     %s \n', char( fM.mphModel.param.get('Zp')    ) );        
        fprintf('| Vp_x is     %s \n', char( fM.mphModel.param.get('Vp_x')    ) );
        fprintf('| Omega_X is  %s \n', char( fM.mphModel.param.get('Omega_x') ) );
        fprintf('| Omega_Y is  %s \n', char( fM.mphModel.param.get('Omega_y') ) );
        fprintf('| Omega_Z is  %s \n', char( fM.mphModel.param.get('Omega_z') ) );
        fprintf('------------> In flow Model Class \n')
        fprintf('|yP      = %d[m]           |zP      = %d[m] \n',   fM.yP,  fM.zP ); 
        fprintf('|Vp_x    = %6.5e[m/s]   \n', fM.vpX);
        fprintf('|omgX    = %6.5e[rad/s]     |omgZ    = %6.5e[rad/s]        |omgY    = %6.5e[rad/s] \n',  fM.omega.x, fM.omega.y, fM.omega.z);
        fprintf('|Fx      = %6.5e[N]         |Fy      = %6.5e[N]            |Fz      = %6.5e[N] \n',      fM.force.x,fM.force.y,fM.force.z);
        fprintf('|accX    = %6.5e[N]         |accY    = %6.5e[N]            |accZ    = %6.5e[N] \n',      fM.acc.x,fM.acc.y,fM.acc.z);
        fprintf('|torqueX = %6.5e[N]         |torqueY = %6.5e[N]            |torqueZ = %6.5e[N] \n',      fM.tau.x,fM.tau.y,fM.tau.z);
        fprintf('|alphaX  = %6.5e[N]         |alphaY  = %6.5e[N]            |alphaZ  = %6.5e[N] \n',      fM.alpha.x,fM.alpha.y,fM.alpha.z);
        fprintf('\n');


        
end