        clc;
        ModelUtil.showProgress(true);
        %%
        flowModel        = mphopen('MeshConsistency.mph', 'flowModel');
        flowGeom         = flowModel.geom.get('geom1');
        flowMesh         = flowModel.mesh.get('mesh1');
        %%
        testResult = zeros(1,19);
        testResult(1,1) = 25e-6;
        testResult(1,2) = 8e-6;
        %%
         Good = flowMesh.feature('size').set('hauto','4');
         fprintf('the set result is\n %s \n',Good);
         ifOK = flowMesh.run() ;
         ifOKStr = char(ifOK);
         fprintf('the build result is\n %s \n',ifOKStr);
        %%
        [ ...,
                testResult(1,3 ), ...,   % ifSuccess if calculation is successful
                testResult(1,4 ), ...,   % Velocity_x_steadyState
                testResult(1,5 ), ...,   % Omega_x_steadyState,
                testResult(1,6 ), ...,   % Omega_y_steadyState,
                testResult(1,7 ), ...,   % Omega_z_steadyState
                testResult(1,8 ), ...,   % F_x,
                testResult(1,9 ), ...,   % F_y,
                testResult(1,10 ), ...,   % F_z,
                testResult(1,11 ), ...,   % Torq_x,
                testResult(1,12), ...,   % Torq_y,
                testResult(1,13), ...,   % Torq_z,
                testResult(1,14), ...,   % Acc_x,
                testResult(1,15), ...,   % Acc_y,
                testResult(1,16), ...,   % Acc_z,
                testResult(1,17), ...,   % Alpha_x,
                testResult(1,18), ...,   % Alpha_y,
                testResult(1,19)  ...,   % Alpha_z
        ] ...,
        = ...,
        FiCal(0,0,0,0,2e-6,flowModel);
    Fine = testResult;
    save('Fine','Fine');
    %%
    results = [Coarser;Coarse;Normal;Fine];
    Vx = results(:,4);
    Fy = results(:,9);
    Fz = results(:,10);
    omegaX = results(:,5);
    omegaY = results(:,6);
    omegaZ = results(:,7);

