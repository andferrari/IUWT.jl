using IUWT
using Base.Test

x = rand(128,128)
coef, c0 = iuwt_decomp(x, 7, store_c0 = true);
@test norm(x - iuwt_recomp(coef, 0, c0 = c0)) == 0
