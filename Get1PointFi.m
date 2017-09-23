function Results = Get1PointFi( Y, Z, initCd, timeStep, flowModel )
% Get1PointFi - Description
%
% Syntax: Results = Get1PointFi(Y, Z, initCd, flowModel)
% input arguments list:
%               Y               Y coordinate of the particle
%               Z               Z coordinate of the particle
%               initCd          initial conditioan a array of (1,4) contains the first guess of dynamic coefs 
%                               of particle and time step for persudo time iteration
%               timeStep        the time step for loop
%               flowModel       the COMSOL model manipulated
% output arguments:
%               Results         a array of (1,17)
%               Results(1,1 )   ifSuccess if calculation is successful
%               Results(1,2 )   Velocity_x_steadyState
%               Results(1,3 )   Omega_x_steadyState,
%               Results(1,4 )   Omega_y_steadyState,
%               Results(1,5 )   Omega_z_steadyState
%               Results(1,6 )   F_x,
%               Results(1,7 )   F_y,
%               Results(1,8 )   F_z,
%               Results(1,9 )   Torq_x,
%               Results(1,10)   Torq_y,
%               Results(1,11)   Torq_z,
%               Results(1,12)   Acc_x,
%               Results(1,13)   Acc_y,
%               Results(1,14)   Acc_z,
%               Results(1,15)   Alpha_x,
%               Results(1,16)   Alpha_y,
%               Results(1,17)   Alpha_z
% Long description
        Results = zeros(1,17);
        inputSize = size(initCd);
        if inputSize(1) ~= 5 || inputSize(2) ~= 1
                fprintf('the input Initial Condition vector is not well shaped')
                return
        end

        ready = configGeoMesh(Y, Z, flowModel);
        if ready == false
                fprintf('the Geometry and Meshing process went wrong!');
        end

        % flowModel.param.set('Yp', Y);
        % flowModel.param.set('Zp', Z);
        
        % bulid the geom and mesh according to particle's position
        % flowModel.geom('geom1').run;
        % debug code block in order to show the appearance of geom and mesh
        % mphgeom(flowModel, 'geom1', 'facealpha', 0.5);
        % pause

        % flowModel.mesh('mesh1').run;
        % debug code block in order to show the appearance of geom and mesh        
        % mphmesh(flowModel, 'mesh1', 'facealpha', 0.5);
        % pause

        % call the function to calculate the Fin
        [ ...,
                Results(1,1 ), ...,   % ifSuccess if calculation is successful
                Results(1,2 ), ...,   % Velocity_x_steadyState
                Results(1,3 ), ...,   % Omega_x_steadyState,
                Results(1,4 ), ...,   % Omega_y_steadyState,
                Results(1,5 ), ...,   % Omega_z_steadyState
                Results(1,6 ), ...,   % F_x,
                Results(1,7 ), ...,   % F_y,
                Results(1,8 ), ...,   % F_z,
                Results(1,9 ), ...,   % Torq_x,
                Results(1,10), ...,   % Torq_y,
                Results(1,11), ...,   % Torq_z,
                Results(1,12), ...,   % Acc_x,
                Results(1,13), ...,   % Acc_y,
                Results(1,14), ...,   % Acc_z,
                Results(1,15), ...,   % Alpha_x,
                Results(1,16), ...,   % Alpha_y,
                Results(1,17)  ...,   % Alpha_z
        ] ...,
        = ...,
        FiCal(initCd, timeStep,flowModel);

end