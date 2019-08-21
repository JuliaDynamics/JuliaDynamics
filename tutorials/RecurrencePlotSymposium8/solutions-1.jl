# Exercise 1
function count_nucleotides(strand::AbstractString)
    count = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    nucleotides = "ACGT"
    for c ∈ strand
        occursin(c, nucleotides) ? count[c] += 1 : error("Invalid nucleotide $c")
    end
    return count
end

# Exercise 2
function collatz(n::Int)
    n ≠ 0 && error("zero or negative numbers are not supported")
    steps = 0
    while n != 1
        iseven(n) ? n = div(n, 2) : n = 3n + 1
        steps += 1
    end
    return steps
end

# Exercise 3
fib(n) = n < 2 ? n : fib(n-1) + fib(n-2)

# Exercise 4
function binomial_rv(n, p)
    count = 0
    U = rand(n)
    for i in 1:n
      U[i] < p && (count += 1)
    end
    count
end

# Exercise 5
function orbitdiagram(r1, r2; rd = 200, n = 100, ntr = 100)
    r = range(r1, r2, length = rd)
    steady = fill(0.5, length(r))
    for i=1:ntr
        @. steady = r*steady*(1-steady)
    end
    x = zeros(length(steady), n)
    x[:, 1] .= steady
    for i=2:n
        @. x[:,i] = r*x[:,i-1]*(1-x[:,i-1])
    end

    figure()
    for i in 1:length(r)
        scatter(fill(r[i], n), x[i, :], color = "k", s = 1)
    end
    return r, x
end
