# Challenge Problem Week 4
An integer array `nums` of length $N$ is sorted in ascending order (with distinct values).
Before being passed to your function, `nums` is possibly rotated at an unknown pivot index `k` where $1\leq{k}\leq{N}$ such that the resulting array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` assuming `0`-indexing. For example, the $\left[0,1,2,4,5,6,7\right]$ array might be rotated at pivot index `3`, which gives the $\left[4,5,6,7,0,1,2\right]$ array.

Given the array `nums` _after the rotation_ and an integer target, return the index of the target if it is in `nums` or `-1` if it is not in `nums.` Try to write an algorithm with $\mathcal{O}(\log\,n)$ time complexity.

### Examples
* Input: `nums = [4,5,6,7,0,1,2]`, target = `0` gives output: `4`
* Input: `nums = [4,5,6,7,0,1,2]`, target = `3` gives output: `-1`
* Input: `nums = [1]`, target = `0` gives output: `-1`

### Implementation
Implement `search(nums::Array{Int64,1}, target::Int64)::Int64` that receives an array of integers `nums` and an integer `target,` and returns the index of the target if it is in `nums,` or `-1` if it is not in `nums.`

You can test your implementation by running the following command on the Julia REPL:

```julia
include("testme.jl")
```

### Scaling
If you want to benchmark your implementation, you can use the following command:

```julia
include("benchmark.jl")
```

We have not implemented a benchmark for this problem, but you can implement your benchmarking logic in the `benchmark.jl` file to test your implementation.