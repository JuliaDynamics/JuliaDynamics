## In order to better control method-functionality in the tests and to disjunct
# DynamicalSystems subpackages from DynamicalSystemsBase.jl (for compilation and
# updating reasons) we here create time series, which we will save and run the
# corresponding tests on

using DynamicalSystemsBase
using DelimitedFiles

## Lorenz System
u0 = [0, 10.0, 0.0]
lo = Systems.lorenz(u0; σ=10, ρ=28, β=8/3)
tr = trajectory(lo, 100; Δt = 0.01, Ttr = 100)

# writedlm("test_time_series_lorenz_standard_N_10000_x.csv", tr[:,1])
# writedlm("test_time_series_lorenz_standard_N_10000_y.csv", tr[:,2])
# writedlm("test_time_series_lorenz_standard_N_10000_z.csv", tr[:,3])
writedlm("test_time_series_lorenz_standard_N_10000_multivariate.csv", tr)


## Roessler system
u0 = [1.0, 1.0, 1.0]
ro = Systems.roessler(u0; a=0.15, b = 0.2, c=10)
tr = trajectory(ro, 1250; Δt = 0.125, Ttr = 100)

# writedlm("test_time_series_roessler_N_10000_x.csv", tr[:,1])
# writedlm("test_time_series_roessler_N_10000_y.csv", tr[:,2])
# writedlm("test_time_series_roessler_N_10000_z.csv", tr[:,3])
writedlm("test_time_series_roessler_N_10000_multivariate.csv", tr)
