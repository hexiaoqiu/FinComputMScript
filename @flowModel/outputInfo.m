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
        fprintf('|omgX    = %6.5e[rad/s]     |omgZ    = %6.5e[rad/s]        |omgY    = %6.5e[rad/s] \n',  fM.omega(1), fM.omega(2), fM.omega(3));
        fprintf('|Fx      = %6.5e[N]         |Fy      = %6.5e[N]            |Fz      = %6.5e[N] \n',      fM.force(1),fM.force(2),fM.force(3));
        fprintf('|accX    = %6.5e[N]         |accY    = %6.5e[N]            |accZ    = %6.5e[N] \n',      fM.acc(1),fM.acc(2),fM.acc(3));
        fprintf('|torqueX = %6.5e[N]         |torqueY = %6.5e[N]            |torqueZ = %6.5e[N] \n',      fM.tau(1),fM.tau(2),fM.tau(3));
        fprintf('|alphaX  = %6.5e[N]         |alphaY  = %6.5e[N]            |alphaZ  = %6.5e[N] \n',      fM.alpha(1),fM.alpha(2),fM.alpha(3));
        fprintf('\n');


        
end