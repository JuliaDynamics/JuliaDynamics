using Agents, AgentsPlots
pyplot()

model, agent_step!, model_step! =
Models.social_distancing(isolated = 0.8, infection_period = 360)

sir_colors(a) = a.status == :S ? "#2b2b33" :
    a.status == :I ? "#bf2642" : "#338c54"
sir_shapes(a) = a.status == :S ? :circle :
    a.status == :I ? :diamond : :square

anim = @animate for i in 1:250
    p1 = plotabm(model;
        ac = sir_colors, am = sir_shapes, as = 4, msw = 0,
        xlims = (0, 1), ylims = (0, 1))
    step!(model, agent_step!, model_step!, 3)
end
mp4(anim, "socialdist.mp4", fps = 25)
