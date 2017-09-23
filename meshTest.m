
ModelUtil.showProgress(true);
flowModel        = mphopen('LiuChao.mph', 'flowModel');
flowGeom         = flowModel.geom.get('geom1');
flowMesh         = flowModel.mesh.get('mesh1');

for index = 9:1:2

        % set the mesh size param
        ifDone = flowMesh.feature('size').set('hauto','5');

        % build the mesh
        ifOK
end