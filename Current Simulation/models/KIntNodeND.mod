: Jaymin Patel
: Created 10/06/09
: Filename = KIntNode.mod
: Version = 1.0
: Desc = Mod file for implementing EC K+ accumulation in MRG model in the extranodal space
: Modified from code by Hines, M.L. and Carnevale, N.T. Expanding NEURON's repertoire of mechanisms with NMODL. Neural Computation 12:995-1007, 2000.



NEURON {
  SUFFIX KIntNodeND      :Suffix tells Neuron that this is a Density Mechanism, with Suffix KExtNode
  USEION k READ ik WRITE ki   :This mod file uses the K ion, reads the sum of all ik in the segment and writes ki ([K]ic) based on this ik and a diffusion mechanism)
  RANGE NSh_vol, N_SA
}

UNITS {    :Unit declaration/definition
  (mV)    = (millivolt)
  (mA)    = (milliamp)
  FARADAY = (faraday) (coulombs)
  (molar) = (1/liter)
  (mM)    = (millimolar)
  (um)	  = (micron)
}

PARAMETER {    :Parameters = constants
  NSh_vol = 9.6624 (um3) : volume in microns cubed of nodal shell (9.6624 is total, 0.7025 is just surrounding small donut)
  N_SA = 1.7931 (um2) : surface area of node
  ki0     =  125 (mM)  : initial internal concentration
}
ASSIGNED { ik  (mA/cm2) }   :Assigned statements are algebraic statements. h

STATE { 
  ki  (mM) :ki is a state variable, i.e. one that is updated from solving a DE (below)
}    

INITIAL {
  ki = ki0
}

BREAKPOINT { SOLVE state METHOD cnexp }   :Breakpoint commands are executed at the beginning of each model step iteration (before Neuron ODEs are iterated), solved using Crank-Nicholson method

DERIVATIVE state {
  ki' = -(1e4)*(ik*N_SA)/(FARADAY*NSh_vol)
}   