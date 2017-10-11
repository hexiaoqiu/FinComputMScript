function keepTracks(index, theCase)
%myFun - Description
%
% Syntax: ok = keepTracks(Fx, Fy, Fz, torqueX, tauY, tauZ, accX, accY, accZ, alphaX, alphaY, alphaZ)
%
% Long description

    YpStr       = char( flowModel.param.get('Yp') );
    ZpStr       = char( flowModel.param.get('Zp') );


    theCase.vpXHstry(index,1)         = theCase.flowModel.vpX;
    theCase.omgXHstry(index,1)        = theCase.flowModel.omega.x;
    theCase.omgYHstry(index,1)        = theCase.flowModel.omega.y;
    theCase.omgZHstry(index,1)        = theCase.flowModel.omega.z;
    theCase.FxHstry(index,1)          = theCase.flowModel.force.x;
    theCase.FyHstry(index,1)          = theCase.flowModel.force.y;
    theCase.FzHstry(index,1)          = theCase.flowModel.force.x;
    theCase.tauXHstry(index,1)        = theCase.flowModel.tau.x;
    theCase.tauYHstry(index,1)        = theCase.flowModel.tau.y;
    theCase.tauZHstry(index,1)        = theCase.flowModel.tau.z;
    theCase.accXHstry(index,1)        = theCase.flowModel.acc.x;
    theCase.accYHstry(index,1)        = theCase.flowModel.acc.y;
    theCase.accZHstry(index,1)        = theCase.flowModel.acc.z;
    theCase.alphaXHstry(index,1)      = theCase.flowModel.alpha.x;
    theCase.alphaYHstry(index,1)      = theCase.flowModel.alpha.y;
    theCase.alphaZHstry(index,1)      = theCase.flowModel.alpha.z;

    if index == 1

            theCase.deltaVpXHstry(index,1)    = abs( theCase.vpXHstry(index,1)       );
            theCase.deltaOmgXHstry(index,1)   = abs( theCase.omgXHstry(index,1)  );
            theCase.deltaOmgYHstry(index,1)   = abs( theCase.omgYHstry(index,1)  );
            theCase.deltaOmgZHstry(index,1)   = abs( theCase.omgZHstry(index,1)  );
            theCase.deltaFxHstry(index,1)     = abs( theCase.FxHstry(index,1)        );
            theCase.deltaFyHstry(index,1)     = abs( theCase.FyHstry(index,1)        );
            theCase.deltaFzHstry(index,1)     = abs( theCase.FzHstry(index,1)        );
            theCase.deltaTauXHstry(index,1)   = abs( theCase.tauXHstry(index,1)  );
            theCase.deltaTauYHstry(index,1)   = abs( theCase.tauYHstry(index,1)  );
            theCase.deltaTauZHstry(index,1)   = abs( theCase.tauZHstry(index,1)  );
            theCase.deltaAccXHstry(index,1)   = abs( theCase.accXHstry(index,1)  );
            theCase.deltaAccYHstry(index,1)   = abs( theCase.accYHstry(index,1)  );
            theCase.deltaAccZHstry(index,1)   = abs( theCase.accZHstry(index,1)  );
            theCase.deltaAlphaXHstry(index,1) = abs( theCase.alphaXHstry(index,1)  );
            theCase.deltaAlphaYHstry(index,1) = abs( theCase.alphaYHstry(index,1)  );
            theCase.deltaAlphaZHstry(index,1) = abs( theCase.alphaZHstry(index,1)  );

            theCase.varVpXHstry(index,1)      = abs( theCase.deltaVpXHstry(index,1)       /   theCase.vpXHstry(index,1)     );
            theCase.varOmgXHstry(index,1)     = abs( theCase.deltaOmgXHstry(index,1)    /   theCase.omgXHstry(index,1)  );
            theCase.varOmgYHstry(index,1)     = abs( theCase.deltaOmgYHstry(index,1)    /   theCase.omgYHstry(index,1)  );
            theCase.varOmgZHstry(index,1)     = abs( theCase.deltaOmgZHstry(index,1)    /   theCase.omgZHstry(index,1)  );
            theCase.varFxHstry(index,1)       = abs( theCase.deltaFxHstry(index,1)        /   theCase.FxHstry(index,1)      );
            theCase.varFyHstry(index,1)       = abs( theCase.deltaFyHstry(index,1)        /   theCase.FyHstry(index,1)      );
            theCase.varFzHstry(index,1)       = abs( theCase.deltaFzHstry(index,1)        /   theCase.FzHstry(index,1)      );
            theCase.varTauXHstry(index,1)     = abs( theCase.deltaTauXHstry(index,1)   /   theCase.tauXHstry(index,1) );
            theCase.varTauYHstry(index,1)     = abs( theCase.deltaTauYHstry(index,1)   /   theCase.tauYHstry(index,1) );
            theCase.varTauZHstry(index,1)     = abs( theCase.deltaTauZHstry(index,1)   /   theCase.tauZHstry(index,1) );
            theCase.varAccXHstry(index,1)     = abs( theCase.deltaAccXHstry(index,1)      /   theCase.accXHstry(index,1)    );
            theCase.varAccYHstry(index,1)     = abs( theCase.deltaAccYHstry(index,1)      /   theCase.accYHstry(index,1)    );
            theCase.varAccZHstry(index,1)     = abs( theCase.deltaAccZHstry(index,1)      /   theCase.accZHstry(index,1)    );
            theCase.varAlphaXHstry(index,1)   = abs( theCase.deltaAlphaXHstry(index,1)    /   theCase.alphaXHstry(index,1)  );
            theCase.varAlphaYHstry(index,1)   = abs( theCase.deltaAlphaYHstry(index,1)    /   theCase.alphaYHstry(index,1)  );
            theCase.varAlphaZHstry(index,1)    = abs( theCase.deltaAlphaZHstry(index,1)    /   theCase.alphaZHstry(index,1)  );
    else
            theCase.deltaVpXHstry(index,1)    = abs( theCase.vpXHstry(index,1)     - theCase.vpXHstry(index-1,1)     );
            theCase.deltaOmgXHstry(index,1)   = abs( theCase.omgXHstry(index,1)  - theCase.omgXHstry(index-1,1)  );
            theCase.deltaOmgYHstry(index,1)   = abs( theCase.omgYHstry(index,1)  - theCase.omgYHstry(index-1,1)  );
            theCase.deltaOmgZHstry(index,1)   = abs( theCase.omgZHstry(index,1)  - theCase.omgZHstry(index-1,1)  );
            theCase.deltaFxHstry(index,1)     = abs( theCase.FxHstry(index,1)      - theCase.FxHstry(index-1,1)      );
            theCase.deltaFyHstry(index,1)     = abs( theCase.FyHstry(index,1)      - theCase.FyHstry(index-1,1)      );
            theCase.deltaFzHstry(index,1)     = abs( theCase.FzHstry(index,1)      - theCase.FzHstry(index-1,1)      );
            theCase.deltaTauXHstry(index,1)   = abs( theCase.tauXHstry(index,1) - theCase.tauXHstry(index-1,1) );
            theCase.deltaTauYHstry(index,1)   = abs( theCase.tauYHstry(index,1) - theCase.tauYHstry(index-1,1) );
            theCase.deltaTauZHstry(index,1)   = abs( theCase.tauZHstry(index,1) - theCase.tauZHstry(index-1,1) );
            theCase.deltaAccXHstry(index,1)   = abs( theCase.accXHstry(index,1)    - theCase.accXHstry(index-1,1)    );
            theCase.deltaAccYHstry(index,1)   = abs( theCase.accYHstry(index,1)    - theCase.accYHstry(index-1,1)    );
            theCase.deltaAccZHstry(index,1)   = abs( theCase.accZHstry(index,1)    - theCase.accZHstry(index-1,1)    );
            theCase.deltaAlphaXHstry(index,1) = abs( theCase.alphaXHstry(index,1)  - theCase.alphaXHstry(index-1,1)  );
            theCase.deltaAlphaYHstry(index,1) = abs( theCase.alphaYHstry(index,1)  - theCase.alphaYHstry(index-1,1)  );
            theCase.deltaAlphaZHstry(index,1) = abs( theCase.alphaZHstry(index,1)  - theCase.alphaZHstry(index-1,1)  );

            theCase.varVpXHstry(index,1)      = abs( theCase.deltaVpXHstry(index,1)       /   theCase.vpXHstry(index,1)     );
            theCase.varOmgXHstry(index,1)     = abs( theCase.deltaOmgXHstry(index,1)    /   theCase.omgXHstry(index,1)  );
            theCase.varOmgYHstry(index,1)     = abs( theCase.deltaOmgYHstry(index,1)    /   theCase.omgYHstry(index,1)  );
            theCase.varOmgZHstry(index,1)     = abs( theCase.deltaOmgZHstry(index,1)    /   theCase.omgZHstry(index,1)  );
            theCase.varFxHstry(index,1)       = abs( theCase.deltaFxHstry(index,1)        /   theCase.FxHstry(index,1)      );
            theCase.varFyHstry(index,1)       = abs( theCase.deltaFyHstry(index,1)        /   theCase.FyHstry(index,1)      );
            theCase.varFzHstry(index,1)       = abs( theCase.deltaFzHstry(index,1)        /   theCase.FzHstry(index,1)      );
            theCase.varTauXHstry(index,1)     = abs( theCase.deltaTauXHstry(index,1)   /   theCase.tauXHstry(index,1) );
            theCase.varTauYHstry(index,1)     = abs( theCase.deltaTauYHstry(index,1)   /   theCase.tauYHstry(index,1) );
            theCase.varTauZHstry(index,1)     = abs( theCase.deltaTauZHstry(index,1)   /   theCase.tauZHstry(index,1) );
            theCase.varAccXHstry(index,1)     = abs( theCase.deltaAccXHstry(index,1)      /   theCase.accXHstry(index,1)    );
            theCase.varAccYHstry(index,1)     = abs( theCase.deltaAccYHstry(index,1)      /   theCase.accYHstry(index,1)    );
            theCase.varAccZHstry(index,1)     = abs( theCase.deltaAccZHstry(index,1)      /   theCase.accZHstry(index,1)    );
            theCase.varAlphaXHstry(index,1)   = abs( theCase.deltaAlphaXHstry(index,1)    /   theCase.alphaXHstry(index,1)  );
            theCase.varAlphaYHstry(index,1)   = abs( theCase.deltaAlphaYHstry(index,1)    /   theCase.alphaYHstry(index,1)  );
            theCase.varAlphaZHstry(index,1)    = abs( theCase.deltaAlphaZHstry(index,1)    /   theCase.alphaZHstry(index,1)  );
    end
    
end