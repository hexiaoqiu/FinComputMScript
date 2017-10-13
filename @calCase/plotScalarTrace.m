function plotScalarTrace(theCase, name, figNo, data1, data2)
%myFun - Description
%
% Syntax: ifSuccessful = plotTrace(data1, data2, data3, data4, data5,data6)
%
% Long description
        idx = theCase.index;
        
        monitor = figure( figNo );
        set( monitor, 'name', [ name, ' convegent process' ], 'Numbertitle', 'off');
        subplot(1,2,1)
        plot( data1(1:idx, 1) )
        title( [name,' X'] )
        xlabel('iter')
        drawnow

        subplot(1,2,2)
        semilogy( data2(1:idx, 1) )
        title( [name,' X incre'])
        xlabel('iter')
        drawnow

end