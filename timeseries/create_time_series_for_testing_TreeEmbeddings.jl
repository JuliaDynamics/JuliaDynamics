## In order to better control method-functionality in the tests and to disjunct
# DynamicalSystems subpackages from DynamicalSystemsBase.jl (for compilation and
# updating reasons) we here create time series, which we will save and run the
# corresponding tests on

using Random
using DynamicalSystemsBase
using DelimitedFiles

# Lorenz System
Random.seed!(1234)
ds = Systems.lorenz()
data = trajectory(ds,200)
data = data[2001:2:3750,:]

writedlm("test_time_series_Lorenz_N_875_multivariate.csv", data)
