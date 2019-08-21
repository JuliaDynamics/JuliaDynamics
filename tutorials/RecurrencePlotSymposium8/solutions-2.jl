# Exercise 2
struct Range{T}
    start::T
    step::T
    stop::T
end

function Base.getindex(a::Range, i::Int)
    tmp = a.start + a.step*(i-1)
    if tmp > a.stop
        error("Index is out of bounds!")
    else
        return tmp
    end
end

a = Range(1,2,20)
a[5]


# Exercise 3
function Base.iterate(a::Range, i = 1)
    tmp = a.start + a.step*(i-1)
    if tmp > a.stop
        return nothing
    else
        return tmp, i+1
    end
end

for x in a
    println(x)
end

using Unitful
a = Range(1u"kg",2u"kg",20u"kg")
a[5]


# Exercise 4
import Base: show, +, -, *, /

struct RationalNumber
    n::Int     # numerator
    d::Int     # denominator
    function RationalNumber(n::Integer, d::Integer)
        if d == 0 || n == 0
            error("Invalid rational number: $(n)//$(d)")
        end
        _n, _d = _normalize(n, d)
        new(_n, _d)
    end
end
function _normalize(n::T, d::T) where {T<:Integer}
    g = gcd(n, d)
    m = d < 0 ? -1 : 1
    (m * n ÷ g, m * d ÷ g)
end

# Convenience functions
num(a::RationalNumber) = a.n
den(a::RationalNumber) = a.d
RationalNumber(a::Integer) = RationalNumber(a, 1)

# addition
function +(a::RationalNumber, b::RationalNumber)
    n = num(a) * den(b) + den(a) * num(b)
    d = den(a) * den(b)
    RationalNumber(n, d)
end
+(a::Integer, b::RationalNumber) = RationalNumber(a) + b
+(a::RationalNumber, b::Integer) = a + RationalNumber(b)

# negation
function -(r::RationalNumber)
    RationalNumber(-num(r), den(r))
end

# subtraction
-(a::RationalNumber, b::RationalNumber) = a + -b
-(a::Integer, b::RationalNumber) = RationalNumber(a) + b
-(a::RationalNumber, b::Integer) = a + RationalNumber(b)

# multiplication
function *(a::RationalNumber, b::RationalNumber)
    RationalNumber(num(a) * num(b), den(a) * den(b))
end
*(a::Integer, b::RationalNumber) = RationalNumber(a) * b
*(a::RationalNumber, b::Integer) = a * RationalNumber(b)

# division
function /(a::RationalNumber, b::RationalNumber)
    RationalNumber(num(a) * den(b), den(a) * num(b))
end
/(a::Integer, b::RationalNumber) = RationalNumber(a) / b
/(a::RationalNumber, b::Integer) = a / RationalNumber(b)

# pretty printing
function show(io::IO, r::RationalNumber)
    print(io, "$(r.n)//$(r.d)")
end
