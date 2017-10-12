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
        fM.force(1), fM.force(2), fM.force(3), ...,
        fM.tau(1),   fM.tau(2),   fM.tau(3), ...,
        fM.acc(1),   fM.acc(2),   fM.acc(3), ...,
        fM.alpha(1), fM.alpha(2), fM.alpha(3) ...,
        ] ...,        
        = ..., 
        mphglobal(fM.mphModel, {'Fx','Fy', 'Fz', 'tau_x', 'tau_y', 'tau_z', 'accX', 'accY', 'accZ', 'alphaX', 'alphaY', 'alphaZ'});


end