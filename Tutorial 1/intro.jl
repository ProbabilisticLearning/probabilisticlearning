# Welcome to Julia!
# Assuming you have Julia+VSCode+Julia Extension installed, you should have a pane below called REPL
# (Read, Eval, Print, Loop) which lets you execute julia code.
# Click it and Press Enter to start Julia!
# After a bit of time you should see the Julia logo and the Julia prompt
# julia>
# If not, you will need to troubleshoot your installation

### Evaluation Basics

# Let's evaluate some code.
# There are a few ways to do this:
# 1. You could do this by typing or copying and pasting into the REPL pane
# 2. You can also do this by evaluating the entire file from command-line
# if you added julia to your $PATH then `julia path/to/file.jl` will run
# all the code in the file. However, unlike python workflow, this is not the
# reccomended way to develop Julia code quickly.
# 3. Execute code from editor with CTRL+ENTER
print("hello CSC412!")

# We can evaluate some math
4+1+2

# If we want to supress the output in the editor we can use ;
4+1+2;

# And if we do want to have the evaluation output (e.g. for an assignment)
print(4+1+2)
# or the @show macro will also include what's evaluated and no parenthesis
@show 4+1+2;


### Arrays

# Create a 1D column vector:
x_col = [4,1,4] # or [4; 1; 4]
@show size(x_col)

# Create a row vector:
x_row = [4 1 4]
@show size(x_row)

# Transpose with the ' syntax
x_t = x_row'
@show size(x_t)
# The difference between x_col (3) and x_t (3,1) is subtle!

# A k-spaced vector of ponts from j to n
# This is very useful for plotting!
x_lin = 1:0.5:10
# hm, that didn't give me an array...
typeof(x_lin)
# this is a lazy array constructor that should act like an array in most cases!
# however, you can always make it an explicit array
collect(x_lin)

# Matrices can be constructed explicitly
# Spaces for columns and ; for rows
A = [1 2; 3 4]

# More often we'll want to create matrices (and vectors)
# with special elements. This is convenient:
zeros(200,300)
ones(4,3)

# Random Arrays
# sampled from uniform [0,1]
rand(2,2)
# sampled from unit Normal
randn(2,2)

# Other structured matrices can be found in the LinearAlgebra.jl package
# which is included in the standard library of Julia.
# So we can use it by
using LinearAlgebra

# It has the Identity Matrix
I
# Notice that it has no dimension, will assume the dimensions of its neighbours
I*A == A

# Diagonal Matrices can be specified by their diagonal vector entries
# These are stored efficiently in memory, and can use faster algorithms
Diagonal([4,1,4])

# Common operations on Arrays

# We saw transpose (actually this is complex conjugate transpose)
A'

# Concatenate horizontally
a = [1, 2]
hcat(a,a)
# or
[a a]

# Concatenate vertically
vcat(a,a)
# or
[a; a]

# Reshape the array
B = 1:10
B_re = reshape(B,2,5)
# again, lazy, but we can always collect
B_re |> collect
# x |> f is a fancy syntax for f(x), you'll see it sometimes

# Indexing into Arrays
# Arrays are represented in memory as a single vector, which you can acess like
A[:]
# ith row use A[i,:]
A[1,:]
# jth column use A[:,j]
A[:,1]
# So the i,jth element A[i,j]
A[2,1]
# other ways to access arrays like, ranges of specific columns
B_re[1, 2:4]
# Note! Unlike Python, Julia is 1-based index
# So the first element is [1] and the last element is length of the dimension
[1,2,3][1]
[1,2,3][3]
[1,2,3][end]
[1,2,3][-1]
[1,2,3][2:-1:1]

# Functions on Arrays
# Another important convention in Julia is that elementwise functions
# won't automatically apply elementwise
sin(x_col)
# this would work in Python, so it's a big gotcha!
# To apply elementwise, you must use broadcast
broadcast(sin,x_col)
# this has a very nice sytnax, .
sin.(x_col)

# Often you'll want to apply functions along columns, rows, or higher dimensions
# Some functions will have this built-in
sum(A,dims=1)
sum(A,dims=2)
# You can do this with broadcasting and general functions too!
# lazy iterator that gives each row of A
eachrow(A)
sum.(eachrow(A))
sum.(eachcol(A))
# Notice that this resulted in different dimensions than sum with dims
eachslice(A,dims=1) # for more than just 2D matrices

# Assessing your code performance is easy in Julia
# for instance, should we broadcast sum over eachrow or sum with dims keword?
# We can use the BenchmarkTools.@btime macro to find out!
# Let's start using Plots
using BenchmarkTools
# uh oh... we don't have that package installed!


### Package manager

# We can access the package manager by typing ] into the REPL
# From here we can ] add PackageName to get the package.
# However! let's do even better.
# To share code, like the starter code, it is very helpful  to know
# exactly what packages and verisons everyone is using
# (including old versions of your own code!)
# Inside the project directory type
#] activate .
# This will create a new environment, you should see
# (intro-tutorial) pkg>
# This is the package prompt for our new environment
# You can see what packages are installed by
# pkg> status
# Now let's add packages!
# ] add BenchmarkTools
using BenchmarkTools

A_big = randn(1000,1000)
@btime sum.(eachrow(A_big));
@btime sum(A_big,dims=2);
# For performance sensitive code this can be helpful to make sure things are fast!
# but knowing which code is worth optimizing is important.

# More array operations
x = rand(1,5)
A = rand(5,6)

# Matrix multiplication
x * A
# with useful error messages
A * x

# Elementwise-multiplication
[1 2 3] * ones(3)
[1 2 3] .* ones(3)

# Elementwise-power
[1 2 3].^2
[1 2 3]^2 # gives error!

# Dot product (from LinearAlgebra.jl)
dot(x,x)
# or \cdot ⋅
x ⋅ x  

# Determinants of square matrices
det(rand(5,5))
# Euclidian Norm
norm(rand(5,5))

### Functions

# there are a few ways to define functions
# in a block, this is most common
function f1(x)
    return println("I am $x from block")
end

# inline, very nice for quick math!
# kinda confusing vs variable assignment
f2(x) = println("I am $x from inline")

# anonymous, very nice for temporary functions
f3 = x -> println("I am $x from anonymous")

# also you saw some string interpolation
println("do this computation $(1+1)")

### Loops

# Sometimes, matrix operations are too complicated
# or not possible, so we can write loops like
for i in 0:10
    println(i)
end

# or loop over elements in an array or tuple
for i in [4,3,2,6]
    f1(i)
end

### Plotting

# We will often ask for you to produce plots in the assignment
# Both for our assessment, and so you can visualize difficult concepts

# Okay, now let's start using Plots
using Plots
# it will take some time to compile the package the first time

# There's a few ways to plot a function y = f(x)
# 1. make the ys by calling f on the xs
xs = 0:0.01:5
f(x) = sin.(x)
ys = f(xs)
# then plot
plot(xs,ys)
# look in the Plots pane of VSCode
# plots are only useful if they're readable!
plot(xs,ys,
    label = "sin",
    xlabel="x",
    ylabel="y",
    title="Awesome Trig Function")

# If we want to add new stuff to the existing plot we can use `plot!
# ! is a convention that means "mutates"
plot!(xs,cos.(xs),label="cos")

# 2. You can use the function directly
plot(xs,f)

# There are other kinds of plots too
histogram(randn(10000),normalize=true, label="unit normal")
histogram!(rand(10000),normalize=true, label="uniform")

# you can save the figure for use in latex!
savefig("my_distributions.pdf")


# Automatic Differentiation
# We can use the Zygote.jl package for reverse-mode AD
# ] add Zygote
using Zygote

# Here is a function we want the gradient of:
f(x) = x^2

# We can ask Zygote for the gradient w.r.t. x at specific values
gradient(f,0.)

# Let's make sure this is what we expect
# by writing Unit Tests
using Test

# @test looks if statements are true, and complains if they aren't
@test true
@test false

# @testset is a nice way of collecting related tests
@testset "Gradients of f = x^2" begin
    @test gradient(f,0.)[1] == 0.
    @test gradient(f,1.)[1]== 2.
    @test gradient(f,2.)[1] == 4.
end

# Note that gradient returns a tuple, one value for each argument.
# so gradient(f,1.) = (df/dx,)
# this means that we'll get the gradient we get df/dx by indexing the first element [1]

# This is useful for multivatiable functions
g(x,y) = x*y

gradient(g,3.,2.)

### Git and Github
# You will need a Github account for this course
# Once you have made changes to the project you can click the bottom right Git.
# Click the files to review changes.
# Double click to "stage" your changes.
# Write a commit message
# Create a commit

## Finding Help
# If you have questions about how to use Julia in general
# First search the very active community forum:
# https://discourse.julialang.org/
# If your question has not been answered yet, try asking there!
# This way future users can benefit from your questions
# Alternatively, you can ask on our course forum.
