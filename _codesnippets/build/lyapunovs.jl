using DynamicalSystems, PyPlot

function roessler(u, p, t)
    a, b, c = p
    du1 = -u[2]-u[3]
    du2 = u[1] + a*u[2]
    du3 = b + u[3]*(u[1] - c)
    return SVector{3}(du1, du2, du3)
end
ds = ContinuousDynamicalSystem(roessler, [0, 1.0, 0], [0.2, 0.2, 5.7])

cs = 4:0.01:6; λs = zeros(length(cs), 3)
for (i, c) in enumerate(cs)
    set_parameter!(ds, 3, c)
    λs[i, :] .= lyapunovs(ds, 10000; Ttr = 500.0)
end

plot(cs, λs)
