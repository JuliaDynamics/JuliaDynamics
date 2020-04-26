using InteractiveChaos, Makie, DynamicalSystems

i = 1
p_index = 1

ds, p_min, p_max, parname = Systems.henon(), 0.8, 1.4, "a"
t = "orbit diagram for the Hénon map"

interactive_orbitdiagram(ds, p_index, p_min, p_max;
                         parname = parname, title = t)
