function Results = Get1PointFi( Y, Z, initCd,flowModel )
%myFun - Description
%
% Syntax: Fi = Get1PointFi(info, flowModel)
%
% Long description
        Results = zeros(1,17);
        inputSize = size(initCd);
        if inputSize(1) ~= 5 || inputSize(2) ~= 1
                fprintf('the input Initial Condition vector is not well shaped')
                return
        end
        vPx_0    = initCd(1);
        omegaX_0 = initCd(2);
        omegaY_0 = initCd(3);
        omegaZ_0 = initCd(4);
        deltaT_0 = initCd(5);

        flowModel.param.set('Yp', Y);
        flowModel.param.set('Zp', Z);
        
        % bulid the geom and mesh according to particle's position
        flowModel.geom('geom1').run;
        % debug code block in order to show the appearance of geom and mesh
        % mphgeom(flowModel, 'geom1', 'facealpha', 0.5);
        % pause

        flowModel.mesh('mesh1').run;
        % debug code block in order to show the appearance of geom and mesh        
        % mphmesh(flowModel, 'mesh1', 'facealpha', 0.5);
        % pause

        % call the function to calculate the Fin
        [ ...,
                Results(1,3 ), ...,   % ifSuccess if calculation is successful
                Results(1,4 ), ...,   % Velocity_x_steadyState
                Results(1,5 ), ...,   % Omega_x_steadyState,
                Results(1,6 ), ...,   % Omega_y_steadyState,
                Results(1,7 ), ...,   % Omega_z_steadyState
                Results(1,8 ), ...,   % F_x,
                Results(1,9 ), ...,   % F_y,
                Results(1,10), ...,   % F_z,
                Results(1,11), ...,   % Torq_x,
                Results(1,12), ...,   % Torq_y,
                Results(1,13), ...,   % Torq_z,
                Results(1,14), ...,   % Acc_x,
                Results(1,15), ...,   % Acc_y,
                Results(1,16), ...,   % Acc_z,
                Results(1,17), ...,   % Alpha_x,
                Results(1,18), ...,   % Alpha_y,
                Results(1,19)  ...,   % Alpha_z
        ] ...,
        = ...,
        FiCalculation(vPx_0,omegaX_0,omegaY_0,omegaZ_0, deltaT_0,flowModel);

end