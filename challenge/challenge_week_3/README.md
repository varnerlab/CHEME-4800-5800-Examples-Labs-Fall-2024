# Challenge Problem Week 3
Given an array of integers `nums` and an integer `target,` return indices of the two numbers such that they add up to the target. 
* You may assume that each input would have exactly one solution, and you may not use the same element twice. 

This challenge is a variation of the [LeetCode problem `Two-sum`](https://leetcode.com/problems/two-sum/), where we'll use `Julia` to implement the solution.

### Examples
* Input: nums = [2,7,11,15], target = 9. Output: [0,1]. Because nums[0] + nums[1] == 9, we return [0, 1].
* Input: nums = [3,2,4], target = 6. Output: [1,2].
* Input: nums = [3,3], target = 6. Output: [0,1].

These examples assume a `0`-based index for arrays. For your test cases, see the `testme.jl` file.

### Implementation
Implement `twosum(nums::Array{T, 1}, target::T)::Union{Nothing, Array{Int64,1}} where T <: Number` that receives an array of integers `nums` and an integer `target`, and returns the indices of the two numbers that add up to `target.`

You can test your implementation by running the following command on the Julia REPL:

```julia
include("testme.jl")
```

### Scaling
If you want to benchmark your implementation, you can use the following command:

```julia
include("benchmark.jl")
```

The brute force solution has a time complexity of $\mathcal{O}(n^2)$, while the optimal solution has a time complexity of $\mathcal{O}(n)$.
