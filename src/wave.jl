"""
    iuwt_decomp(x::Matrix{T}, scale::Int; store_c0=false) where T <: Real
"""
function iuwt_decomp(x::Matrix{T}, scale::Int; store_c0=false) where T <: Real

    coeff = zeros(Float64, size(x,1), size(x,2), scale)
    c0 = copy(x)

    for i in 1:scale
        c = a_trous(c0, i)
        c1 = a_trous(c, i)
        coeff[:, :, i ] = c0 - c1
        c0 = copy(c)
    end
    
    if store_c0 == true 
        return coeff, c0
    else
        return coeff
    end

    store_c0 == true ? (coeff, c0) : coef

end

"""
    iuwt_recomp(x::Array{Float64, 3}, scale::Int; c0 = false)
"""
function iuwt_recomp(x::Array{Float64, 3}, scale::Int; c0 = false)

    max_scale = size(x,3) + scale

    if c0 != false
        recomp = c0
    else
        recomp = zeros(Float64, size(x,1), size(x,2))
    end

    for i in range(start = max_scale, step = -1, length = size(x,3))
        recomp = a_trous(recomp, i) + x[:, :, i - scale]
    end
    if scale > 0
        for i in range(start = scale, step = -1, length = scale)
            recomp = a_trous(recomp, i)
        end
    end

    return recomp
end

"""
    iuwt_decomp_adj(u::Array{Float64,3}, scale::Int)
"""
function iuwt_decomp_adj(u::Array{Float64,3}, scale::Int)
    htu = iuwt_decomp(u[:,:,1],1)[:,:,1]
        for k in 2:scale
            htu += iuwt_decomp(u[:,:,k],k)[:,:,k]
        end
    return htu
end

function a_trous(c0::Array{Float64, 2}, scale::Int)

    filter = (1/16)*[1,4,6,4,1]

    N = size(c0,1)
    scale -= 1

    ind0 = 2^(scale)
    ind1 = 2^(scale+1)

    tmp = filter[3]*c0    

    for k in 1:N
        for ind1N in ind1+1:N
            @inbounds tmp[ind1N,k] += filter[1]*c0[ind1N - ind1,k]
        end
        for iind1 in 1:ind1
            @inbounds tmp[iind1,k] += filter[1]*c0[ind1+1 - iind1,k]
        end
        for ind0N in ind0+1:N
            @inbounds tmp[ind0N,k] += filter[2]*c0[ind0N - ind0,k]
        end
        for iind0 in 1:ind0
            @inbounds tmp[iind0,k] += filter[2]*c0[ind0+1 - iind0,k]
        end
        for ind0N in ind0+1:N
            @inbounds tmp[ind0N - ind0,k] += filter[4]*c0[ind0N,k]
        end
        for ind in 1:ind0
            @inbounds tmp[N-ind0 + ind,k] += filter[4]*c0[N+1 - ind,k]
        end
        for ind1N in ind1+1:N
            @inbounds tmp[ind1N - ind1,k] += filter[5]*c0[ind1N,k]
        end
        for ind in 1:ind1
            @inbounds tmp[N-ind1+ind,k] += filter[5]*c0[N+1-ind,k]
        end
    end

    tmp = tmp'
    c1 = filter[3]*tmp
  
    for k in 1:N
        for ind1N in ind1+1:N
            @inbounds c1[ind1N,k] += filter[1]*tmp[ind1N - ind1,k]
        end
        for iind1 in 1:ind1
            @inbounds c1[iind1,k] += filter[1]*tmp[ind1+1 - iind1,k]
        end
        for ind0N in ind0+1:N
            @inbounds c1[ind0N,k] += filter[2]*tmp[ind0N - ind0,k]
        end
        for iind0 in 1:ind0
            @inbounds c1[iind0,k] += filter[2]*tmp[ind0+1 - iind0,k]
        end
        for ind0N in ind0+1:N
            @inbounds c1[ind0N - ind0,k] += filter[4]*tmp[ind0N,k]
        end
        for ind in 1:ind0
            @inbounds c1[N-ind0 + ind,k] += filter[4]*tmp[N+1 - ind,k]
        end
        for ind1N in ind1+1:N
            @inbounds c1[ind1N - ind1,k] += filter[5]*tmp[ind1N,k]
        end
        for ind in 1:ind1
            @inbounds c1[N-ind1+ind,k] += filter[5]*tmp[N+1-ind,k]
        end
    end

    return Matrix(c1')
end

