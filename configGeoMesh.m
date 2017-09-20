function ifSuccess = configGeoMesh(Y, Z, flowModel)
% configGeoMesh - Description
%
% Syntax: ifSuccess = configGeoMesh(Y, Z, flowModel)

% input arguments list:
%               Y               Y coordinate of the particle
%               Z               Z coordinate of the particle
%               flowModel       the COMSOL model manipulated
% Long description
% Set up the Geometry and Build mesh for Flow Model in order to
% get ready for simulation
        precision = 128;
        YpStr     = [num2str(Y,precision),'[m]'];
        ZpStr     = [num2str(Z,precision),'[m]'];
        flowModel.param.set('Yp', YpStr);
        flowModel.param.set('Zp', ZpStr);
        
        % bulid the geom and mesh according to particle's position
        flowModel.geom('geom1').run;
        % debug code block in order to show the appearance of geom and mesh
        % mphgeom(flowModel, 'geom1', 'facealpha', 0.5);
        % pause

        flowModel.mesh('mesh1').run;
        % debug code block in order to show the appearance of geom and mesh        
        % mphmesh(flowModel, 'mesh1', 'facealpha', 0.5);
        % pause

        ifSuccess = true;
        
end