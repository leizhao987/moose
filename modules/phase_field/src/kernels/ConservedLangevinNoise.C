#include "ConservedLangevinNoise.h"

template<>
InputParameters validParams<ConservedLangevinNoise>()
{
  InputParameters params = validParams<LangevinNoise>();
  params.addRequiredParam<UserObjectName>("noise", "ConservativeNoise userobject that produces the random numbers");
  return params;
}
ConservedLangevinNoise::ConservedLangevinNoise(const std::string & name,
                             InputParameters parameters) :
    LangevinNoise(name, parameters),
    _noise(getUserObject<ConservedNoiseInterface>("noise"))
{
}

Real
ConservedLangevinNoise::computeQpResidual()
{
  return -_test[_i][_qp] * _noise.getQpValue(_current_elem->id(), _qp) * _amplitude * (_multiplier_prop == NULL ? 1.0 : (*_multiplier_prop)[_qp]);
}
