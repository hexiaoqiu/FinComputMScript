function ok = keepTracks(index, state, dataPack, flowModel)
%myFun - Description
%
% Syntax: ok = keepTracks(Fx, Fy, Fz, torqueX, tauY, tauZ, accX, accY, accZ, alphaX, alphaY, alphaZ)
%
% Long description

    YpStr       = char( flowModel.param.get('Yp') );
    ZpStr       = char( flowModel.param.get('Zp') );


    dataPack.vpXHstry(index,1)        = state.vpX;
    dataPack.omgXHstry(index,1)     = state.omgX;
    dataPack.omgYHstry(index,1)     = state.omgY;
    dataPack.omgZHstry(index,1)     = state.omgZ;
    dataPack.FxHstry(index,1)         = state.Fx;
    dataPack.FyHstry(index,1)         = state.Fy;
    dataPack.FzHstry(index,1)         = state.Fz;
    dataPack.tauXHstry(index,1)    = state.tauX;
    dataPack.tauYHstry(index,1)    = state.tauY;
    dataPack.tauZHstry(index,1)    = state.tauZ;
    dataPack.accXHstry(index,1)       = state.accX;
    dataPack.accYHstry(index,1)       = state.accY;
    dataPack.accZHstry(index,1)       = state.accZ;
    dataPack.alphaXHstry(index,1)     = state.alphaX;
    dataPack.alphaYHstry(index,1)     = state.alphaY;
    dataPack.alphaZHstry(index,1)     = state.alphaZ;

    dataPack.deltaVpXHstry(index,1)     = abs( dataPack.vpXHstry(index,1)     - dataPack.vpXHstry(index-1,1)     );
    dataPack.deltaOmgXHstry(index,1)  = abs( dataPack.omgXHstry(index,1)  - dataPack.omgXHstry(index-1,1)  );
    dataPack.deltaOmgYHstry(index,1)  = abs( dataPack.omgYHstry(index,1)  - dataPack.omgYHstry(index-1,1)  );
    dataPack.deltaOmgZHstry(index,1)  = abs( dataPack.omgZHstry(index,1)  - dataPack.omgZHstry(index-1,1)  );
    dataPack.deltaFxHstry(index,1)      = abs( dataPack.FxHstry(index,1)      - dataPack.FxHstry(index-1,1)      );
    dataPack.deltaFyHstry(index,1)      = abs( dataPack.FyHstry(index,1)      - dataPack.FyHstry(index-1,1)      );
    dataPack.deltaFzHstry(index,1)      = abs( dataPack.FzHstry(index,1)      - dataPack.FzHstry(index-1,1)      );
    dataPack.deltaTauXHstry(index,1) = abs( dataPack.tauXHstry(index,1) - dataPack.tauXHstry(index-1,1) );
    dataPack.deltaTauYHstry(index,1) = abs( dataPack.tauYHstry(index,1) - dataPack.tauYHstry(index-1,1) );
    dataPack.deltaTauZHstry(index,1) = abs( dataPack.tauZHstry(index,1) - dataPack.tauZHstry(index-1,1) );
    dataPack.deltaAccXHstry(index,1)    = abs( dataPack.accXHstry(index,1)    - dataPack.accXHstry(index-1,1)    );
    dataPack.deltaAccYHstry(index,1)    = abs( dataPack.accYHstry(index,1)    - dataPack.accYHstry(index-1,1)    );
    dataPack.deltaAccZHstry(index,1)    = abs( dataPack.accZHstry(index,1)    - dataPack.accZHstry(index-1,1)    );
    dataPack.deltaAlphaXHstry(index,1)  = abs( dataPack.alphaXHstry(index,1)  - dataPack.alphaXHstry(index-1,1)  );
    dataPack.deltaAlphaYHstry(index,1)  = abs( dataPack.alphaYHstry(index,1)  - dataPack.alphaYHstry(index-1,1)  );
    dataPack.deltaAlphaZHstry(index,1)  = abs( dataPack.alphaZHstry(index,1)  - dataPack.alphaZHstry(index-1,1)  );

    dataPack.varVpXHstry(index,1)       = abs( dataPack.deltaVpXHstry(index,1)       /   dataPack.vpXHstry(index,1)     );
    dataPack.varOmgXHstry(index,1)    = abs( dataPack.deltaOmgXHstry(index,1)    /   dataPack.omgXHstry(index,1)  );
    dataPack.varOmgYHstry(index,1)    = abs( dataPack.deltaOmgYHstry(index,1)    /   dataPack.omgYHstry(index,1)  );
    dataPack.varOmgZHstry(index,1)    = abs( dataPack.deltaOmgZHstry(index,1)    /   dataPack.omgZHstry(index,1)  );
    dataPack.varFxHstry(index,1)        = abs( dataPack.deltaFxHstry(index,1)        /   dataPack.FxHstry(index,1)      );
    dataPack.varFyHstry(index,1)        = abs( dataPack.deltaFyHstry(index,1)        /   dataPack.FyHstry(index,1)      );
    dataPack.varFzHstry(index,1)        = abs( dataPack.deltaFzHstry(index,1)        /   dataPack.FzHstry(index,1)      );
    dataPack.varTauXHstry(index,1)   = abs( dataPack.deltaTauXHstry(index,1)   /   dataPack.tauXHstry(index,1) );
    dataPack.varTauYHstry(index,1)   = abs( dataPack.deltaTauYHstry(index,1)   /   dataPack.tauYHstry(index,1) );
    dataPack.varTauZHstry(index,1)   = abs( dataPack.deltaTauZHstry(index,1)   /   dataPack.tauZHstry(index,1) );
    dataPack.varAccXHstry(index,1)      = abs( dataPack.deltaAccXHstry(index,1)      /   dataPack.accXHstry(index,1)    );
    dataPack.varAccYHstry(index,1)      = abs( dataPack.deltaAccYHstry(index,1)      /   dataPack.accYHstry(index,1)    );
    dataPack.varAccZHstry(index,1)      = abs( dataPack.deltaAccZHstry(index,1)      /   dataPack.accZHstry(index,1)    );
    dataPack.varAlphaXHstry(index,1)    = abs( dataPack.deltaAlphaXHstry(index,1)    /   dataPack.alphaXHstry(index,1)  );
    dataPack.varAlphaYHstry(index,1)    = abs( dataPack.deltaAlphaYHstry(index,1)    /   dataPack.alphaYHstry(index,1)  );
    dataPack.varAlphaZHstry(index,1)    = abs( dataPack.deltaAlphaZHstry(index,1)    /   dataPack.alphaZHstry(index,1)  );

    save(['Yp_',YpStr,'Zp_',ZpStr,'_PointTrack.mat'], 'dataPack');

    
end