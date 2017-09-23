function ifSuccessful = plotTrace(name,figNo, index, data1, data2, data3, data4, data5,data6)
%myFun - Description
%
% Syntax: ifSuccessful = plotTrace(data1, data2, data3, data4, data5,data6)
%
% Long description
        monitor = figure( figNo );
        set( monitor, 'name', [ name, ' convegent process' ], 'Numbertitle', 'off');
        subplot(2,3,1)
        plot( data1(1:index, 1) )
        title( [name,' X'] )
        xlabel('iter')
        drawnow

        subplot(2,3,2)
        plot( data2(1:index, 1) )
        title( [name,' Y'])
        xlabel('iter')
        drawnow

        subplot(2,3,3)
        plot( data3(1:index, 1) )
        title( [name,' Z'])
        xlabel('iter')

        subplot(2,3,4)
        semilogy( data4(1:index, 1) )
        title( [name,' X incre'])
        xlabel('iter')
        drawnow
                
        subplot(2,3,5)
        semilogy(  data5(1:index, 1) )
        title( [name,' Y incre'])
        xlabel('iter')
        drawnow

        subplot(2,3,6)
        semilogy( data6(1:index, 1) ) 
        title( [name,' Z incre'])
        xlabel('iter')
        drawnow

        ifSuccessful = true;
end