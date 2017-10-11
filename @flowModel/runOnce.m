function runOnce(fM)
%myFun - Description
%       run once solver and get forces, torques, accelerations and angular accelerations
%       for next iteration
%
% Syntax: forceTau = runOnce(flowModel)
% input arguments list:
%               flowModel       the COMSOL model manipulated
% output arguments:
%               F_x
%               F_y
%               F_z
%               Torq_x
%               Torq_y
%               Torq_z
%               Acc_x
%               Acc_y
%               Acc_z
%               Alpha_x
%               Alpha_y
%               Alpha_z
% Long description
                  
        %solve the stationary flow field
        fM.mphModel.study('std1').run;
        %get the dynamic variables
        [ ...,
        fM.force.x, fM.force.y, fM.force.z, ...,
        fM.tau.x,   fM.tau.y,   fM.tau.z, ...,
        fM.acc.x,   fM.acc.y,   fM.acc.z, ...,
        fM.alpha.x, fM.alpha.y, fM.alpha.z ...,
        ] ...,        
        = ..., 
        mphglobal(fM.mphModel, {'Fx','Fy', 'Fz', 'tau_x', 'tau_y', 'tau_z', 'accX', 'accY', 'accZ', 'alphaX', 'alphaY', 'alphaZ'});


end