using DynamicalBilliards, PyPlot

bd = billiard_hexagonal_sinai(0.4, 1.0; setting = "periodic")

p = MagneticParticle(0.5, 0.6, π/2, 0.75)

xt, yt = timeseries(p, bd, 15)

plot(bd, xt, yt; hexagonal = true)
