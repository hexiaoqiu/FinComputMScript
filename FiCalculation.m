function [ifSuccess, ...,
          Velocity_x_steadyState, ...,
          Omega_x_steadyState,Omega_y_steadyState,Omega_z_steadyState, ...,
          F_x,F_y,F_z, ...,
          Torq_x,Torq_y,Torq_z, ...,
          Acc_x,Acc_y,Acc_z, ...,
          Alpha_x,Alpha_y,Alpha_z] ...,
= ...,
FiCalculation_V3(Vp_x_0,Omega_x_0,Omega_y_0,Omega_z_0, deltaT_0,flowModel)

        %configuration of sub Loop for inertial lift force calculation
        numIter           = 1000;
        ifConverged       = false;
        counterOscillation= 0;
        vPxhstry          = zeros(numIter,1);
        omegaXhstry       = zeros(numIter,1);
        omegaYhstry       = zeros(numIter,1);
        omegaZhstry       = zeros(numIter,1);
        Fxhstry           = zeros(numIter,1);
        Fyhstry           = zeros(numIter,1);
        Fzhstry           = zeros(numIter,1);
        torqueXhstry      = zeros(numIter,1);
        torqueYhstry      = zeros(numIter,1);
        torqueZhstry      = zeros(numIter,1);
        accXhstry         = zeros(numIter,1);
        accYhstry         = zeros(numIter,1);
        accZhstry         = zeros(numIter,1);
        alphaXhstry       = zeros(numIter,1);
        alphaYhstry       = zeros(numIter,1);
        alphaZhstry       = zeros(numIter,1);
        %set up the initial value
        if deltaT_0 <= 0
                deltaT = 2e-6;  
        else
                deltaT = deltaT_0;
        end 
        Vp_x    = Vp_x_0;
        Omega_x = Omega_x_0;
        Omega_y = Omega_y_0;
        Omega_z = Omega_z_0;


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

                iterMonitor = figure(1);
                set(iterMonitor, 'name', [ 'deltaT is ', num2str(deltaT), ' oscillation is ', num2str(counterOscillation), ' iteration number is ', num2str(index) ], 'Numbertitle', 'off' );
                subplot(2,4,1)
                plot( Fxhstry(1:index, 1) )
                title('Fx')
                xlabel('iter')
                drawnow

                subplot(2,4,2)
                semilogy( abs(torqueXhstry(1:index, 1)) )
                title( 'torqueX')
                xlabel('iter')
                drawnow

                subplot(2,4,3)
                semilogy( abs(torqueYhstry(1:index, 1)) )
                title( 'torqueY')
                xlabel('iter')

                subplot(2,4,4)
                semilogy( abs(torqueZhstry(1:index, 1)) )
                title( 'torqueZ')
                xlabel('iter')
                drawnow
                        
                subplot(2,4,5)
                semilogy(  abs(accXhstry(1:index, 1)) )
                title( 'accX')
                xlabel('iter')
                drawnow

                subplot(2,4,6)
                semilogy( abs(alphaXhstry(1:index, 1)) ) 
                title( 'alphaX')
                xlabel('iter')
                drawnow
                
                subplot(2,4,7)
                semilogy( abs(alphaYhstry(1:index, 1)) )
                title( 'alphaY')
                xlabel('iter')
                drawnow

                subplot(2,4,8)
                semilogy( abs(alphaZhstry(1:index, 1)) )
                title( 'alphaZ')
                xlabel('iter')                 
                drawnow
                
                
                %check if iteration reaches oscillation state 
                if (abs(accX)<1e-8) && (abs(alphaX)<1e-3) && (abs(alphaY)<1e-3) && (abs(alphaZ)<1e-3) && (index >= 10)
                        if abs(Omega_x - omegaXhstry(index-1,1)) < 1e-3
                                if abs( alphaX ) > abs( alphaXhstry(index-1,1) )
                                        counterOscillation = counterOscillation + 1;
                                end
                        end
                        if  abs(Omega_y - omegaYhstry(index-1,1)) < 1e-3
                                if abs( alphaY ) > abs( alphaYhstry(index-1,1) )
                                        counterOscillation = counterOscillation + 1;
                                end
                        end
                        if  abs(Omega_z - omegaZhstry(index-1,1)) < 1e-3
                                if abs( alphaZ ) > abs( alphaZhstry(index-1,1) )
                                        counterOscillation = counterOscillation + 1;
                                end
                        end
                        if  abs(Vp_x - vPxhstry(index-1,1)) < 1e-3
                                if abs( accX ) > abs( accXhstry(index-1,1) )
                                        counterOscillation = counterOscillation + 1;
                                end
                        end
                end
                

                

                % In order to prevent the oscillation from intervient the convergency, time step is reduced
                if (counterOscillation > 10)
                        fprintf('The oscillation state is detected! Time step is reduced! \n');
                        if (deltaT > 1e-7)
                                deltaT = deltaT / 2;
                                counterOscillation = 0;
                        else
                                deltaT = 1e-7;
                                counterOscillation = 0;
                                fprintf('Warning! the minimum timestep is reached! \n');
                        end
                        %let the calculation move on
                        continue;                
                end
                
                % the convergency criterion
                if ( (abs(accX)<1e-10) && (abs(alphaX)<1e-5) && (abs(alphaY)<1e-5) && (abs(alphaZ)<1e-5) )
                        ifConverged = true;
                        fprintf('the loop converges! Good convergency criterion reached! \n');
                        fprintf('It takes %d iterations to reach the convergency! \n', index );                
                        break;   
                end

                if (index == 1000)                      
                        if (ifConverged == false)
                                fprintf('the loop fail to converge! \n');
                                break;
                        end
                end
        end


        % the Debug part
        % numIter = 10; 
        % for index = 1:numIter
        %         %get the dynamic variables
        %         Fx      = 1;
        %         Fy      = 1;
        %         Fz      = 1;
        %         torqueX = 1;
        %         torqueY = 1;
        %         torqueZ = 1;
        %         accX    = 1;
        %         accY    = 1;
        %         accZ    = 1;
        %         alphaX  = 1;
        %         alphaY  = 1;
        %         alphaZ  = 1;
        %         %calculate next step's velocity and angular velocity
        %         Vp_x    = Vp_x    + (accX   * deltaT);
        %         Omega_x = Omega_x + (alphaX * deltaT);
        %         Omega_y = Omega_y + (alphaY * deltaT);
        %         Omega_z = Omega_z + (alphaZ * deltaT);
                
        %         vPxhstry(index,1)        = Vp_x;

        %         omegaXhstry(index,1)     = Omega_x;
        %         omegaYhstry(index,1)     = Omega_y;
        %         omegaZhstry(index,1)     = Omega_z;
                
        %         Fxhstry(index,1)         = Fx;
        %         Fyhstry(index,1)         = Fy;
        %         Fzhstry(index,1)         = Fz;
                
        %         torqueXhstry(index,1)    = torqueX;
        %         torqueYhstry(index,1)    = torqueY;
        %         torqueZhstry(index,1)    = torqueZ;
                
        %         accXhstry(index,1)       = accX;
        %         accYhstry(index,1)       = accY;
        %         accZhstry(index,1)       = accZ;
                
        %         alphaXhstry(index,1)     = alphaX;
        %         alphaYhstry(index,1)     = alphaY;
        %         alphaZhstry(index,1)     = alphaZ;

        %         iterMonitor = figure(1);
        %         set(iterMonitor, 'name', [ 'deltaT is ', num2str(deltaT), ' oscillation is ', num2str(counterOscillation), ' iteration number is ', num2str(index) ], 'Numbertitle', 'off' );
        %         subplot(2,4,1)
        %         plot( Fxhstry(1:index, 1) )
        %         title('Fx')
        %         xlabel('iter')
        %         drawnow

        %         subplot(2,4,2)
        %         semilogy( abs(torqueXhstry(1:index, 1)) )
        %         title( 'torqueX')
        %         xlabel('iter')
        %         drawnow

        %         subplot(2,4,3)
        %         semilogy( abs(torqueYhstry(1:index, 1)) )
        %         title( 'torqueY')
        %         xlabel('iter')

        %         subplot(2,4,4)
        %         semilogy( abs(torqueZhstry(1:index, 1)) )
        %         title( 'torqueZ')
        %         xlabel('iter')
        %         drawnow
                        
        %         subplot(2,4,5)
        %         semilogy(  abs(accXhstry(1:index, 1)) )
        %         title( 'accX')
        %         xlabel('iter')
        %         drawnow

        %         subplot(2,4,6)
        %         semilogy( abs(alphaXhstry(1:index, 1)) ) 
        %         title( 'alphaX')
        %         xlabel('iter')
        %         drawnow
                
        %         subplot(2,4,7)
        %         semilogy( abs(alphaYhstry(1:index, 1)) )
        %         title( 'alphaY')
        %         xlabel('iter')
        %         drawnow

        %         subplot(2,4,8)
        %         semilogy( abs(alphaZhstry(1:index, 1)) )
        %         title( 'alphaZ')
        %         xlabel('iter')                 
        %         drawnow
                
                
        %         %check if iteration reaches oscillation state 
        %         if (abs(accX)<1e-8) && (abs(alphaX)<1e-3) && (abs(alphaY)<1e-3) && (abs(alphaZ)<1e-3) && (index >= 10)
        %                 if abs(Omega_x - omegaXhstry(index-1,1)) < 1e-3
        %                         if abs( alphaX ) > abs( alphaXhstry(index-1,1) )
        %                                 counterOscillation = counterOscillation + 1;
        %                         end
        %                 end
        %                 if  abs(Omega_y - omegaYhstry(index-1,1)) < 1e-3
        %                         if abs( alphaY ) > abs( alphaYhstry(index-1,1) )
        %                                 counterOscillation = counterOscillation + 1;
        %                         end
        %                 end
        %                 if  abs(Omega_z - omegaZhstry(index-1,1)) < 1e-3
        %                         if abs( alphaZ ) > abs( alphaZhstry(index-1,1) )
        %                                 counterOscillation = counterOscillation + 1;
        %                         end
        %                 end
        %                 if  abs(Vp_x - vPxhstry(index-1,1)) < 1e-3
        %                         if abs( accX ) > abs( accXhstry(index-1,1) )
        %                                 counterOscillation = counterOscillation + 1;
        %                         end
        %                 end
        %         end
                

                

        %         % In order to prevent the oscillation from intervient the convergency, time step is reduced
        %         if (counterOscillation > 10)
        %                 fprintf('The oscillation state is detected! Time step is reduced! \n');
        %                 if (deltaT > 1e-7)
        %                         deltaT = deltaT / 2;
        %                         counterOscillation = 0;
        %                 else
        %                         deltaT = 1e-7;
        %                         counterOscillation = 0;
        %                         fprintf('Warning! the minimum timestep is reached! \n');
        %                 end
        %                 %let the calculation move on
        %                 continue;                
        %         end
                
        %         % the convergency criterion
        %         if ( (abs(accX)<1e-10) && (abs(alphaX)<1e-5) && (abs(alphaY)<1e-5) && (abs(alphaZ)<1e-5) )
        %                 ifConverged = true;
        %                 fprintf('the loop converges! Good convergency criterion reached! \n');
        %                 fprintf('It takes %d iterations to reach the convergency! \n', index );                
        %                 break;   
        %         end

        %         if (index == 1000)                      
        %                 if (ifConverged == false)
        %                         fprintf('the loop fail to converge! \n');
        %                         break;
        %                 end
        %         end
        % end











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

end