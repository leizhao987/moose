/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#ifndef DARCYCONVECTION_H
#define DARCYCONVECTION_H

#include "Kernel.h"

// Forward Declaration
class DarcyConvection;

template<>
InputParameters validParams<DarcyConvection>();

/**
 * Simple class to demonstrate off diagonal Jacobian contributions.
 */
class DarcyConvection : public Kernel
{
public:
  DarcyConvection(const std::string & name, InputParameters parameters);

protected:
  virtual Real computeQpResidual();

  virtual Real computeQpJacobian();

  virtual Real computeQpOffDiagJacobian(unsigned int jvar);

  /// The gradient of pressure
  VariableGradient & _pressure_gradient;

  /// Coupling identifier for the pressure.  This is used to uniquely identify a coupled variable
  unsigned int _pressure_var;

  /**
   * These references will be set by the initialization list so that
   * values can be pulled from the Material system.
   */
  MaterialProperty<Real> & _permeability;
  MaterialProperty<Real> & _porosity;
  MaterialProperty<Real> & _viscosity;
  MaterialProperty<Real> & _density;
  MaterialProperty<Real> & _specific_heat;
};

#endif //DARCYCONVECTION_H
