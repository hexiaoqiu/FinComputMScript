function keepTracks(theCase)
%myFun - Description
%
% Syntax: ok = keepTracks(Fx, Fy, Fz, torqueX, tauY, tauZ, accX, accY, accZ, alphaX, alphaY, alphaZ)
%
% Long description

    omega                              = theCase.flowModel.getOmg();
    force                              = theCase.flowModel.getForce();
    tau                                = theCase.flowModel.getTau();
    acc                                = theCase.flowModel.getAcc();
    alpha                              = theCase.flowModel.getAlpha();

    theCase.vpXHstry(theCase.index)    = theCase.flowModel.getVpX();
    theCase.omgXHstry(theCase.index)   = omega(1);
    theCase.omgYHstry(theCase.index)   = omega(2);
    theCase.omgZHstry(theCase.index)   = omega(3);
    theCase.FxHstry(theCase.index)     = force(1);
    theCase.FyHstry(theCase.index)     = force(2);
    theCase.FzHstry(theCase.index)     = force(3);
    theCase.tauXHstry(theCase.index)   = tau(1);
    theCase.tauYHstry(theCase.index)   = tau(2);
    theCase.tauZHstry(theCase.index)   = tau(3);
    theCase.accXHstry(theCase.index)   = acc(1);
    theCase.accYHstry(theCase.index)   = acc(2);
    theCase.accZHstry(theCase.index)   = acc(3);
    theCase.alphaXHstry(theCase.index) = alpha(1);
    theCase.alphaYHstry(theCase.index) = alpha(2);
    theCase.alphaZHstry(theCase.index) = alpha(3);

    if theCase.index == 1

            theCase.deltaVpXHstry(theCase.index)    = abs( theCase.vpXHstry(theCase.index)       );
            theCase.deltaOmgXHstry(theCase.index)   = abs( theCase.omgXHstry(theCase.index)  );
            theCase.deltaOmgYHstry(theCase.index)   = abs( theCase.omgYHstry(theCase.index)  );
            theCase.deltaOmgZHstry(theCase.index)   = abs( theCase.omgZHstry(theCase.index)  );
            theCase.deltaFxHstry(theCase.index)     = abs( theCase.FxHstry(theCase.index)        );
            theCase.deltaFyHstry(theCase.index)     = abs( theCase.FyHstry(theCase.index)        );
            theCase.deltaFzHstry(theCase.index)     = abs( theCase.FzHstry(theCase.index)        );
            theCase.deltaTauXHstry(theCase.index)   = abs( theCase.tauXHstry(theCase.index)  );
            theCase.deltaTauYHstry(theCase.index)   = abs( theCase.tauYHstry(theCase.index)  );
            theCase.deltaTauZHstry(theCase.index)   = abs( theCase.tauZHstry(theCase.index)  );
            theCase.deltaAccXHstry(theCase.index)   = abs( theCase.accXHstry(theCase.index)  );
            theCase.deltaAccYHstry(theCase.index)   = abs( theCase.accYHstry(theCase.index)  );
            theCase.deltaAccZHstry(theCase.index)   = abs( theCase.accZHstry(theCase.index)  );
            theCase.deltaAlphaXHstry(theCase.index) = abs( theCase.alphaXHstry(theCase.index)  );
            theCase.deltaAlphaYHstry(theCase.index) = abs( theCase.alphaYHstry(theCase.index)  );
            theCase.deltaAlphaZHstry(theCase.index) = abs( theCase.alphaZHstry(theCase.index)  );

            theCase.varVpXHstry(theCase.index)      = 1;
            theCase.varOmgXHstry(theCase.index)     = 1;
            theCase.varOmgYHstry(theCase.index)     = 1;
            theCase.varOmgZHstry(theCase.index)     = 1;
            theCase.varFxHstry(theCase.index)       = 1;
            theCase.varFyHstry(theCase.index)       = 1;
            theCase.varFzHstry(theCase.index)       = 1;
            theCase.varTauXHstry(theCase.index)     = 1;
            theCase.varTauYHstry(theCase.index)     = 1;
            theCase.varTauZHstry(theCase.index)     = 1;
            theCase.varAccXHstry(theCase.index)     = 1;
            theCase.varAccYHstry(theCase.index)     = 1;
            theCase.varAccZHstry(theCase.index)     = 1;
            theCase.varAlphaXHstry(theCase.index)   = 1;
            theCase.varAlphaYHstry(theCase.index)   = 1;
            theCase.varAlphaZHstry(theCase.index)   = 1;
    else
            theCase.deltaVpXHstry(theCase.index)    = abs( theCase.vpXHstry(theCase.index)     - theCase.vpXHstry(theCase.index-1)     );
            theCase.deltaOmgXHstry(theCase.index)   = abs( theCase.omgXHstry(theCase.index)  - theCase.omgXHstry(theCase.index-1)  );
            theCase.deltaOmgYHstry(theCase.index)   = abs( theCase.omgYHstry(theCase.index)  - theCase.omgYHstry(theCase.index-1)  );
            theCase.deltaOmgZHstry(theCase.index)   = abs( theCase.omgZHstry(theCase.index)  - theCase.omgZHstry(theCase.index-1)  );
            theCase.deltaFxHstry(theCase.index)     = abs( theCase.FxHstry(theCase.index)      - theCase.FxHstry(theCase.index-1)      );
            theCase.deltaFyHstry(theCase.index)     = abs( theCase.FyHstry(theCase.index)      - theCase.FyHstry(theCase.index-1)      );
            theCase.deltaFzHstry(theCase.index)     = abs( theCase.FzHstry(theCase.index)      - theCase.FzHstry(theCase.index-1)      );
            theCase.deltaTauXHstry(theCase.index)   = abs( theCase.tauXHstry(theCase.index) - theCase.tauXHstry(theCase.index-1) );
            theCase.deltaTauYHstry(theCase.index)   = abs( theCase.tauYHstry(theCase.index) - theCase.tauYHstry(theCase.index-1) );
            theCase.deltaTauZHstry(theCase.index)   = abs( theCase.tauZHstry(theCase.index) - theCase.tauZHstry(theCase.index-1) );
            theCase.deltaAccXHstry(theCase.index)   = abs( theCase.accXHstry(theCase.index)    - theCase.accXHstry(theCase.index-1)    );
            theCase.deltaAccYHstry(theCase.index)   = abs( theCase.accYHstry(theCase.index)    - theCase.accYHstry(theCase.index-1)    );
            theCase.deltaAccZHstry(theCase.index)   = abs( theCase.accZHstry(theCase.index)    - theCase.accZHstry(theCase.index-1)    );
            theCase.deltaAlphaXHstry(theCase.index) = abs( theCase.alphaXHstry(theCase.index)  - theCase.alphaXHstry(theCase.index-1)  );
            theCase.deltaAlphaYHstry(theCase.index) = abs( theCase.alphaYHstry(theCase.index)  - theCase.alphaYHstry(theCase.index-1)  );
            theCase.deltaAlphaZHstry(theCase.index) = abs( theCase.alphaZHstry(theCase.index)  - theCase.alphaZHstry(theCase.index-1)  );

            theCase.varVpXHstry(theCase.index)      = abs( theCase.deltaVpXHstry(theCase.index)       /   theCase.vpXHstry(theCase.index)     );
            theCase.varOmgXHstry(theCase.index)     = abs( theCase.deltaOmgXHstry(theCase.index)    /   theCase.omgXHstry(theCase.index)  );
            theCase.varOmgYHstry(theCase.index)     = abs( theCase.deltaOmgYHstry(theCase.index)    /   theCase.omgYHstry(theCase.index)  );
            theCase.varOmgZHstry(theCase.index)     = abs( theCase.deltaOmgZHstry(theCase.index)    /   theCase.omgZHstry(theCase.index)  );
            theCase.varFxHstry(theCase.index)       = abs( theCase.deltaFxHstry(theCase.index)        /   theCase.FxHstry(theCase.index)      );
            theCase.varFyHstry(theCase.index)       = abs( theCase.deltaFyHstry(theCase.index)        /   theCase.FyHstry(theCase.index)      );
            theCase.varFzHstry(theCase.index)       = abs( theCase.deltaFzHstry(theCase.index)        /   theCase.FzHstry(theCase.index)      );
            theCase.varTauXHstry(theCase.index)     = abs( theCase.deltaTauXHstry(theCase.index)   /   theCase.tauXHstry(theCase.index) );
            theCase.varTauYHstry(theCase.index)     = abs( theCase.deltaTauYHstry(theCase.index)   /   theCase.tauYHstry(theCase.index) );
            theCase.varTauZHstry(theCase.index)     = abs( theCase.deltaTauZHstry(theCase.index)   /   theCase.tauZHstry(theCase.index) );
            theCase.varAccXHstry(theCase.index)     = abs( theCase.deltaAccXHstry(theCase.index)      /   theCase.accXHstry(theCase.index)    );
            theCase.varAccYHstry(theCase.index)     = abs( theCase.deltaAccYHstry(theCase.index)      /   theCase.accYHstry(theCase.index)    );
            theCase.varAccZHstry(theCase.index)     = abs( theCase.deltaAccZHstry(theCase.index)      /   theCase.accZHstry(theCase.index)    );
            theCase.varAlphaXHstry(theCase.index)   = abs( theCase.deltaAlphaXHstry(theCase.index)    /   theCase.alphaXHstry(theCase.index)  );
            theCase.varAlphaYHstry(theCase.index)   = abs( theCase.deltaAlphaYHstry(theCase.index)    /   theCase.alphaYHstry(theCase.index)  );
            theCase.varAlphaZHstry(theCase.index)    = abs( theCase.deltaAlphaZHstry(theCase.index)    /   theCase.alphaZHstry(theCase.index)  );
    end
    
end