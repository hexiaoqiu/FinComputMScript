clc;
ModelUtil.showProgress(true);
%%
flowModel        = mphopen('mesh.mph', 'flowModel');
flowGeom         = flowModel.geom.get('geom1');
flowMesh         = flowModel.mesh.get('mesh1');
%%
mesh75W_initCd1 = zeros(1,19);
mesh75W_initCd1(1,1) = 25e-6;
mesh75W_initCd1(1,2) = 8e-6;
initCd1 = [0.857730833816637, 36.691906804135650, -3.839509213725493e+04, 1.233145755837119e+02];

% initCd = Mesh57W(4:7);
% initCd = zeros(1,4);

% vPx_0            = 0.857730833816637;
% omegaX_0         = 36.691906804135650;
% omegaY_0         = -3.839509213725493e+04;
% omegaZ_0         = 1.233145755837119e+02;
%%
clc;
mesh75W_initCd1(1,3:19) = FiCal(initCd1,1e6,flowModel);
save('mesh75W_initCd1','mesh75W_initCd1');

%%
mesh75W_initCd2 = zeros(1,19);
mesh75W_initCd2(1,1) = 25e-6;
mesh75W_initCd2(1,2) = 8e-6;
initCd2 = [-1.6, 0.8, 0.8,0.8 ];

%%
clc;
mesh75W_initCd2(1,3:19) = FiCal(initCd2,1e6,flowModel);
save('mesh75W_initCd2','mesh75W_initCd2');

%%
fx = mphglobal( flowModel, 'Fx' )


