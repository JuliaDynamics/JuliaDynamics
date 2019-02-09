using DynamicalSystems, PyPlot

ds = Systems.roessler()
tr = trajectory(ds, 1000.0; dt = 0.05)

τ = estimate_delay(tr[:, 1], "mi_min") # first minimum of mutual information

figure(figsize = (10, 6)); subplot(1,2,1)
for method in ["afnn", "fnn", "f1nn"]
    Ds = estimate_dimension(tr[:, 1], τ, 1:6, method)
    plot(1:6, Ds ./ maximum(Ds), label = method, marker = "o")
end
legend(); xlabel("\$\\gamma\$ (temporal neighbors)")

subplot(1,2,2, projection = "3d")
rec = embed(tr[:, 1], 4, τ)
plot3D(rec[1:2000, 1],rec[1:2000, 2],rec[1:2000, 3])
