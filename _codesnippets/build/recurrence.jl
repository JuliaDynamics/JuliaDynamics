using DynamicalSystems, PyPlot

ds = Systems.roessler()

for (i, c) in enumerate([4.0, 5.7])
    set_parameter!(ds, 3, c)
    tr = trajectory(ds, 200.0; dt = 0.1, Ttr = 200.0)

    R = RecurrenceMatrix(tr, 3.0)

    subplot(1,2,i)
    imshow(grayscale(R; width = 1000, height = 1000), cmap = "binary_r")
end
