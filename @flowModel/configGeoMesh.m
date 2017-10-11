function ifSuccess = configGeoMesh(fM)
% configGeoMesh - Description
%
% Syntax: ifSuccess = configGeoMesh(flowModel)

% input arguments list:
%               Y               Y coordinate of the particle
%               Z               Z coordinate of the particle
%               flowModel       the COMSOL model manipulated
% Long description
% Set up the Geometry and Build mesh for Flow Model in order to
% get ready for simulation

        yPStr     = [num2str(fM.yP,fM.inputForm),'[m]'];
        zPStr     = [num2str(fM.zP,fM.inputForm),'[m]'];
        fM.mphModel.param.set('Yp', yPStr);
        fM.mphModel.param.set('Zp', zPStr);
        
        % bulid the geom and mesh according to particle's position
        fM.mphModel.geom('geom1').run;
        % debug code block in order to show the appearance of geom and mesh
        % mphgeom(flowModel, 'geom1', 'facealpha', 0.5);
        % pause

        fM.mphModel.mesh('mesh1').run;
        % debug code block in order to show the appearance of geom and mesh        
        % mphmesh(flowModel, 'mesh1', 'facealpha', 0.5);
        % pause

        ifSuccess = true;
        
end