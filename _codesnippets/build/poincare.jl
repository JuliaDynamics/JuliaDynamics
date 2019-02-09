using DynamicalSystems, PyPlot, OrdinaryDiffEq

hh = Systems.henonheiles()

plane = (1, 0.0)
u0s = [[0.0, -0.25, 0.42081, 0.0],
[0.0, -0.31596, 0.354461, 0.0591255],
[0.0, 0.1, 0.5, 0.0],
[0.0, -0.0910355, 0.459522, -0.173339],
[0.0, -0.205144, 0.449328, -0.0162098]]

for u0 in u0s
    psos = poincaresos(hh, plane, 20000.0; alg = Vern9(), u0 = u0)
    scatter(psos[:, 2], psos[:, 4], s = 2.0)
end
