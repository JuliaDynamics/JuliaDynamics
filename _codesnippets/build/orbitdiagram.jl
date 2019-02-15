using InteractiveChaos, Makie

i = 1
p_index = 1

ds, p_min, p_max, parname = Systems.logistic(), 3.0, 4.0, "r"

oddata = interactive_orbitdiagram(
             ds, i, p_index, p_min, p_max;
             parname = parname
         )
