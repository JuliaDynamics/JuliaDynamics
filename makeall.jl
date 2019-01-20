dir_source = "QuantumOptics.jl"
dir_examples = "QuantumOptics.jl-examples"
dir_benchmarks = "QuantumOptics.jl-benchmarks"
dir_documentation = "QuantumOptics.jl-documentation"
dir_website = "QuantumOptics.jl-website"

println("========================================")
println("Updating all git repositories")
println("Updating QuantumOptics.jl")
cd("../$dir_source")
run(`git pull`)
println("Updating examples")
cd("../$dir_examples")
run(`git pull`)
println("Updating benchmarks")
cd("../$dir_benchmarks")
run(`git pull`)
println("Updating documentation")
cd("../$dir_documentation")
run(`git pull`)

println("========================================")
println("Building examples")
cd("../$dir_examples")
run(`julia make.jl`)

println("========================================")
println("Building documentation")
cd("../$dir_documentation")
run(`julia make.jl`)

println("========================================")
println("Building benchmarks")
cd("../$dir_benchmarks")
run(`julia make.jl`)

println("========================================")
println("Building code-snippets")
cd("../$dir_website/src/_codesnippets")
run(`julia make.jl`)
