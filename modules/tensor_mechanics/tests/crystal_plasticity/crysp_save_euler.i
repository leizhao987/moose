[Mesh]
  type = GeneratedMesh
  dim = 2
  elem_type = QUAD4
  displacements = 'disp_x disp_y'
  nx = 2
  ny = 2
[]

[Variables]
  [./disp_x]
    block = 0
  [../]
  [./disp_y]
    block = 0
  [../]
[]

[AuxVariables]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./e_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./fp_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./rotout]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./gss1]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./euler1]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./euler2]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./euler3]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = 0.01*t
  [../]
[]

[UserObjects]
  [./prop_read]
    type = ElementPropertyReadFile
    prop_file_name = 'euler_ang_file.txt'
    # Enter file data as prop#1, prop#2, .., prop#nprop
    nprop = 3
    read_type = element
  [../]
[]

[AuxKernels]
  [./stress_yy]
    type = RankTwoAux
    variable = stress_yy
    rank_two_tensor = stress
    index_j = 1
    index_i = 1
    execute_on = timestep_end
    block = 0
  [../]
  [./e_yy]
    type = RankTwoAux
    variable = e_yy
    rank_two_tensor = lage
    index_j = 1
    index_i = 1
    execute_on = timestep_end
    block = 0
  [../]
  [./fp_yy]
    type = RankTwoAux
    variable = fp_yy
    rank_two_tensor = fp
    index_j = 1
    index_i = 1
    execute_on = timestep_end
    block = 0
  [../]
  [./rotout]
    type = CrystalPlasticityRotationOutAux
    variable = rotout
    execute_on = timestep_end
    block = 0
  [../]
  [./gss1]
    type = CrystalPlasticitySlipSysAux
    variable = gss1
    slipsysvar = gss
    index_i = 1
    execute_on = timestep_end
    block = 0
  [../]
  [./euler1]
    type = MaterialStdVectorAux
    variable = euler1
    property = euler_ang
    index = 0
    execute_on = timestep_end
    block = 0
  [../]
  [./euler2]
    type = MaterialStdVectorAux
    variable = euler2
    property = euler_ang
    index = 1
    execute_on = timestep_end
    block = 0
  [../]
  [./euler3]
    type = MaterialStdVectorAux
    variable = euler3
    property = euler_ang
    index = 2
    execute_on = timestep_end
    block = 0
  [../]
[]

[BCs]
  [./fix_x]
    type = PresetBC
    variable = disp_x
    boundary = 'left'
    value = 0
  [../]
  [./fix_y]
    type = PresetBC
    variable = disp_y
    boundary = 'bottom'
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = disp_y
    boundary = top
    function = tdisp
  [../]
[]

[Materials]
  active = 'crysp'
  [./crysp]
    type = FiniteStrainCrystalPlasticity
    block = 0
    disp_y = disp_y
    disp_x = disp_x
    gtol = 1e-2
    slip_sys_file_name = input_slip_sys.txt
    C_ijkl = '1.684e5 1.214e5 1.214e5 1.684e5 1.214e5 1.684e5 0.754e5 0.754e5 0.754e5'
    nss = 12
    num_slip_sys_flowrate_props = 2 #Number of properties in a slip system
    flowprops = '1 4 0.001 0.1 5 8 0.001 0.1 9 12 0.001 0.1'
    hprops = '1.0 541.5 60.8 109.8 2.5'
    gprops = '1 4 60.8 5 8 60.8 9 12 60.8'
    fill_method = symmetric9
    tan_mod_type = exact
    read_prop_user_object = prop_read
    save_euler_angle = true
  [../]
[]

[Postprocessors]
  [./stress_yy]
    type = ElementAverageValue
    variable = stress_yy
    block = 'ANY_BLOCK_ID 0'
  [../]
  [./e_yy]
    type = ElementAverageValue
    variable = e_yy
    block = 'ANY_BLOCK_ID 0'
  [../]
  [./fp_yy]
    type = ElementAverageValue
    variable = fp_yy
    block = 'ANY_BLOCK_ID 0'
  [../]
  [./gss1]
    type = ElementAverageValue
    variable = gss1
    block = 'ANY_BLOCK_ID 0'
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  dt = 0.01

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'

  petsc_options_iname = -pc_hypre_type
  petsc_options_value = boomerang
  nl_abs_tol = 1e-10
  nl_rel_step_tol = 1e-10
  dtmax = 10.0
  nl_rel_tol = 1e-10
  ss_check_tol = 1e-10
  end_time = 1
  dtmin = 0.01
  num_steps = 10
  nl_abs_step_tol = 1e-10

[]

[Outputs]
  file_base = crysp_save_euler_out
  output_initial = true
  exodus = true
  print_linear_residuals = true
  print_perf_log = true
[]

[Kernels]
  [./TensorMechanics]
    disp_y = disp_y
    disp_x = disp_x
    use_displaced_mesh = true
  [../]
[]

[Problem]
  use_legacy_uo_initialization = false
[]



