function outputCoefs = Get1PointFi( Y, Z, initCd, timeStep, flowModel )
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

        global numIter dataPack initCd steadyState inputForm;
        numIter  = 100;
        inputForm   = '%20.19e';

        dataPack = struct;
        
        dataPack.vpXHstry               = zeros(numIter,1);
        dataPack.omgXHstry            = zeros(numIter,1);
        dataPack.omgYHstry            = zeros(numIter,1);
        dataPack.omgZHstry            = zeros(numIter,1);
        dataPack.FxHstry                = zeros(numIter,1);
        dataPack.FyHstry                = zeros(numIter,1);
        dataPack.FzHstry                = zeros(numIter,1);
        dataPack.tauXHstry           = zeros(numIter,1);
        dataPack.tauYHstry           = zeros(numIter,1);
        dataPack.tauZHstry           = zeros(numIter,1);
        dataPack.accXHstry              = zeros(numIter,1);
        dataPack.accYHstry              = zeros(numIter,1);
        dataPack.accZHstry              = zeros(numIter,1);
        dataPack.alphaXHstry            = zeros(numIter,1);
        dataPack.alphaYHstry            = zeros(numIter,1);
        dataPack.alphaZHstry            = zeros(numIter,1);

        dataPack.deltaVpXHstry     = zeros(numIter,1);
        dataPack.deltaOmgXHstry  = zeros(numIter,1);
        dataPack.deltaOmgYHstry  = zeros(numIter,1);
        dataPack.deltaOmgZHstry  = zeros(numIter,1);
        dataPack.deltaFxHstry      = zeros(numIter,1);
        dataPack.deltaFyHstry      = zeros(numIter,1);
        dataPack.deltaFzHstry      = zeros(numIter,1);
        dataPack.deltaTauXHstry = zeros(numIter,1);
        dataPack.deltaTauYHstry = zeros(numIter,1);
        dataPack.deltaTauZHstry = zeros(numIter,1);
        dataPack.deltaAccXHstry    = zeros(numIter,1);
        dataPack.deltaAccYHstry    = zeros(numIter,1);
        dataPack.deltaAccZHstry    = zeros(numIter,1);
        dataPack.deltaAlphaXHstry  = zeros(numIter,1);
        dataPack.deltaAlphaYHstry  = zeros(numIter,1);
        dataPack.deltaAlphaZHstry  = zeros(numIter,1);

        dataPack.varVpXHstry       = zeros(numIter, 1);
        dataPack.varOmgXHstry    = zeros(numIter, 1);
        dataPack.varOmgYHstry    = zeros(numIter, 1);
        dataPack.varOmgZHstry    = zeros(numIter, 1);
        dataPack.varFxHstry        = zeros(numIter, 1);
        dataPack.varFyHstry        = zeros(numIter, 1);
        dataPack.varFzHstry        = zeros(numIter, 1);
        dataPack.varTauXHstry   = zeros(numIter, 1);
        dataPack.varTauYHstry   = zeros(numIter, 1);
        dataPack.varTauZHstry   = zeros(numIter, 1);
        dataPack.varAccXHstry      = zeros(numIter, 1);
        dataPack.varAccYHstry      = zeros(numIter, 1);
        dataPack.varAccZHstry      = zeros(numIter, 1);
        dataPack.varAlphaXHstry    = zeros(numIter, 1);
        dataPack.varAlphaYHstry    = zeros(numIter, 1);
        dataPack.varAlphaZHstry    = zeros(numIter, 1);

        steadyState = struct;
        steadyState.vpX = 0;
        steadyState.omgX = 0;
        steadyState.omgY = 0;
        steadyState.omgZ = 0;
        steadyState.Fx = 0;
        steadyState.Fy = 0;
        steadyState.Fz = 0;
        steadyState.tauX = 0;
        steadyState.tauY = 0;
        steadyState.tauZ = 0;
        steadyState.accX = 0;
        steadyState.accY = 0;
        steadyState.accZ = 0;
        steadyState.alphaX = 0;
        steadyState.alphaY = 0;
        steadyState.alphaZ = 0;

        initCd = struct;
        initCd.vpX  = 0;
        initCd.omgX = 0;
        initCd.omgY = 0;
        initCd.omgZ = 0;


        if checkInitCd( initCd )
                fprintf('The initial condition is not good! ');
                return;
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
        outputCoefs = FiCal(initCd, timeStep, flowModel);

end