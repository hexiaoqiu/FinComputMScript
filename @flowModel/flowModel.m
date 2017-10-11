classdef flowModel < handle
        properties (SetAccess = private)
                yP;
                zP;
                mphModel;

                vpX   = 0;
                omega = struct('x',0,'y',0,'z',0);
                force = struct('x',0,'y',0,'z',0);
                tau   = struct('x',0,'y',0,'z',0);
                acc   = struct('x',0,'y',0,'z',0);
                alpha = struct('x',0,'y',0,'z',0);

                updated = false;
        end

        properties ( Constant )
                inputForm = '%20.19e';
        end

        methods 
                function fM = flowModel(comsolModel)
                        fM.mphModel = comsolModel;
                        fM.yP = fM.mphModel.param.evaluate('Yp');
                        fM.zP = fM.mphModel.param.evaluate('Zp');
                        fM.updated = false;
                end

                function setVpXOmg(vitessX, omegaX, omegaY, omegaZ, fM)
                        fM.vpX = vitessX;
                        fM.omega.x = omegaX;
                        fM.omega.y = omegaY;
                        fM.omega.z = omegaZ;

                        vpXStr        = [ num2str(fM.vpX,    fM.inputForm), '[m/s]'];
                        omgXStr       = [ num2str(fM.omega.x,fM.inputForm), '[rad/s]'];
                        omgYStr       = [ num2str(fM.omega.y,fM.inputForm), '[rad/s]'];
                        omgZStr       = [ num2str(fM.omega.z,fM.inputForm), '[rad/s]'];

                        fM.mphModel.param.set('Vp_x',    vpXStr );        
                        fM.mphModel.param.set('Omega_x', omgXStr);        
                        fM.mphModel.param.set('Omega_y', omgYStr);
                        fM.mphModel.param.set('Omega_z', omgZStr);

                        force = struct('x',0,'y',0,'z',0);
                        tau   = struct('x',0,'y',0,'z',0);
                        acc   = struct('x',0,'y',0,'z',0);
                        alpha = struct('x',0,'y',0,'z',0);

                        fM.updated = false;
                end

                function setYpZp( Y_p, Z_p, fM )
                        fM.yP = Y_p;
                        fM.zP = Z_p;
                        if configGeoMesh(fM) == false
                                fprintf('the Geom or Mesh is not correct!');
                        end
                        
                        force = struct('x',0,'y',0,'z',0);
                        tau   = struct('x',0,'y',0,'z',0);
                        acc   = struct('x',0,'y',0,'z',0);
                        alpha = struct('x',0,'y',0,'z',0);

                        fM.updated = false;
                end

                function update( fM )
                        runOnce(fM);
                        outputInfo(fM);
                        fM.updated = true;
                end

                outputInfo( fM )


        end

        methods (Access = private)
                ifSuccess = configGeoMesh(fM)
                runOnce(fM)
        end
end