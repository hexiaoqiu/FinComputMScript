function stepForward( theCase )
        theCase.flowModel.vpX     = theCase.flowModel.vpX     + theCase.flowModel.acc.x   * theCase.deltaT;
        theCase.flowModel.omega.x = theCase.flowModel.omega.x + theCase.flowModel.alpha.x * theCase.deltaT;
        theCase.flowModel.omega.y = theCase.flowModel.omega.y + theCase.flowModel.alpha.y * theCase.deltaT;
        theCase.flowModel.omega.z = theCase.flowModel.omega.z + theCase.flowModel.alpha.z * theCase.deltaT;

        updateVpXOmg(theCase.flowModel);

        theCase.flowModel.updated = false;
end