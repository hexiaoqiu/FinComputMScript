function stepForward( theCase )
        vpX   = theCase.flowModel.getVpX();
        omega = theCase.flowModel.getOmg();
        acc   = theCase.flowModel.getAcc();
        alpha = theCase.flowModel.getAlpha();

        vpX   = vpX     + acc(1)   * theCase.deltaT;
        omega = omega   + alpha    * theCase.deltaT;

        theCase.flowModel.setVpXOmg( vpX, omega);

end