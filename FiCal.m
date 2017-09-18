function [ifSuccess, ...,
          Velocity_x_steadyState, ...,
          Omega_x_steadyState,Omega_y_steadyState,Omega_z_steadyState, ...,
          F_x,F_y,F_z, ...,
          Torq_x,Torq_y,Torq_z, ...,
          Acc_x,Acc_y,Acc_z, ...,
          Alpha_x,Alpha_y,Alpha_z] ...,
= ...,
FiCal(Vp_x_0,Omega_x_0,Omega_y_0,Omega_z_0, deltaT_0,flowModel)

        %configuration of sub Loop for inertial lift force calculation
        numIter            = 100;
        ifConverged        = false;

        Yp = flowModel.param.evaluate('Yp');
        Zp = flowModel.param.evaluate('Zp');
        Yp = Yp * 1e6;
        Zp = Zp * 1e6;
        
        % counterOscillation = 0;

        vPxhstry           = zeros(numIter,1);
        omegaXhstry        = zeros(numIter,1);
        omegaYhstry        = zeros(numIter,1);
        omegaZhstry        = zeros(numIter,1);
        Fxhstry            = zeros(numIter,1);
        Fyhstry            = zeros(numIter,1);
        Fzhstry            = zeros(numIter,1);
        torqueXhstry       = zeros(numIter,1);
        torqueYhstry       = zeros(numIter,1);
        torqueZhstry       = zeros(numIter,1);
        accXhstry          = zeros(numIter,1);
        accYhstry          = zeros(numIter,1);
        accZhstry          = zeros(numIter,1);
        alphaXhstry        = zeros(numIter,1);
        alphaYhstry        = zeros(numIter,1);
        alphaZhstry        = zeros(numIter,1);

        delta_vPxhstry     = zeros(numIter,1);
        delta_omegaXhstry  = zeros(numIter,1);
        delta_omegaYhstry  = zeros(numIter,1);
        delta_omegaZhstry  = zeros(numIter,1);
        delta_Fxhstry      = zeros(numIter,1);
        delta_Fyhstry      = zeros(numIter,1);
        delta_Fzhstry      = zeros(numIter,1);
        delta_torqueXhstry = zeros(numIter,1);
        delta_torqueYhstry = zeros(numIter,1);
        delta_torqueZhstry = zeros(numIter,1);
        delta_accXhstry    = zeros(numIter,1);
        delta_accYhstry    = zeros(numIter,1);
        delta_accZhstry    = zeros(numIter,1);
        delta_alphaXhstry  = zeros(numIter,1);
        delta_alphaYhstry  = zeros(numIter,1);
        delta_alphaZhstry  = zeros(numIter,1);

        var_vPxhstry       = zeros(numIter, 1);
        var_omegaXhstry    = zeros(numIter, 1);
        var_omegaYhstry    = zeros(numIter, 1);
        var_omegaZhstry    = zeros(numIter, 1);
        var_Fxhstry        = zeros(numIter, 1);
        var_Fyhstry        = zeros(numIter, 1);
        var_Fzhstry        = zeros(numIter, 1);
        var_torqueXhstry   = zeros(numIter, 1);
        var_torqueYhstry   = zeros(numIter, 1);
        var_torqueZhstry   = zeros(numIter, 1);
        var_accXhstry      = zeros(numIter, 1);
        var_accYhstry      = zeros(numIter, 1);
        var_accZhstry      = zeros(numIter, 1);
        var_alphaXhstry    = zeros(numIter, 1);
        var_alphaYhstry    = zeros(numIter, 1);
        var_alphaZhstry    = zeros(numIter, 1);

        % set up the initial value
        if deltaT_0 <= 1e-10
                deltaT = 2e-6;
        else
                deltaT = deltaT_0;
        end


        % Make a guess of equilibrium state 
        Vp_x    = Vp_x_0;
        flowModel.param.set('Vp_x', Vp_x);        
        Omega_x = Omega_x_0;
        flowModel.param.set('Omega_x', Omega_x);        
        Omega_y = Omega_y_0;
        flowModel.param.set('Omega_y', Omega_y);
        Omega_z = Omega_z_0;        
        flowModel.param.set('Omega_z', Omega_z);

        % iteration code
        for index = 1:numIter
                %solve the stationary flow field
                flowModel.study('std1').run;
                %get the dynamic variables
                Fx      = mphglobal(flowModel, {'Fx'});
                Fy      = mphglobal(flowModel, {'Fy'});
                Fz      = mphglobal(flowModel, {'Fz'});
                torqueX = mphglobal(flowModel, {'tau_x'});
                torqueY = mphglobal(flowModel, {'tau_y'});
                torqueZ = mphglobal(flowModel, {'tau_z'});
                accX    = mphglobal(flowModel, {'accX'});
                accY    = mphglobal(flowModel, {'accY'});
                accZ    = mphglobal(flowModel, {'accZ'});
                alphaX  = mphglobal(flowModel, {'alphaX'});
                alphaY  = mphglobal(flowModel, {'alphaY'});
                alphaZ  = mphglobal(flowModel, {'alphaZ'});
                %calculate next step's velocity and angular velocity
                Vp_x    = Vp_x    + (accX   * deltaT);
                Omega_x = Omega_x + (alphaX * deltaT);
                Omega_y = Omega_y + (alphaY * deltaT);
                Omega_z = Omega_z + (alphaZ * deltaT);
                %update the Parameters
                flowModel.param.set('Vp_x', Vp_x);
                flowModel.param.set('Omega_x', Omega_x);
                flowModel.param.set('Omega_y', Omega_y);
                flowModel.param.set('Omega_z', Omega_z);
                
                vPxhstry(index,1)        = Vp_x;
                omegaXhstry(index,1)     = Omega_x;
                omegaYhstry(index,1)     = Omega_y;
                omegaZhstry(index,1)     = Omega_z;
                Fxhstry(index,1)         = Fx;
                Fyhstry(index,1)         = Fy;
                Fzhstry(index,1)         = Fz;
                torqueXhstry(index,1)    = torqueX;
                torqueYhstry(index,1)    = torqueY;
                torqueZhstry(index,1)    = torqueZ;
                accXhstry(index,1)       = accX;
                accYhstry(index,1)       = accY;
                accZhstry(index,1)       = accZ;
                alphaXhstry(index,1)     = alphaX;
                alphaYhstry(index,1)     = alphaY;
                alphaZhstry(index,1)     = alphaZ;

                if index == 1
                        delta_vPxhstry(index,1)          = abs( vPxhstry(index,1)      );
                        delta_omegaXhstry(index,1)       = abs( omegaXhstry(index,1)   );
                        delta_omegaYhstry(index,1)       = abs( omegaYhstry(index,1)   );
                        delta_omegaZhstry(index,1)       = abs( omegaZhstry(index,1)   );
                        delta_Fxhstry(index,1)           = abs( Fxhstry(index,1)       );
                        delta_Fyhstry(index,1)           = abs( Fyhstry(index,1)       );
                        delta_Fzhstry(index,1)           = abs( Fzhstry(index,1)       );
                        delta_torqueXhstry(index,1)      = abs( torqueXhstry(index,1)  );
                        delta_torqueYhstry(index,1)      = abs( torqueYhstry(index,1)  );
                        delta_torqueZhstry(index,1)      = abs( torqueZhstry(index,1)  );
                        delta_accXhstry(index,1)         = abs( accXhstry(index,1)     );
                        delta_accYhstry(index,1)         = abs( accYhstry(index,1)     );
                        delta_accZhstry(index,1)         = abs( accZhstry(index,1)     );
                        delta_alphaXhstry(index,1)       = abs( alphaXhstry(index,1)   );
                        delta_alphaYhstry(index,1)       = abs( alphaYhstry(index,1)   );
                        delta_alphaZhstry(index,1)       = abs( alphaZhstry(index,1)   );

                        var_vPxhstry(index,1)          = delta_vPxhstry(index,1)       /  abs( vPxhstry(index,1)     );
                        var_omegaXhstry(index,1)       = delta_omegaXhstry(index,1)    /  abs( omegaXhstry(index,1)  );
                        var_omegaYhstry(index,1)       = delta_omegaYhstry(index,1)    /  abs( omegaYhstry(index,1)  );
                        var_omegaZhstry(index,1)       = delta_omegaZhstry(index,1)    /  abs( omegaZhstry(index,1)  );
                        var_Fxhstry(index,1)           = delta_Fxhstry(index,1)        /  abs( Fxhstry(index,1)      );
                        var_Fyhstry(index,1)           = delta_Fyhstry(index,1)        /  abs( Fyhstry(index,1)      );
                        var_Fzhstry(index,1)           = delta_Fzhstry(index,1)        /  abs( Fzhstry(index,1)      );
                        var_torqueXhstry(index,1)      = delta_torqueXhstry(index,1)   /  abs( torqueXhstry(index,1) );
                        var_torqueYhstry(index,1)      = delta_torqueYhstry(index,1)   /  abs( torqueYhstry(index,1) );
                        var_torqueZhstry(index,1)      = delta_torqueZhstry(index,1)   /  abs( torqueZhstry(index,1) );
                        var_accXhstry(index,1)         = delta_accXhstry(index,1)      /  abs( accXhstry(index,1)    );
                        var_accYhstry(index,1)         = delta_accYhstry(index,1)      /  abs( accYhstry(index,1)    );
                        var_accZhstry(index,1)         = delta_accZhstry(index,1)      /  abs( accZhstry(index,1)    );
                        var_alphaXhstry(index,1)       = delta_alphaXhstry(index,1)    /  abs( alphaXhstry(index,1)  );
                        var_alphaYhstry(index,1)       = delta_alphaYhstry(index,1)    /  abs( alphaYhstry(index,1)  );
                        var_alphaZhstry(index,1)       = delta_alphaZhstry(index,1)    /  abs( alphaZhstry(index,1)  );
                end

                if index >= 2
                        delta_vPxhstry(index,1)          = abs( vPxhstry(index,1)     - vPxhstry(index-1,1)     );
                        delta_omegaXhstry(index,1)       = abs( omegaXhstry(index,1)  - omegaXhstry(index-1,1)  );
                        delta_omegaYhstry(index,1)       = abs( omegaYhstry(index,1)  - omegaYhstry(index-1,1)  );
                        delta_omegaZhstry(index,1)       = abs( omegaZhstry(index,1)  - omegaZhstry(index-1,1)  );
                        delta_Fxhstry(index,1)           = abs( Fxhstry(index,1)      - Fxhstry(index-1,1)      );
                        delta_Fyhstry(index,1)           = abs( Fyhstry(index,1)      - Fyhstry(index-1,1)      );
                        delta_Fzhstry(index,1)           = abs( Fzhstry(index,1)      - Fzhstry(index-1,1)      );
                        delta_torqueXhstry(index,1)      = abs( torqueXhstry(index,1) - torqueXhstry(index-1,1) );
                        delta_torqueYhstry(index,1)      = abs( torqueYhstry(index,1) - torqueYhstry(index-1,1) );
                        delta_torqueZhstry(index,1)      = abs( torqueZhstry(index,1) - torqueZhstry(index-1,1) );
                        delta_accXhstry(index,1)         = abs( accXhstry(index,1)    - accXhstry(index-1,1)    );
                        delta_accYhstry(index,1)         = abs( accYhstry(index,1)    - accYhstry(index-1,1)    );
                        delta_accZhstry(index,1)         = abs( accZhstry(index,1)    - accZhstry(index-1,1)    );
                        delta_alphaXhstry(index,1)       = abs( alphaXhstry(index,1)  - alphaXhstry(index-1,1)  );
                        delta_alphaYhstry(index,1)       = abs( alphaYhstry(index,1)  - alphaYhstry(index-1,1)  );
                        delta_alphaZhstry(index,1)       = abs( alphaZhstry(index,1)  - alphaZhstry(index-1,1)  );

                        var_vPxhstry(index,1)          = delta_vPxhstry(index,1)       /  abs( vPxhstry(index,1)     );
                        var_omegaXhstry(index,1)       = delta_omegaXhstry(index,1)    /  abs( omegaXhstry(index,1)  );
                        var_omegaYhstry(index,1)       = delta_omegaYhstry(index,1)    /  abs( omegaYhstry(index,1)  );
                        var_omegaZhstry(index,1)       = delta_omegaZhstry(index,1)    /  abs( omegaZhstry(index,1)  );
                        var_Fxhstry(index,1)           = delta_Fxhstry(index,1)        /  abs( Fxhstry(index,1)      );
                        var_Fyhstry(index,1)           = delta_Fyhstry(index,1)        /  abs( Fyhstry(index,1)      );
                        var_Fzhstry(index,1)           = delta_Fzhstry(index,1)        /  abs( Fzhstry(index,1)      );
                        var_torqueXhstry(index,1)      = delta_torqueXhstry(index,1)   /  abs( torqueXhstry(index,1) );
                        var_torqueYhstry(index,1)      = delta_torqueYhstry(index,1)   /  abs( torqueYhstry(index,1) );
                        var_torqueZhstry(index,1)      = delta_torqueZhstry(index,1)   /  abs( torqueZhstry(index,1) );
                        var_accXhstry(index,1)         = delta_accXhstry(index,1)      /  abs( accXhstry(index,1)    );
                        var_accYhstry(index,1)         = delta_accYhstry(index,1)      /  abs( accYhstry(index,1)    );
                        var_accZhstry(index,1)         = delta_accZhstry(index,1)      /  abs( accZhstry(index,1)    );
                        var_alphaXhstry(index,1)       = delta_alphaXhstry(index,1)    /  abs( alphaXhstry(index,1)  );
                        var_alphaYhstry(index,1)       = delta_alphaYhstry(index,1)    /  abs( alphaYhstry(index,1)  );
                        var_alphaZhstry(index,1)       = delta_alphaZhstry(index,1)    /  abs( alphaZhstry(index,1)  );
                end

                if plotTrace('Force', 6, index, Fxhstry, Fyhstry, Fzhstry, delta_Fxhstry, delta_Fyhstry, delta_Fzhstry) == false
                        fprintf('Force plot go wrong! \n');
                        return
                end
                
                if plotTrace('Torque', 9, index, torqueXhstry, torqueYhstry, torqueZhstry, delta_torqueXhstry, delta_torqueYhstry, delta_torqueZhstry) == false
                        fprintf('Torque plot go wrong! \n');
                        return
                end

                % save the track of convergency in order to debug   
                % save func takes string as variables
                save(   ['Yp',num2str(Yp),'Zp',num2str(Zp),'_PointTrack.mat'], ...,
                        'vPxhstry',                ...,
                        'omegaXhstry'  ,           ...,
                        'omegaYhstry'  ,           ...,
                        'omegaZhstry'  ,           ...,
                        'Fxhstry'      ,           ...,
                        'Fyhstry'      ,           ...,
                        'Fzhstry'      ,           ...,
                        'torqueXhstry' ,           ...,
                        'torqueYhstry' ,           ...,
                        'torqueZhstry' ,           ...,
                        'accXhstry'    ,           ...,
                        'accYhstry'    ,           ...,
                        'accZhstry'    ,           ...,
                        'alphaXhstry'  ,           ...,
                        'alphaYhstry'  ,           ...,
                        'alphaZhstry'  ,           ...,
                        'delta_vPxhstry'     ,     ...,
                        'delta_omegaXhstry'  ,     ...,
                        'delta_omegaYhstry'  ,     ...,
                        'delta_omegaZhstry'  ,     ...,
                        'delta_Fxhstry'      ,     ...,
                        'delta_Fyhstry'      ,     ...,
                        'delta_Fzhstry'      ,     ...,
                        'delta_torqueXhstry' ,     ...,
                        'delta_torqueYhstry' ,     ...,
                        'delta_torqueZhstry' ,     ...,
                        'delta_accXhstry'    ,     ...,
                        'delta_accYhstry'    ,     ...,
                        'delta_accZhstry'    ,     ...,
                        'delta_alphaXhstry'  ,     ...,
                        'delta_alphaYhstry'  ,     ...,
                        'delta_alphaZhstry'  ,     ...,
                        'var_vPxhstry'       ,     ...,
                        'var_omegaXhstry'    ,     ...,
                        'var_omegaYhstry'    ,     ...,
                        'var_omegaZhstry'    ,     ...,
                        'var_Fxhstry'        ,     ...,
                        'var_Fyhstry'        ,     ...,
                        'var_Fzhstry'        ,     ...,
                        'var_torqueXhstry'   ,     ...,
                        'var_torqueYhstry'   ,     ...,
                        'var_torqueZhstry'   ,     ...,
                        'var_accXhstry'      ,     ...,
                        'var_accYhstry'      ,     ...,
                        'var_accZhstry'      ,     ...,
                        'var_alphaXhstry'    ,     ...,
                        'var_alphaYhstry'    ,     ...,
                        'var_alphaZhstry'          ...,
                );



                % the convergency criterion
                if ( var_Fyhstry(index,1) < 1e-3 )&&( var_Fzhstry(index,1) < 1e-3 )
                        ifConverged = true;
                        fprintf('the loop converges! Good convergency criterion reached! \n');
                        fprintf('It takes %d iterations to reach the convergency! \n', index );                
                        break;   
                end

                if (index == 100)                      
                        if (ifConverged == false)
                                fprintf('the loop fail to converge! \n');
                                break;
                        end
                end

                % Debug Code Block
                % In this code block, the key parameter are printed in order to check if the constant coef derived from
                % the licit value
                % the constant key parameters are
                % Vp_y = 0 [m/s]
                % Vp_z = 0 [m/s]
                % Xp   = 125e-6 [m]
                % Rp   = 5.5e-6 [m]
                % Yp   = do not change in each all of FiCalculation    
                % Zp   = do not change in each all of FiCalculation
                % Vp_y = flowModel.param.evaluate('Vp_y');
                % Vp_z = flowModel.param.evaluate('Vp_z');
                % Xp   = flowModel.param.evaluate('Xp');
                % Yp   = flowModel.param.evaluate('Yp');
                % Zp   = flowModel.param.evaluate('Zp');
                % Rp   = flowModel.param.evaluate('Rp');
                % fprintf('Vp_y is %8.6f \n', Vp_y);
                % fprintf('Vp_z is %8.6f \n', Vp_z);
                % fprintf('Xp is %8.6f \n', Xp);
                % fprintf('Yp is %8.6f \n', Yp);
                % fprintf('Zp is %8.6f \n', Zp);
                % fprintf('Rp is %8.6f \n', Rp);


        end


        %Output the vars
        if ifConverged == true
                ifSuccess = true;
        else
                ifSuccess = false;
        end

        Velocity_x_steadyState = Vp_x;
        Omega_x_steadyState    = Omega_x;
        Omega_y_steadyState    = Omega_y;
        Omega_z_steadyState    = Omega_z;
        F_x                    = mphglobal(flowModel, {'Fx'});
        F_y                    = mphglobal(flowModel, {'Fy'});
        F_z                    = mphglobal(flowModel, {'Fz'});
        Torq_x                 = mphglobal(flowModel, {'tau_x'});
        Torq_y                 = mphglobal(flowModel, {'tau_y'});
        Torq_z                 = mphglobal(flowModel, {'tau_z'});
        Acc_x                  = mphglobal(flowModel, {'accX'});
        Acc_y                  = mphglobal(flowModel, {'accY'});
        Acc_z                  = mphglobal(flowModel, {'accZ'});
        Alpha_x                = mphglobal(flowModel, {'alphaX'});
        Alpha_y                = mphglobal(flowModel, {'alphaY'});
        Alpha_z                = mphglobal(flowModel, {'alphaZ'});

        % Debug Code faked output
        % ifSuccess              = 1;
        % Velocity_x_steadyState = 2;
        % Omega_x_steadyState    = 3;
        % Omega_y_steadyState    = 4;
        % Omega_z_steadyState    = 5;
        % F_x                    = 6;
        % F_y                    = 7;
        % F_z                    = 8;
        % Torq_x                 = 9;
        % Torq_y                 = 10;
        % Torq_z                 = 11;
        % Acc_x                  = 12;
        % Acc_y                  = 13;
        % Acc_z                  = 14;
        % Alpha_x                = 15;
        % Alpha_y                = 16;
        % Alpha_z                = 17;

end