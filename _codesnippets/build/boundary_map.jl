using DynamicalBilliards, PyPlot

bd = billiard_mushroom(1.0, 0.5, 1.0)

n = 500 # how many particles to evolve
ps = [MushroomTools.randomchaotic(1.0, 0.5, 1.0) for _ in 1:n÷2]
append!(ps, [MushroomTools.randomregular(1.0, 0.5, 1.0) for _ in 1:n÷2])
bmap, arcs = parallelize(boundarymap, bd, 1000, ps)

colors = [i > n÷2 ? "C2" : "k" for i in 1:n]

plot_boundarymap(bmap, arcs, color = colors, alpha = 0.1)
