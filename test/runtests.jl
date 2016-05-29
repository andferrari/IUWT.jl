using IUWT
using Base.Test

x = randn(128, 128)
scale = 7
coef, c0 = iuwt_decomp(x, scale, store_c0 = true)
 @test_approx_eq_eps norm(x - iuwt_recomp(coef, 0, c0 = c0)) 0.0 1e-10

u = randn(size(coef))
 @test_approx_eq_eps sum(u.*coef) - sum(IUWT.iuwt_decomp_adj(u,scale).*x) 0.0 1e-10
