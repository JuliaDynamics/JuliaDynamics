using DynamicalBilliards, PyPlot

bd = billiard_stadium()
N = 20
cs = [(i/N, 0, 1 - i/N, 0.5) for i in 1:N]
ps = [Particle(1, 0.6 + 0.0005*i, 0) for i in 1:N]

animate_evolution(ps, bd, 7.0; colors = cs, tailtime = 1.5)
