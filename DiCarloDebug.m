%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 1          Initialization                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Key: 1. in Matlab Only values are manupulated, units can be checked in COMSOL Desktop
%

%*************************** load the model **********************************************&
ModelUtil.showProgress(true);
flowModel        = mphopen('ParagonModel_V1.mph', 'flowModel');
flowGeom         = flowModel.geom.get('geom1');
flowMesh         = flowModel.mesh.get('mesh1');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 2      Clarify the iterations' limits                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----> Channel Geometry
%                              channel Width y dimension
%                            ____________________________
%                            |                          |
%                            |                          |      
%    channel Hight           |                          |
%      z dimension           |                          |
%                            |__________________________|
heightChannel  = flowModel.param.evaluate( {'H'} );          %[m]
widthChannel  = flowModel.param.evaluate( {'H'} );          %[m]
%-----> Particle Geom
Rp = flowModel.param.evaluate( {'Rp'} );                %[m]
Xp = flowModel.param.evaluate( {'Xp'} );                %[m]
Yp = flowModel.param.evaluate( {'Yp'} );                %[m]
Zp = flowModel.param.evaluate( {'Zp'} );                %[m]
%-----> the particle shall never touch the wall
LimitZ      = heightChannel/2  - Rp;                         % Upper Limitation of Z direct variation 
LimitY      = widthChannel/2  - Rp;                         % Upper Limitation of Y direct variation 
deltaY = 1e-6;                                          % step lengthe of Y
deltaZ = 1e-6;                                          % step lengthe of Z
%max iter number of iteration
maxIndexY = fix( LimitY/deltaY );
maxIndexZ = fix( LimitZ/deltaZ ); 
%check the circumstance that the particle is tangency to the wall
while (maxIndexY*deltaY >= LimitY) 
        fprintf('index Y error');
        maxIndexY = maxIndexY -1;
end
while (maxIndexZ*deltaZ >= LimitZ) 
        fprintf('index Z error');
        maxIndexZ = maxIndexZ -1;
end
%initialize the index
indexY = 0;
indexZ = 0;
numDimStore = (maxIndexY+1)*(maxIndexZ+1);
% allocate the table store the result
Fi = zeros(numDimStore, 19);
% calculate the sample position
index = 1;
for indexY = 0:1:maxIndexY
        Yp = widthChannel/2 + indexY*deltaY;
        for indexZ = 0:1:maxIndexZ
                Zp = heightChannel/2 + indexZ*deltaZ;
                Fi(index,1) = Yp;
                Fi(index,2) = Zp;
                index = index + 1;
        end
end
vPx_0 = 0;
omegaX_0 = 0;
omegaY_0 = 0;
omegaZ_0 = 0;
deltaT_0 = 0;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 3     Running  iterations                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        testResult = zeros(19);
        Yp = 2.5e-5;
        Zp = 4.2e-5;
        
        [vPx_0, omegaX_0, omegaY_0, omegaZ_0] = GetInitialValue(Yp, Zp, undisturbedModel);

        flowModel.param.set('Yp', Yp);
        flowModel.param.set('Zp', Zp);
        flowModel.geom('geom1').run;
        flowModel.mesh('mesh1').run;
        [ ...,
                testResult(3 ), ...,   % ifSuccess if calculation is successful
                testResult(4 ), ...,   % Velocity_x_steadyState
                testResult(5 ), ...,   % Omega_x_steadyState,
                testResult(6 ), ...,   % Omega_y_steadyState,
                testResult(7 ), ...,   % Omega_z_steadyState
                testResult(8 ), ...,   % F_x,
                testResult(9 ), ...,   % F_y,
                testResult(10), ...,   % F_z,
                testResult(11), ...,   % Torq_x,
                testResult(12), ...,   % Torq_y,
                testResult(13), ...,   % Torq_z,
                testResult(14), ...,   % Acc_x,
                testResult(15), ...,   % Acc_y,
                testResult(16), ...,   % Acc_z,
                testResult(17), ...,   % Alpha_x,
                testResult(18), ...,   % Alpha_y,
                testResult(19)  ...,   % Alpha_z
        ] ...,
        = ...,
        FiCalculation_V3(vPx_0,omegaX_0,omegaY_0,omegaZ_0, deltaT_0,flowModel);


