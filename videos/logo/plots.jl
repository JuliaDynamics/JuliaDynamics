using DynamicalSystems, DynamicalBilliards, PyPlot
cd(@__DIR__)

PyPlot.ioff()
fs = (28, 24)

# %% Panel trajectory
lorenz = Systems.lorenz()
tr = trajectory(lorenz, 100.0, dt = 0.001)

figure(figsize = fs)
plot(tr[:, 1], tr[:, 3], lw = 4.0, color = "white")
axis("off")
savefig("lorenz.png", transparent = true)

# %% Panel orbitdiagram
logistic = Systems.logistic()
i = 1
pvalues = range(3.0, 5, length = 2000)
ics = [rand() for m in 1:10]
n = 2500
Ttr = 2000
p_index = 1
output = orbitdiagram(logistic, i, p_index, pvalues; n = n, Ttr = Ttr)

L = length(pvalues)
x = Vector{Float64}(undef, n*L)
y = copy(x)
for j in 1:L
    x[(1 + (j-1)*n):j*n] .= pvalues[j]
    y[(1 + (j-1)*n):j*n] .= output[j]
end

figure(figsize = fs)
plot(y, -x, ls = "None", ms = 2.0, color = "white", marker = "o", alpha = 0.08)
axis("off")
savefig("od.png", transparent = true)

# %% Henon heiles poincare

hh = Systems.henonheiles()

# Grid of initial conditions at given energy:

energy(x,y,px,py) = 0.5(px^2 + py^2) + potential(x,y)
potential(x, y) = 0.5(x^2 + y^2) + (x^2*y - (y^3)/3)
function generate_ics(E, n)
    ys = range(-0.4, stop = 1.0, length = n)
    pys = range(-0.5, stop = 0.5, length = n)
    ics = Vector{Vector{Float64}}()
    for y in ys
        V = potential(0.0, y)
        V ≥ E && continue
        for py in pys
            Ky = 0.5*(py^2)
            Ky + V ≥ E && continue
            px = sqrt(2(E - V - Ky))
            ic = [0.0, y, px, py]
            push!(ics, [0.0, y, px, py])
        end
    end
    return ics
end

E = energy(hh.u0...)
E = 0.13

figure(figsize = fs)
N = 25 # grid density
ics = generate_ics(E, N)
for u in ics
    # compute section:
    psos = poincaresos(hh, (1, 0.0), 4000.0; u0 = u)
    x = psos[:, 2]; y = psos[:, 4]
    plot(x, y, ls = "None", ms = 2.0, color = "white", marker = "o")
end

axis("off")
savefig("psos.png", transparent = true)


# %%

using DynamicalBilliards, PyPlot

bd = billiard_stadium()
N = 500
# cs = [(i/N, 0, 1 - i/N, 0.5) for i in 1:N]
cs = (1, 1, 1, 0.1)
ps = [Particle(1, 0.6 + i, 0) for i in range(0, 0.01, length=N)]
tailtime = 5.77
endtime = 6.5
figure(figsize = fs)

# plot billiard in white thick lines
c = "white"
lw = 8
for o in (bd[1], bd[3])
    plot(o, lw = lw, color = c)
end
for d in (bd[2], bd[4])
    theta1 = atan(d.facedir[2], d.facedir[1])*180/π + 90
    theta2 = theta1 + 180
    s1 = PyPlot.matplotlib[:patches][:Arc](d.c, 2d.r, 2d.r, theta1 = theta1, theta2 = theta2, edgecolor = c,
    lw = lw)
    PyPlot.gca()[:add_artist](s1)
end

# plot(bd)
for (n, p) in enumerate(ps)
    x, y, vx, vy, t = timeseries(p, bd, endtime+1, dt = 0.001)
    i = findfirst(x -> x ≥ endtime-tailtime, t)
    j = findfirst(x -> x ≥ endtime, t)
    plot(x[i:j], y[i:j], color = cs)
end
axis("off")
xlim(-0.51, 1.51)
savefig("billiard.png", transparent = true)
# animate_evolution(ps, bd, 4.5; colors = cs, tailtime = 3.5)

# %% Towel

ds = Systems.towel()

tr = trajectory(ds, 2000000)

α = 0.02
ysim = -0.007
y = tr[:, 2] .- ysim
x = tr[:, 1]

figure(figsize = fs)
scatter(x, y, color = "white", s = 4.0, alpha = α)
scatter(x, -0.4y, color = "white", s = 4.0, alpha = α)
axis("off")
savefig("towel.png", transparent = true)

# %%
close("all")
PyPlot.ion()
