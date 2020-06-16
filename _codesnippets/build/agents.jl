using Agents, AgentsPlots
pyplot()

model, agent_step!, model_step! = Models.flocking()

function bird_shape(b)
    φ = atan(b.vel[2], b.vel[1])
    xs = [(i ∈ (0, 3) ? 2 : 1) * cos(i * 2π / 3 + φ) for i in 0:3]
    ys = [(i ∈ (0, 3) ? 2 : 1) * sin(i * 2π / 3 + φ) for i in 0:3]
    Shape(xs, ys)
end
bird_color(a) = RGB(0.5, 0, mod1(a.id, 20)/20)

anim = @animate for i in 1:200
    p1 = plotabm(model;
    ac = bird_color, am = bird_shape, as = 10, msw = 0,
    xlims = (0, 100), ylims = (0, 100))
    step!(model, agent_step!, model_step!, 1)
end
mp4(anim, "flocking.mp4", fps = 25)
