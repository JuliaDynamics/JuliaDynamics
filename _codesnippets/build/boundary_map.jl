using DynamicalBilliards, PyPlot

rc = MushroomTools.randomchaotic
rr = MushroomTools.randomregular
bd = billiard_mushroom(1.0, 0.5, 1.0)

n = 500 # how many particles to evolve
ps = [rc(1.0, 0.5, 1.0) for _ in 1:n÷2]
append!(ps, [rr(1.0, 0.5, 1.0) for _ in 1:n÷2])
bmap, arcs = parallelize(boundarymap, bd, 1000, ps)

colors = [i > n÷2 ? "C2" : "k" for i in 1:n]

plot_boundarymap(bmap, arcs, color = colors, alpha = 0.1)
