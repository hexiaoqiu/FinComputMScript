function stepForward( theCase )
        vpX   = getVpX( theCase.flowModel);
        omega = getOmg(theCase.flowModel);
        acc   = getAcc(theCase.flowModel);
        alpha = getAlpha(theCase.flowModel);

        vpX   = vpX     + acc(1)   * theCase.deltaT;
        omega = omega   + alpha    * theCase.deltaT;

        setVpXOmg( vpX, omega, theCase.flowModel);

end