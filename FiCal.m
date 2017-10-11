function Results = FiCal( initCd, dataPack, timeStep, flowModel)
% FiCal - Description
%
% Syntax: Results = FiCal(Y, Z, initCd, flowModel)
% input arguments list:
%               initCd          initial conditioan a array of (1,4) contains the first guess of dynamic coefs 
%                               of particle and time step for persudo time iteration
%               timeStep        the time step for loop
%               flowModel       the COMSOL model manipulated
% output arguments:
%               Results         a array of (1,17)
%               Results(1,1 )   ifSuccess if calculation is successful
%               Results(1,2 )   Velocity_x_steadyState
%               Results(1,3 )   Omega_x_steadyState,
%               Results(1,4 )   Omega_y_steadyState,
%               Results(1,5 )   Omega_z_steadyState
%               Results(1,6 )   F_x,
%               Results(1,7 )   F_y,
%               Results(1,8 )   F_z,
%               Results(1,9 )   Torq_x,
%               Results(1,10)   Torq_y,
%               Results(1,11)   Torq_z,
%               Results(1,12)   Acc_x,
%               Results(1,13)   Acc_y,
%               Results(1,14)   Acc_z,
%               Results(1,15)   Alpha_x,
%               Results(1,16)   Alpha_y,
%               Results(1,17)   Alpha_z
        %configuration of sub Loop for inertial lift force calculation
        global numIter inputForm;
        nextVpOmg = struct('vpX',0,'omgX',0,'omgY',0,'omgZ',0);
        ifConverged = false;       
        
        % set up the initial value and time step
        if timeStep <= 1e-10
                deltaT = 2e-6;
        else
                deltaT = timeStep;
        end
        
        setVpXOmg(initCd, inputForm, flowModel);
        % iteration code
        for index = 3:numIter

                steadyState = runOnce(flowModel);

                if outputInfo(flowModel, index) == false
                        fprintf('outputinfo function gose wrong');
                end

                keepTracks(index, steadyState, dataPack, flowModel)
                
                % save the track of convergency in order to debug   
                % save func takes string as variables
                
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

                % calculate next step's velocity and angular velocity
                % and update the Parameters
                
                steadyState.vpX = steadyState.vpX + steadyState.accX * deltaT;
                nextVpOmg.vpX = steadyState.vpX;
                setVpOmg( nextVpOmg, inputForm, flowModel);


        end


        %Output the vars
        if ifConverged == true
                ifSuccess = true;
        else
                ifSuccess = false;
        end

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

        % Results(1, 1 ) =   ifSuccess;
        % Results(1, 2 ) =   Vp_x;
        % Results(1, 3 ) =   Omega_x;
        % Results(1, 4 ) =   Omega_y;
        % Results(1, 5 ) =   Omega_z;
        % Results(1, 6 ) =   mphglobal(flowModel, {'Fx'});
        % Results(1, 7 ) =   mphglobal(flowModel, {'Fy'});
        % Results(1, 8 ) =   mphglobal(flowModel, {'Fz'});
        % Results(1, 9 ) =   mphglobal(flowModel, {'tau_x'});
        % Results(1, 10) =   mphglobal(flowModel, {'tau_y'});
        % Results(1, 11) =   mphglobal(flowModel, {'tau_z'});
        % Results(1, 12) =   mphglobal(flowModel, {'accX'});
        % Results(1, 13) =   mphglobal(flowModel, {'accY'});
        % Results(1, 14) =   mphglobal(flowModel, {'accZ'});
        % Results(1, 15) =   mphglobal(flowModel, {'alphaX'});
        % Results(1, 16) =   mphglobal(flowModel, {'alphaY'});
        % Results(1, 17) =   mphglobal(flowModel, {'alphaZ'});

        Results = ...,
        [ ...,
          ifSuccess, Vp_x, Omega_x, Omega_y, Omega_z, Fx, Fy, Fz, torqueX, torqueY, torqueZ, accX, accY, accZ, ...,
          alphaX, alphaY, alphaZ ...,
        ];


end