#
# This test validates the helper materials that generate material properties for
# the h(eta) switching function and the g(eta) double well function
#

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 40
  ny = 5
  nz = 0
  xmin = 0
  xmax = 1
  ymin = 0
  ymax = 1
  zmin = 0
  zmax = 0
  elem_type = QUAD4
[]

[BCs]
  [./left1]
    type = DirichletBC
    variable = eta1
    boundary = 'left'
    value = 0
  [../]
  [./right1]
    type = DirichletBC
    variable = eta1
    boundary = 'right'
    value = 1
  [../]

  [./left2]
    type = DirichletBC
    variable = eta2
    boundary = 'left'
    value = 0
  [../]
  [./right2]
    type = DirichletBC
    variable = eta2
    boundary = 'right'
    value = 1
  [../]
[]

[Variables]
  # order parameter 1
  [./eta1]
    order = FIRST
    family = LAGRANGE
  [../]

  # order parameter 2
  [./eta2]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Materials]
  [./h_eta1]
    type = SwitchingFunctionMaterial
    block = 0
    h_order = SIMPLE
    eta = eta1
    outputs = exodus
  [../]

  [./h_eta2]
    type = SwitchingFunctionMaterial
    block = 0
    h_order = HIGH
    eta = eta2
    outputs = exodus
  [../]

  [./g_eta1]
    type = BarrierFunctionMaterial
    block = 0
    g_order = SIMPLE
    eta = eta1
    outputs = exodus
  [../]

  [./g_eta2]
    type = BarrierFunctionMaterial
    block = 0
    g_order = LOW
    eta = eta2
    outputs = exodus
  [../]
[]

[Kernels]
  [./eta1diff]
    type = Diffusion
    variable = eta1
  [../]

  [./eta2diff]
    type = Diffusion
    variable = eta2
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'PJFNK'
[]

[Outputs]
  output_initial = false
  interval = 1
  exodus = true
  print_linear_residuals = true
  print_perf_log = true
[]

