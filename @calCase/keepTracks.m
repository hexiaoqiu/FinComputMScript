function keepTracks(index, theCase)
%myFun - Description
%
% Syntax: ok = keepTracks(Fx, Fy, Fz, torqueX, tauY, tauZ, accX, accY, accZ, alphaX, alphaY, alphaZ)
%
% Long description

    theCase.vpXHstry(index)         = theCase.flowModel.vpX;
    theCase.omgXHstry(index)        = theCase.flowModel.omega(1);
    theCase.omgYHstry(index)        = theCase.flowModel.omega(2);
    theCase.omgZHstry(index)        = theCase.flowModel.omega(3);
    theCase.FxHstry(index)          = theCase.flowModel.force(1);
    theCase.FyHstry(index)          = theCase.flowModel.force(2);
    theCase.FzHstry(index)          = theCase.flowModel.force(3);
    theCase.tauXHstry(index)        = theCase.flowModel.tau(1);
    theCase.tauYHstry(index)        = theCase.flowModel.tau(2);
    theCase.tauZHstry(index)        = theCase.flowModel.tau(3);
    theCase.accXHstry(index)        = theCase.flowModel.acc(1);
    theCase.accYHstry(index)        = theCase.flowModel.acc(2);
    theCase.accZHstry(index)        = theCase.flowModel.acc(3);
    theCase.alphaXHstry(index)      = theCase.flowModel.alpha(1);
    theCase.alphaYHstry(index)      = theCase.flowModel.alpha(2);
    theCase.alphaZHstry(index)      = theCase.flowModel.alpha(3);

    if index == 1

            theCase.deltaVpXHstry(index)    = abs( theCase.vpXHstry(index)       );
            theCase.deltaOmgXHstry(index)   = abs( theCase.omgXHstry(index)  );
            theCase.deltaOmgYHstry(index)   = abs( theCase.omgYHstry(index)  );
            theCase.deltaOmgZHstry(index)   = abs( theCase.omgZHstry(index)  );
            theCase.deltaFxHstry(index)     = abs( theCase.FxHstry(index)        );
            theCase.deltaFyHstry(index)     = abs( theCase.FyHstry(index)        );
            theCase.deltaFzHstry(index)     = abs( theCase.FzHstry(index)        );
            theCase.deltaTauXHstry(index)   = abs( theCase.tauXHstry(index)  );
            theCase.deltaTauYHstry(index)   = abs( theCase.tauYHstry(index)  );
            theCase.deltaTauZHstry(index)   = abs( theCase.tauZHstry(index)  );
            theCase.deltaAccXHstry(index)   = abs( theCase.accXHstry(index)  );
            theCase.deltaAccYHstry(index)   = abs( theCase.accYHstry(index)  );
            theCase.deltaAccZHstry(index)   = abs( theCase.accZHstry(index)  );
            theCase.deltaAlphaXHstry(index) = abs( theCase.alphaXHstry(index)  );
            theCase.deltaAlphaYHstry(index) = abs( theCase.alphaYHstry(index)  );
            theCase.deltaAlphaZHstry(index) = abs( theCase.alphaZHstry(index)  );

            theCase.varVpXHstry(index)      = 1;
            theCase.varOmgXHstry(index)     = 1;
            theCase.varOmgYHstry(index)     = 1;
            theCase.varOmgZHstry(index)     = 1;
            theCase.varFxHstry(index)       = 1;
            theCase.varFyHstry(index)       = 1;
            theCase.varFzHstry(index)       = 1;
            theCase.varTauXHstry(index)     = 1;
            theCase.varTauYHstry(index)     = 1;
            theCase.varTauZHstry(index)     = 1;
            theCase.varAccXHstry(index)     = 1;
            theCase.varAccYHstry(index)     = 1;
            theCase.varAccZHstry(index)     = 1;
            theCase.varAlphaXHstry(index)   = 1;
            theCase.varAlphaYHstry(index)   = 1;
            theCase.varAlphaZHstry(index)   = 1;
    else
            theCase.deltaVpXHstry(index)    = abs( theCase.vpXHstry(index)     - theCase.vpXHstry(index-1)     );
            theCase.deltaOmgXHstry(index)   = abs( theCase.omgXHstry(index)  - theCase.omgXHstry(index-1)  );
            theCase.deltaOmgYHstry(index)   = abs( theCase.omgYHstry(index)  - theCase.omgYHstry(index-1)  );
            theCase.deltaOmgZHstry(index)   = abs( theCase.omgZHstry(index)  - theCase.omgZHstry(index-1)  );
            theCase.deltaFxHstry(index)     = abs( theCase.FxHstry(index)      - theCase.FxHstry(index-1)      );
            theCase.deltaFyHstry(index)     = abs( theCase.FyHstry(index)      - theCase.FyHstry(index-1)      );
            theCase.deltaFzHstry(index)     = abs( theCase.FzHstry(index)      - theCase.FzHstry(index-1)      );
            theCase.deltaTauXHstry(index)   = abs( theCase.tauXHstry(index) - theCase.tauXHstry(index-1) );
            theCase.deltaTauYHstry(index)   = abs( theCase.tauYHstry(index) - theCase.tauYHstry(index-1) );
            theCase.deltaTauZHstry(index)   = abs( theCase.tauZHstry(index) - theCase.tauZHstry(index-1) );
            theCase.deltaAccXHstry(index)   = abs( theCase.accXHstry(index)    - theCase.accXHstry(index-1)    );
            theCase.deltaAccYHstry(index)   = abs( theCase.accYHstry(index)    - theCase.accYHstry(index-1)    );
            theCase.deltaAccZHstry(index)   = abs( theCase.accZHstry(index)    - theCase.accZHstry(index-1)    );
            theCase.deltaAlphaXHstry(index) = abs( theCase.alphaXHstry(index)  - theCase.alphaXHstry(index-1)  );
            theCase.deltaAlphaYHstry(index) = abs( theCase.alphaYHstry(index)  - theCase.alphaYHstry(index-1)  );
            theCase.deltaAlphaZHstry(index) = abs( theCase.alphaZHstry(index)  - theCase.alphaZHstry(index-1)  );

            theCase.varVpXHstry(index)      = abs( theCase.deltaVpXHstry(index)       /   theCase.vpXHstry(index)     );
            theCase.varOmgXHstry(index)     = abs( theCase.deltaOmgXHstry(index)    /   theCase.omgXHstry(index)  );
            theCase.varOmgYHstry(index)     = abs( theCase.deltaOmgYHstry(index)    /   theCase.omgYHstry(index)  );
            theCase.varOmgZHstry(index)     = abs( theCase.deltaOmgZHstry(index)    /   theCase.omgZHstry(index)  );
            theCase.varFxHstry(index)       = abs( theCase.deltaFxHstry(index)        /   theCase.FxHstry(index)      );
            theCase.varFyHstry(index)       = abs( theCase.deltaFyHstry(index)        /   theCase.FyHstry(index)      );
            theCase.varFzHstry(index)       = abs( theCase.deltaFzHstry(index)        /   theCase.FzHstry(index)      );
            theCase.varTauXHstry(index)     = abs( theCase.deltaTauXHstry(index)   /   theCase.tauXHstry(index) );
            theCase.varTauYHstry(index)     = abs( theCase.deltaTauYHstry(index)   /   theCase.tauYHstry(index) );
            theCase.varTauZHstry(index)     = abs( theCase.deltaTauZHstry(index)   /   theCase.tauZHstry(index) );
            theCase.varAccXHstry(index)     = abs( theCase.deltaAccXHstry(index)      /   theCase.accXHstry(index)    );
            theCase.varAccYHstry(index)     = abs( theCase.deltaAccYHstry(index)      /   theCase.accYHstry(index)    );
            theCase.varAccZHstry(index)     = abs( theCase.deltaAccZHstry(index)      /   theCase.accZHstry(index)    );
            theCase.varAlphaXHstry(index)   = abs( theCase.deltaAlphaXHstry(index)    /   theCase.alphaXHstry(index)  );
            theCase.varAlphaYHstry(index)   = abs( theCase.deltaAlphaYHstry(index)    /   theCase.alphaYHstry(index)  );
            theCase.varAlphaZHstry(index)    = abs( theCase.deltaAlphaZHstry(index)    /   theCase.alphaZHstry(index)  );
    end
    
end