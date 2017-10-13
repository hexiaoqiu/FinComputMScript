function plotCase(theCase)
%myFun - Description
%
% Syntax: plotCase(theCase)
%
% Long description

        theCase.plotTrace( 'F',     66, theCase.FxHstry, theCase.FyHstry, theCase.FzHstry, theCase.deltaFxHstry, theCase.deltaFyHstry, theCase.deltaFzHstry);
        theCase.plotTrace( 'Tau',   16, theCase.tauXHstry, theCase.tauYHstry, theCase.tauZHstry, theCase.deltaTauXHstry, theCase.deltaTauYHstry, theCase.deltaTauZHstry);
        theCase.plotTrace( 'Acc',   26, theCase.accXHstry, theCase.accYHstry, theCase.accZHstry, theCase.deltaAccXHstry, theCase.deltaAccYHstry, theCase.deltaAccZHstry);
        theCase.plotTrace( 'Alpha', 36, theCase.alphaXHstry, theCase.alphaYHstry, theCase.alphaZHstry, theCase.deltaAlphaXHstry, theCase.deltaAlphaYHstry, theCase.deltaAlphaZHstry);
        theCase.plotTrace( 'Omega', 86, theCase.omgXHstry, theCase.omgYHstry, theCase.omgZHstry, theCase.deltaOmgXHstry, theCase.deltaOmgYHstry, theCase.deltaOmgZHstry);
        
        pic = figure(96);
        subplot(1,2,1)
        plot( theCase.vpXHstry(1:theCase.index) )
        title('Vitess X')
        xlabel('iter');
        drawnow

        subplot(1,2,2)
        plot( theCase.deltaVpXHstry(1:theCase.index) )
        title('Vitess X Incre')
        xlabel('iter');
        drawnow

end