%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 1          Initialization                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Key: 1. in Matlab Only values are manupulated, units can be checked in COMSOL Desktop
%

%*************************** load the model **********************************************&
ModelUtil.showProgress(true);
flowModel        = mphopen('LiuChao.mph', 'flowModel');
flowGeom         = flowModel.geom.get('geom1');
flowMesh         = flowModel.mesh.get('mesh1');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 2      Clarify the iterations' limits                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----> Channel Geometry
%                              channel Width y dimension
%                            ____________________________
%                            |                          |
%                            |                          |      
%    channel Hight           |                          |
%      z dimension           |                          |
%                            |__________________________|
Width  = flowModel.param.evaluate( {'y_Length'} );          %[m]
Height = flowModel.param.evaluate( {'z_Length'} );          %[m]
H      = flowModel.param.evaluate( {'H'}        );
%-----> Particle Geom
Rp            = flowModel.param.evaluate( {'Rp'} );                %[m]
Xp            = flowModel.param.evaluate( {'Xp'} );                %[m]
Yp            = flowModel.param.evaluate( {'Yp'} );                %[m]
Zp            = flowModel.param.evaluate( {'Zp'} );                %[m]
%-----> the particle shall never touch the wall
LimitZ        = Height/2  - Rp;                         % Upper Limitation of Z direct variation 
LimitY        = Width /2  - Rp;                         % Upper Limitation of Y direct variation 

%%
Y_undim = [0.1:0.1:1.4,1.525,1.55]';
Z_undim = [0.1:0.1:0.5,0.55]';
pstnTable = zeros(96,4);
idxG = 1;
for idxY = 1:1:16
        for idxZ = 1:1:6
                pstnTable(idxG,1) = Y_undim(idxY,1);
                pstnTable(idxG,2) = Z_undim(idxZ,1);
                pstnTable(idxG,3) = (Y_undim(idxY,1) * H/2 + H);
                pstnTable(idxG,4) = (Z_undim(idxZ,1) * H/2 + H/2);
                idxG = idxG + 1;
        end
end

testResult = zeros(96,21);
for idxG = 1:1:96
        testResult(idxG,1) = pstnTable(idxG,1);
        testResult(idxG,2) = pstnTable(idxG,2);
        testResult(idxG,3) = pstnTable(idxG,3);
        testResult(idxG,4) = pstnTable(idxG,4);
end

vPx_0       = 0;
omegaX_0    = 0;
omegaY_0    = 0;
omegaZ_0    = 0;
deltaT_0    = 2e-6;
initCd      = zeros(5,1);
initCd(1,1) = vPx_0   ;
initCd(2,1) = omegaX_0;
initCd(3,1) = omegaY_0;
initCd(4,1) = omegaZ_0;
initCd(5,1) = deltaT_0;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Step 3     Running  iterations                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxG = 1:1:16
                Yp              = testResult(idxG,3);        
                Zp              = testResult(idxG,4);
        testResult(idxG,5: 21)  = Get1PointFi(Yp, Zp, initCd, flowModel);
        LiuChao_NMshGStr0       = testResult;
        save('LiuChao_NMeshGStr0','LiuChao_NMeshGStr0');  
        quiver(LiuChao_NMeshGStr0(:,1), LiuChao_NMeshGStr0(:,2), LiuChao_NMeshGStr0(:,11), LiuChao_NMeshGStr0(:,12));     
end


% vPx_0            = 0.857730833816637;
% omegaX_0         = 36.691906804135650;
% omegaY_0         = -3.839509213725493e+04;
% omegaZ_0         = 1.233145755837119e+02;
% deltaT_0         = 1e-8;