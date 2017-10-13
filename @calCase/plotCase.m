function plotCase(theCase)
%myFun - Description
%
% Syntax: plotCase(theCase)
%
% Long description

        theCase.plotVectorTrace( 'F',     56, theCase.FxHstry, theCase.FyHstry, theCase.FzHstry, theCase.deltaFxHstry, theCase.deltaFyHstry, theCase.deltaFzHstry);
        theCase.plotVectorTrace( 'Tau',   16, theCase.tauXHstry, theCase.tauYHstry, theCase.tauZHstry, theCase.deltaTauXHstry, theCase.deltaTauYHstry, theCase.deltaTauZHstry);
        theCase.plotVectorTrace( 'Acc',   26, theCase.accXHstry, theCase.accYHstry, theCase.accZHstry, theCase.deltaAccXHstry, theCase.deltaAccYHstry, theCase.deltaAccZHstry);
        theCase.plotVectorTrace( 'Alpha', 36, theCase.alphaXHstry, theCase.alphaYHstry, theCase.alphaZHstry, theCase.deltaAlphaXHstry, theCase.deltaAlphaYHstry, theCase.deltaAlphaZHstry);
        theCase.plotVectorTrace( 'Omega', 86, theCase.omgXHstry, theCase.omgYHstry, theCase.omgZHstry, theCase.deltaOmgXHstry, theCase.deltaOmgYHstry, theCase.deltaOmgZHstry);
        
        theCase.plotScalarTrace( 'VitessX', 96, theCase.vpXHstry, theCase.deltaVpXHstry);

end