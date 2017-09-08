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
vPx_0 = 0.857730833816637;
omegaX_0 = 36.691906804135650;
omegaY_0 = -3.839509213725493e+04;
omegaZ_0 = 1.233145755837119e+02;
deltaT_0 = 0;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 3     Running  iterations                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        testResult = zeros(1,19);
        Yp = 2.5e-5;
        Zp = 4.2e-5;
        testResult(1,1) = Yp;
        testResult(1,2) = Zp;

        testResult(1,3:19) = Get1PointFi(Yp, Zp, flowModel);

        % flowModel.param.set('Yp', Yp);
        % flowModel.param.set('Zp', Zp);
        % flowModel.geom('geom1').run;
        % flowModel.mesh('mesh1').run;
        % [ ...,
        %         testResult(3 ), ...,   % ifSuccess if calculation is successful
        %         testResult(4 ), ...,   % Velocity_x_steadyState
        %         testResult(5 ), ...,   % Omega_x_steadyState,
        %         testResult(6 ), ...,   % Omega_y_steadyState,
        %         testResult(7 ), ...,   % Omega_z_steadyState
        %         testResult(8 ), ...,   % F_x,
        %         testResult(9 ), ...,   % F_y,
        %         testResult(10), ...,   % F_z,
        %         testResult(11), ...,   % Torq_x,
        %         testResult(12), ...,   % Torq_y,
        %         testResult(13), ...,   % Torq_z,
        %         testResult(14), ...,   % Acc_x,
        %         testResult(15), ...,   % Acc_y,
        %         testResult(16), ...,   % Acc_z,
        %         testResult(17), ...,   % Alpha_x,
        %         testResult(18), ...,   % Alpha_y,
        %         testResult(19)  ...,   % Alpha_z
        % ] ...,
        % = ...,
        % FiCalculation(vPx_0,omegaX_0,omegaY_0,omegaZ_0, deltaT_0,flowModel);


