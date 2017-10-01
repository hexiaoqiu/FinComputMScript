%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 1          Initialization                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Key: 1. in Matlab Only values are manupulated, units can be checked in COMSOL Desktop
%

%*************************** load the model **********************************************&
ModelUtil.showProgress(true);
flowModel        = mphopen('Test.mph', 'flowModel');
flowGeom         = flowModel.geom.get('geom1');
flowMesh         = flowModel.mesh.get('mesh1');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 3     Running  iterations                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
timeStep = zeros(6,1);
timeStep(1,1) = 1e-6;
timeStep(2,1) = 5e-7;
timeStep(3,1) = 2e-7;
timeStep(4,1) = 1e-7;
timeStep(5,1) = 5e-8;
timeStep(6,1) = 2e-8;

initCd = zeros(1,4);
inputForm = '%20.19e';

dTCompare = zeros(6,12);

for idxT = 1:1:6
        numIter = 1e-5 / timeStep(idxT, 1);
        setVpOmg(initCd, inputForm, flowModel);
        Vp_x      = 0;
        Omega_x   = 0;
        Omega_y   = 0;
        Omega_z   = 0;
        for idxR = 1:numIter
                [Fx, Fy, Fz, torqueX, torqueY, torqueZ, accX, accY, accZ, alphaX, alphaY, alphaZ] ...,
                = runOnce(flowModel);
                outputInfo(flowModel, idxR);
                Vp_x      = Vp_x    + (accX   * timeStep(idxT,1) );
                Omega_x   = Omega_x + (alphaX * timeStep(idxT,1) );
                Omega_y   = Omega_y + (alphaY * timeStep(idxT,1) );
                Omega_z   = Omega_z + (alphaZ * timeStep(idxT,1) );
                nextVpOmg = [Vp_x, Omega_x, Omega_y, Omega_z];
                setVpOmg( nextVpOmg, inputForm, flowModel);
        end
        dTCompare(idxT,1:16) = ...,
        [Vp_x, Omega_x, Omega_y, Omega_z, Fx, Fy, Fz, torqueX, torqueY, torqueZ, accX, accY, accZ, alphaX, alphaY, alphaZ];
        save('dTCompare.mat','dTCompare')
             
end

% vPx_0            = 0.857730833816637;
% omegaX_0         = 36.691906804135650;
% omegaY_0         = -3.839509213725493e+04;
% omegaZ_0         = 1.233145755837119e+02;
% deltaT_0         = 1e-8;