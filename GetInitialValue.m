function [Vp_x_0, Omega_x_0,Omega_y_0,Omega_z_0] = GetInitialValue(Yp,Zp,undisturbedModel)
%GetInitialValue - Description
%
% Syntax: [Vp_x_0, Omega_x_0,Omega_y_0,Omega_z_0,] = GetInitialValue(Xp,Yp,Zp,undisturbedModel)
%
% Long description
        %Get the handle of the model's Geometry and Mesh 
        undisturbedGeom  = undisturbedModel.geom.get('geom1');
        undisturbedMesh  = undisturbedModel.mesh.get('mesh1');
        %Set the particle's place
        undisturbedModel.param.set('Yp', Yp);
        undisturbedModel.param.set('Zp', Zp);
        %Construct the Geometry
        undisturbedGeom.run;
        %Meshing the Geometry
        undisturbedMesh.run;
        %Solve the physics
        undisturbedModel.study('std1').run;
        %Output the Initial Value
        Vp_x_0    = mphglobal(undisturbedModel, 'Vpx_initial');
        Omega_x_0 = mphglobal(undisturbedModel, 'OmegaX_initial');
        Omega_y_0 = mphglobal(undisturbedModel, 'OmegaY_initial');
        Omega_z_0 = mphglobal(undisturbedModel, 'OmegaZ_initial');

end