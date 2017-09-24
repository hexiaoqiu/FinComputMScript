function outputInfo(flowModel, index)
%myFun - Description
%
% Syntax: outputInfo( flowModel)
%
% Long description
        Vp_x = flowModel.param.evaluate('Vp_x');
        Vp_y = flowModel.param.evaluate('Vp_y');
        Vp_z = flowModel.param.evaluate('Vp_z');
        Omega_x = flowModel.param.evaluate('Omega_x');
        Omega_y = flowModel.param.evaluate('Omega_y');
        Omega_z = flowModel.param.evaluate('Omega_z');
        Xp = flowModel.param.evaluate('Xp');
        Yp = flowModel.param.evaluate('Yp');
        Zp = flowModel.param.evaluate('Zp');
        Rp = flowModel.param.evaluate('Rp');

        [ ...,
         Fx,   Fy,   Fz,   torqueX, torqueY, torqueZ, ...,
         accX, accY, accZ, alphaX,  alphaY,  alphaZ ...,
        ] ...,
        = mphglobal(flowModel, ...,
            { ...,
              'Fx',   'Fy',   'Fz',   'tau_x', 'tau_y', 'tau_z', ...,
              'accX', 'accY', 'accZ', 'alphaX',  'alphaY',  'alphaZ' ...,
            }...,
        );

        Xp = Xp * 1e6;
        Yp = Yp * 1e6;
        Zp = Zp * 1e6;
        
        fprintf('\n');
        fprintf('*************--------> INFO OUTPUT <--------------***************** \n');
        fprintf('----------> %d th Iteration Finished \n',                index);
        fprintf('|Yp      = %d[um]           |Zp      = %d[um] \n',   Yp,  Zp ); 
        fprintf('|Xp      = %d[um]           |Rp      = %6.5e[m] \n', Xp,  Rp );
        fprintf('|Vp_x    = %6.5e[m/s]       |Vp_y    = %6.5e[m/s]          |Vp_z    = %6.5e[m/s]   \n',  Vp_x, Vp_y, Vp_z);
        fprintf('|omgX    = %6.5e[rad/s]     |omgZ    = %6.5e[rad/s]        |omgY    = %6.5e[rad/s] \n',  Omega_x, Omega_y, Omega_z);
        fprintf('|Fx      = %6.5e[N]         |Fy      = %6.5e[N]            |Fz      = %6.5e[N] \n',      Fx, Fy, Fz);
        fprintf('|accX    = %6.5e[N]         |accY    = %6.5e[N]            |accZ    = %6.5e[N] \n',      accX, accY, accZ);
        fprintf('|torqueX = %6.5e[N]         |torqueY = %6.5e[N]            |torqueZ = %6.5e[N] \n',      torqueX, torqueY, torqueZ);
        fprintf('|alphaX = %6.5e[N]          |alphaY  = %6.5e[N]            |alphaZ  = %6.5e[N] \n',      alphaX, alphaY, alphaZ);
        fprintf('|The Inserted Vp_x is     %s \n', char( flowModel.param.get('Vp_x')    ) );
        fprintf('|The Inserted Omega_X is  %s \n', char( flowModel.param.get('Omega_x') ) );
        fprintf('|The Inserted Omega_Y is  %s \n', char( flowModel.param.get('Omega_y') ) );
        fprintf('|The Inserted Omega_Z is  %s \n', char( flowModel.param.get('Omega_z') ) );
        fprintf('\n');

        
end