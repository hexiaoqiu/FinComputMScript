classdef  calCase < handle
        properties (SetAccess = private)
                flowModel
                numIter;
                deltaT;

                Fi          = struct('x',0,'y',0,'z',0);
                steadyVpX   = 0;
                steadyForce = struct('x',0,'y',0,'z',0);
                steadyOmg   = struct('x',0,'y',0,'z',0);
                steadyTau   = struct('x',0,'y',0,'z',0);
                steadyAcc   = struct('x',0,'y',0,'z',0);
                steadyAlpha = struct('x',0,'y',0,'z',0);

                initCd = struct('vpX',0,'omegaX',0,'omegaY',0,'omegaZ',0);

                vpXHstry   ;
                omgXHstry  ;
                omgYHstry  ;
                omgZHstry  ;
                FxHstry    ;
                FyHstry    ;
                FzHstry    ;
                tauXHstry  ;
                tauYHstry  ;
                tauZHstry  ;
                accXHstry  ;
                accYHstry  ;
                accZHstry  ;
                alphaXHstry;
                alphaYHstry;
                alphaZHstry;

                deltaVpXHstry   ;
                deltaOmgXHstry  ;
                deltaOmgYHstry  ;
                deltaOmgZHstry  ;
                deltaFxHstry    ;
                deltaFyHstry    ;
                deltaFzHstry    ;
                deltaTauXHstry  ;
                deltaTauYHstry  ;
                deltaTauZHstry  ;
                deltaAccXHstry  ;
                deltaAccYHstry  ;
                deltaAccZHstry  ;
                deltaAlphaXHstry;
                deltaAlphaYHstry;
                deltaAlphaZHstry;

                varVpXHstry     ;
                varOmgXHstry    ;
                varOmgYHstry    ;
                varOmgZHstry    ;
                varFxHstry      ;
                varFyHstry      ;
                varFzHstry      ;
                varTauXHstry    ;
                varTauYHstry    ;
                varTauZHstry    ;
                varAccXHstry    ;
                varAccYHstry    ;
                varAccZHstry    ;
                varAlphaXHstry  ;
                varAlphaYHstry  ;
                varAlphaZHstry  ;
        end

        methods 
                function theCase = calCase( fM )
                        theCase.flowModel = fM;
                        theCase.numIter = 100;
                        theCase.deltaT = 1e-6;
                        theCase.vpXHstry    = zeros(theCase.numIter,1);
                        theCase.omgXHstry   = zeros(theCase.numIter,1);
                        theCase.omgYHstry   = zeros(theCase.numIter,1);
                        theCase.omgZHstry   = zeros(theCase.numIter,1);
                        theCase.FxHstry     = zeros(theCase.numIter,1);
                        theCase.FyHstry     = zeros(theCase.numIter,1);
                        theCase.FzHstry     = zeros(theCase.numIter,1);
                        theCase.tauXHstry   = zeros(theCase.numIter,1);
                        theCase.tauYHstry   = zeros(theCase.numIter,1);
                        theCase.tauZHstry   = zeros(theCase.numIter,1);
                        theCase.accXHstry   = zeros(theCase.numIter,1);
                        theCase.accYHstry   = zeros(theCase.numIter,1);
                        theCase.accZHstry   = zeros(theCase.numIter,1);
                        theCase.alphaXHstry = zeros(theCase.numIter,1);
                        theCase.alphaYHstry = zeros(theCase.numIter,1);
                        theCase.alphaZHstry = zeros(theCase.numIter,1);

                        theCase.deltaVpXHstry    = zeros(theCase.numIter,1);
                        theCase.deltaOmgXHstry   = zeros(theCase.numIter,1);
                        theCase.deltaOmgYHstry   = zeros(theCase.numIter,1);
                        theCase.deltaOmgZHstry   = zeros(theCase.numIter,1);
                        theCase.deltaFxHstry     = zeros(theCase.numIter,1);
                        theCase.deltaFyHstry     = zeros(theCase.numIter,1);
                        theCase.deltaFzHstry     = zeros(theCase.numIter,1);
                        theCase.deltaTauXHstry   = zeros(theCase.numIter,1);
                        theCase.deltaTauYHstry   = zeros(theCase.numIter,1);
                        theCase.deltaTauZHstry   = zeros(theCase.numIter,1);
                        theCase.deltaAccXHstry   = zeros(theCase.numIter,1);
                        theCase.deltaAccYHstry   = zeros(theCase.numIter,1);
                        theCase.deltaAccZHstry   = zeros(theCase.numIter,1);
                        theCase.deltaAlphaXHstry = zeros(theCase.numIter,1);
                        theCase.deltaAlphaYHstry = zeros(theCase.numIter,1);
                        theCase.deltaAlphaZHstry = zeros(theCase.numIter,1);

                        theCase.varVpXHstry      = zeros(theCase.numIter, 1);
                        theCase.varOmgXHstry     = zeros(theCase.numIter, 1);
                        theCase.varOmgYHstry     = zeros(theCase.numIter, 1);
                        theCase.varOmgZHstry     = zeros(theCase.numIter, 1);
                        theCase.varFxHstry       = zeros(theCase.numIter, 1);
                        theCase.varFyHstry       = zeros(theCase.numIter, 1);
                        theCase.varFzHstry       = zeros(theCase.numIter, 1);
                        theCase.varTauXHstry     = zeros(theCase.numIter, 1);
                        theCase.varTauYHstry     = zeros(theCase.numIter, 1);
                        theCase.varTauZHstry     = zeros(theCase.numIter, 1);
                        theCase.varAccXHstry     = zeros(theCase.numIter, 1);
                        theCase.varAccYHstry     = zeros(theCase.numIter, 1);
                        theCase.varAccZHstry     = zeros(theCase.numIter, 1);
                        theCase.varAlphaXHstry   = zeros(theCase.numIter, 1);
                        theCase.varAlphaYHstry   = zeros(theCase.numIter, 1);
                        theCase.varAlphaZHstry   = zeros(theCase.numIter, 1);

                end

                compute( theCase );
                stepForward( theCase );
        end
        
end