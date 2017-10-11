function run( theCase )

        %configuration of sub Loop for inertial lift force calculation
        ifConverged = false;       
        theCase.flowModel.setVpOmg( theCase.initCd.vpX, ...,
                                            theCase.initCd.omegaX, theCase.initCd.omegaY, theCase.initCd.omegaZ, ...,
                                            theCase.flowModel );
        % iteration code
        for index = 3:numIter

                updateFTau( theCase.flowModel );
                keepTracks( theCase );
                stepForward( theCase );



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

end