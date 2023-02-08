[mesh]
  type=gmsh
  file=tensilesample.msh
[end]


[dofs]
name=d ux uy
[end]

[elmts]
  [myfracture]
    type=miehefrac
    dofs=d ux uy
    mate=myfracmate
  [end]
[end]

[mates]
  [myfracmate]
    type=miehefracmate
    params=121.15 80.77 2.7e-3 0.015 1.0e-6
    //     lambda mu    Gc     L     viscosity
  [end]
[end]

[nonlinearsolver]
  type=nr
  maxiters=80
  r_rel_tol=1.0e-9
  r_abs_tol=1.5e-7
  solver=superlu
[end]

[ics]
  [constd]
    type=const
    dof=d
    params=0.0
  [end]
[end]

[output]
  type=vtu
  interval=20
[end]

[timestepping]
  type=be
  dt=1.0e-5
  time=6.0e-3
  adaptive=true
  optiters=3
  growthfactor=1.1
  cutfactor=0.85
  dtmin=1.0e-12
  dtmax=1.0e-4
[end]

[projection]
name=reacforce_x reacforce_y
scalarmate=vonMises
rank2mate=stress strain
[end]

[postprocess]
  [area]
    type=area
    side=top
  [end]
  [fx]
    type=projvariablesideintegral
    projvariable=reacforce_x
    side=top
  [end]
  [fy]
    type=projvariablesideintegral
    projvariable=reacforce_y
    side=top
  [end]
  [ux]
    type=sideintegral
    dof=ux
    side=top
  [end]
  [sigma_xx]
    type=rank2matesideintegral
    rank2mate=stress
    iindex=1
    jindex=1
    side=top
  [end]
  [sigma_xy]
    type=rank2matesideintegral
    rank2mate=stress
    iindex=1
    jindex=2
    side=top
  [end]
  [sigma_yy]
    type=rank2matesideintegral
    rank2mate=stress
    iindex=2
    jindex=2
    side=top
  [end]
  [strain_xx]
    type=rank2matesideintegral
    rank2mate=strain
    iindex=1
    jindex=1
    side=top
  [end]
  [strain_xy]
    type=rank2matesideintegral
    rank2mate=strain
    iindex=1
    jindex=2
    side=top
  [end]
  [strain_yy]
    type=rank2matesideintegral
    rank2mate=strain
    iindex=2
    jindex=2
    side=top
  [end]
[end]

[bcs]
  [fixux]
    type=dirichlet
    dofs=ux
    value=0.0
    boundary=left right top bottom
  [end]
  [fixuy]
    type=dirichlet
    dofs=uy
    value=0.0
    boundary=bottom
  [end]
  [load]
    type=dirichlet
    dofs=uy
    value=1.0*t
    boundary=top
  [end]
[end]

[job]
  type=transient
  debug=dep
[end]
