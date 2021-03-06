/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#include "AddSlaveFluxVectorAction.h"
#include "Parser.h"
#include "FEProblem.h"

template<>
InputParameters validParams<AddSlaveFluxVectorAction>()
{
  return validParams<Action>();
}

AddSlaveFluxVectorAction::AddSlaveFluxVectorAction(const std::string & name, InputParameters params) :
    Action(name, params)
{
}

void
AddSlaveFluxVectorAction::act()
{
  _problem->getNonlinearSystem().addVector("slave_flux", false, GHOSTED, true);
}
