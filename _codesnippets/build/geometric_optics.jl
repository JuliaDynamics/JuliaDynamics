using DynamicalBilliards, PyPlot

# Create a circular "lens"
o = Antidot(SVector(1.0, 0.75), 0.5)
bd = Billiard(billiard_rectangle(2.5, 1.5)..., o)

trans, refra = law_of_refraction(1.5)
rs = (RaySplitter([5], trans, refra),)

ps = [Particle(0.1, y, 0.0) for y in 0.4:0.05:1.1]; N = length(ps)
cs = [0.5 .* (0, i/N, 1 - i/N, 0.9) for i in eachindex(ps)]

animate_evolution(ps, bd, 2.0, rs, tailtime=2.5, colors = cs)
