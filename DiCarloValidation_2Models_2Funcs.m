%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 1          Initialization                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Key: 1. in Matlab Only values are manupulated, units can be checked in COMSOL Desktop
%

%*************************** load the model **********************************************&
addpath('F:\hxq\Calculation_7');
addpath('F:\hxq_OneDrive\OneDrive\myResearch\Inertial_Lifr_Force\Control_Code\alpha_Lv2Crtn')
ModelUtil.showProgress(true);
undisturbedModel = mphopen('Paragon_withoutParticle.mph', 'undisturbedModel');
flowModel        = mphopen('ParagonModel.mph', 'flowModel');
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
for index = 2:1:numDimStore
        if Fi(index,3) == true
            fprintf('The %dth calculation is already done, move forward to next.\n', index);    
            continue;          
        else
            fprintf('The %dth calculation is Undergoing.\n', index);
        end
        Yp = Fi(index,1);
        Zp = Fi(index,2);

        [vPx_0, omegaX_0, omegaY_0, omegaZ_0] = GetInitialValue(Yp, Zp, undisturbedModel);

        flowModel.param.set('Yp', Yp);
        flowModel.param.set('Zp', Zp);
        flowModel.geom('geom1').run;
        flowModel.mesh('mesh1').run;
        [ ...,
                Fi(index,3 ), ...,   % ifSuccess if calculation is successful
                Fi(index,4 ), ...,   % Velocity_x_steadyState
                Fi(index,5 ), ...,   % Omega_x_steadyState,
                Fi(index,6 ), ...,   % Omega_y_steadyState,
                Fi(index,7 ), ...,   % Omega_z_steadyState
                Fi(index,8 ), ...,   % F_x,
                Fi(index,9 ), ...,   % F_y,
                Fi(index,10), ...,   % F_z,
                Fi(index,11), ...,   % Torq_x,
                Fi(index,12), ...,   % Torq_y,
                Fi(index,13), ...,   % Torq_z,
                Fi(index,14), ...,   % Acc_x,
                Fi(index,15), ...,   % Acc_y,
                Fi(index,16), ...,   % Acc_z,
                Fi(index,17), ...,   % Alpha_x,
                Fi(index,18), ...,   % Alpha_y,
                Fi(index,19)  ...,   % Alpha_z
        ] ...,
        = ...,
        FiCalculation_V3(vPx_0,omegaX_0,omegaY_0,omegaZ_0, deltaT_0,flowModel);
        save('Fi.mat', 'Fi');

        %plot while calculating
        resultMonitor = figure(2);
        plot(Fi(:,1),Fi(:,2),'o','LineWidth',1,...  
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','w',...
        'MarkerSize',3);
        drawnow;
        hold on
        quiver(Fi(:,1),Fi(:,2),Fi(:,9),Fi(:,10));
        drawnow;
        hold off
end
