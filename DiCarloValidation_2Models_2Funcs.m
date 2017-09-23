%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 1          Initialization                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Key: 1. in Matlab Only values are manupulated, units can be checked in COMSOL Desktop
%

%*************************** load the model **********************************************&

ModelUtil.showProgress(true);
undisturbedModel = mphopen('Paragon_withoutParticle_V0.mph', 'undisturbedModel');
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
widthChannel   = flowModel.param.evaluate( {'H'} );          %[m]
%-----> Particle Geom
Rp = flowModel.param.evaluate( {'Rp'} );                %[m]
Xp = flowModel.param.evaluate( {'Xp'} );                %[m]
Yp = flowModel.param.evaluate( {'Yp'} );                %[m]
Zp = flowModel.param.evaluate( {'Zp'} );                %[m]
%-----> the particle shall never touch the wall
LimitZ      = heightChannel/2  - Rp;                         % Upper Limitation of Z direct variation 
LimitY      = widthChannel/2  - Rp;                         % Upper Limitation of Y direct variation 
% the sampled positions' y and z cooridnate
y = 26:2:44;
z = 6:2:24;
y = 1e-6 * y;
z = 1e-6 * z;
% allocate the table store the result
Fi = zeros(100, 19);
% calculate the sample position
index = 1;
for indexY = 1:1:10
        Yp =  y(indexY);
        for indexZ = 1:1:10
                Zp = z(indexZ);
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
for index = 1:1:100
        if Fi(index,3) == true
            fprintf('The %dth calculation is already done, move forward to next.\n', index);    
            continue;          
        else
            fprintf('The %dth calculation is Undergoing.\n', index);
        end
        Yp = Fi(index,1); 
        Zp = Fi(index,2);

%         [vPx_0, omegaX_0, omegaY_0, omegaZ_0] = GetInitialValue(Yp, Zp, undisturbedModel);
        % set the  particle's position
        flowModel.param.set('Yp', Yp);
        flowModel.param.set('Zp', Zp);
        
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
        FiCalculation(vPx_0,omegaX_0,omegaY_0,omegaZ_0, deltaT_0,flowModel);
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
