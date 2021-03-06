/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#include "CHMath.h"

template<>
InputParameters validParams<CHMath>()
{
  InputParameters params = validParams<CHBulk>();

  return params;
}

CHMath::CHMath(const std::string & name, InputParameters parameters) :
    CHBulk(name, parameters)
{
}

RealGradient  //Use This an example of the the function should look like
CHMath::computeGradDFDCons(PFFunctionType type)
{
  switch (type)
  {
    case Residual:
      return 3*_u[_qp]*_u[_qp]*_grad_u[_qp] - _grad_u[_qp]; // return Residual value

    case Jacobian:
      return 6*_u[_qp]*_phi[_j][_qp]*_grad_u[_qp] + 3*_u[_qp]*_u[_qp]*_grad_phi[_j][_qp] - _grad_phi[_j][_qp]; //return Jacobian value
  }

  mooseError("Invalid type passed in");
}
