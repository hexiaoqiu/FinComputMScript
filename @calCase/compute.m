function ok = compute( theCase )

        %configuration of sub Loop for inertial lift force calculation
        ifConverged = false;       
        setVpXOmg( theCase.initCd.vpX, theCase.initCd.omega,  theCase.flowModel );
        % iteration code
        for index = 1:theCase.numIter

                updateFTau( theCase.flowModel );
                keepTracks( index, theCase );
                stepForward( theCase );

                if checkConvergency(index,theCase) == true
                        ifConverged = true;
                        break;
                end

                if (index == theCase.numIter)                      
                        if (ifConverged == false)
                                fprintf('the loop fail to converge! \n');
                                break;
                        end
                end

        end
        theCase.steadyVpX = getVpX( theCase.flowModel );
        theCase.steadyOmg = getOmg( theCase.flowModel );
        theCase.steadyForce = getForce( theCase.flowModel );
        theCase.steadyTau = getTau( theCase.flowModel );
        theCase.steadyAcc = getAcc( theCase.flowModel );
        theCase.steadyAlpha = getAlpha( theCase.flowModel );
        theCase.Fi =  theCase.steadyForce


        %Output the vars
        if ifConverged == true
                ok = true;
        else
                ok = false;
        end

end