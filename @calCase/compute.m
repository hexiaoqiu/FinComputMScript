function ok = compute( theCase )

        %configuration of sub Loop for inertial lift force calculation
        ifConverged = false;       
        theCase.flowModel.setVpXOmg( theCase.initCd.vpX, theCase.initCd.omega);
        % iteration code
        for idx = 1:theCase.numIter

                theCase.index = idx;
                theCase.flowModel.updateFTau();
                theCase.keepTracks();
                theCase.stepForward();
                theCase.plotCase();

                if theCase.checkConvergency() == true
                        ifConverged = true;
                        break;
                end

                if (theCase.index == theCase.numIter)                      
                        if (ifConverged == false)
                                fprintf('the loop fail to converge! \n');
                                break;
                        end
                end

        end

        %Output the vars
        if ifConverged == true
                theCase.steadyVpX    = theCase.flowModel.getVpX();
                theCase.steadyOmg    = theCase.flowModel.getOmg();
                theCase.steadyForce  = theCase.flowModel.getForce();
                theCase.steadyTau    = theCase.flowModel.getTau();
                theCase.steadyAcc    = theCase.flowModel.getAcc();
                theCase.steadyAlpha  = theCase.flowModel.getAlpha();
                theCase.Fi           = theCase.steadyForce;
                theCase.initCd.vpX   = theCase.steadyVpX;
                theCase.initCd.omega = theCase.steadyOmg;
                ok = true;
        else
                ok = false;
        end

end