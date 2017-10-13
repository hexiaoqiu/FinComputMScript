classdef flowModel < handle
        properties (SetAccess = private)
                yP;
                zP;
                mphModel;

                vpX   = 0;
                omega = [0,0,0];
                force = [0,0,0];
                tau   = [0,0,0];
                acc   = [0,0,0];
                alpha = [0,0,0];

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

                function setVpXOmg(fM, vitessX, omg)
                        fM.vpX = vitessX;
                        fM.omega = omg;
                        updateVpXOmg(fM)
                        resetDynamics(fM);
                        fM.updated = false;
                end

                function setVpX( fM, vitessX )
                        fM.vpX = vitessX;
                        updateVpXOmg( fM );
                        resetDynamics( fM );
                        fM.updated = false;
                end

                function  setOmg( fM, omg )
                        fM.omega = omg;
                        updateVpXOmg( fM );
                        resetDynamics( fM );
                        fM.updated = false;
                end

                function setYpZp( fM, Y_p, Z_p )
                        fM.yP = Y_p;
                        fM.zP = Z_p;
                        if updateGeoMesh(fM) == false
                                fprintf('the Geom or Mesh is not correct!');
                        end

                        resetDynamics(fM);

                        fM.updated = false;
                end

                function updateFTau( fM )
                        runOnce(fM);
                        outputInfo(fM);
                        fM.updated = true;
                end

                function [velocityX, angularVelocity] = getVpXOmg( fM )
                        velocityX = fM.vpX;
                        angularVelocity = fM.omega;
                end

                function velocityX = getVpX( fM )
                        velocityX = fM.vpX;                        
                end

                function angularVelocity = getOmg( fM )
                        angularVelocity = fM.omega;
                end

                function FORCE = getForce( fM )
                        FORCE = fM.force;
                end

                function ACC = getAcc( fM )
                        ACC = fM.acc;
                end

                function TAU = getTau( fM )
                        TAU = fM.tau;
                end

                function ALPHA = getAlpha( fM )
                        ALPHA = fM.alpha;
                end

                outputInfo( fM )


        end

        methods (Access = private)
                ifSuccess = updateGeoMesh(fM)
                runOnce(fM)

                function updateVpXOmg(fM)
                        vpXStr        = [ num2str(fM.vpX,    fM.inputForm), '[m/s]'];
                        omgXStr       = [ num2str(fM.omega(1),fM.inputForm), '[rad/s]'];
                        omgYStr       = [ num2str(fM.omega(2),fM.inputForm), '[rad/s]'];
                        omgZStr       = [ num2str(fM.omega(3),fM.inputForm), '[rad/s]'];
 
                        fM.mphModel.param.set('Vp_x',    vpXStr );  
                        fM.mphModel.param.set('Omega_x', omgXStr);        
                        fM.mphModel.param.set('Omega_y', omgYStr);
                        fM.mphModel.param.set('Omega_z', omgZStr);
                end

                function resetDynamics( fM )
                        fM.force = [0,0,0];
                        fM.tau   = [0,0,0];
                        fM.acc   = [0,0,0];
                        fM.alpha = [0,0,0];
                end
        end
end