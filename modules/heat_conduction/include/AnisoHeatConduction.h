/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef ANISOHEATCONDUCTION_H
#define ANISOHEATCONDUCTION_H

#include "Kernel.h"

class AnisoHeatConduction : public Kernel
{
public:

  AnisoHeatConduction(const std::string & name, InputParameters parameters);

protected:
  virtual Real computeQpResidual();

  virtual Real computeQpJacobian();

private:
  const unsigned _dim;

  MaterialProperty<Real> * _k_i[3];
  MaterialProperty<Real> * _k_i_dT[3];
};

template<>
InputParameters validParams<AnisoHeatConduction>();

#endif //ANISOHEATCONDUCTION_H
