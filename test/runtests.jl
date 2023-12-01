using IUWT
using LinearAlgebra: norm, dot
using Test

@testset "Decomposition/Recomposition" begin
    x = randn(128, 128)
    scale = 7
    coef, c0 = iuwt_decomp(x, scale, store_c0 = true)
    @test norm(x - iuwt_recomp(coef, 0, c0 = c0)) ≈ 0.0 atol = 1e-10
end

@testset "Adjoint" begin
    x = randn(128, 128)
    scale = 7
    coef, c0 = iuwt_decomp(x, scale, store_c0 = true)
    u = randn(size(coef))
    @test dot(u, coef) ≈ dot(iuwt_decomp_adj(u, scale), x) atol = 1e-10
end