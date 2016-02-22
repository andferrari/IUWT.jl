@everywhere function iuwt_decomp(x::Array{Float64,2}, scale::Int64; store_c0=false)

    filter = (1/16)*[1,4,6,4,1]

    coeff = zeros(Float64,size(x,1),size(x,2),scale)
    c0 = copy(x)

    for i in 1:scale
        c = a_trous(c0,filter,i)
        c1 = a_trous(c,filter,i)
        coeff[:,:,i] = c0 - c1
        c0 = copy(c)
    end
    if store_c0 == true
        return coeff,c0
    else
        return coeff
    end
end

@everywhere function iuwt_recomp(x::Array{Float64,3}, scale::Int64; c0=false)

    filter = (1/16)*[1,4,6,4,1]

    max_scale = size(x,3) + scale

    if c0 != false
        println("recomp init with c0")
        recomp = c0
    else
        recomp = zeros(Float64,size(x,1),size(x,2))
    end

    for i in range(max_scale,-1,size(x,3))
        recomp = a_trous(recomp,filter,i) + x[:,:,i-scale]
    end
    if scale > 0
        for i in range(scale,-1,scale)
            recomp = a_trous(recomp,filter,i)
        end
    end

    return recomp
end

@everywhere function a_trous(c0::Array{Float64,2}, filter::Array{Float64,1}, scale::Int64)

    scale = scale - 1
    tmp = filter[3]*c0

    tmp[(2^(scale+1))+1:end,:] += filter[1]*c0[1:(end-(2^(scale+1))),:]
    tmp[1:(2^(scale+1)),:] += filter[1]*c0[2^(scale+1):-1:1,:]

    tmp[(2^(scale))+1:end,:] += filter[2]*c0[1:(end-(2^(scale))),:]
    tmp[1:(2^(scale)),:] += filter[2]*c0[2^(scale):-1:1,:]

    tmp[1:(end-(2^(scale))),:] += filter[4]*c0[(2^(scale))+1:end,:]
    tmp[(end-(2^(scale)))+1:end,:] += filter[4]*c0[end:-1:end-2^(scale)+1,:]

    tmp[1:(end-(2^(scale+1))),:] += filter[5]*c0[2^(scale+1)+1:end,:]
    tmp[(end-(2^(scale+1))+1):end,:] += filter[5]*c0[end:-1:end-2^(scale+1)+1,:]

    c1 = filter[3]*tmp

    c1[:,(2^(scale+1))+1:end] += filter[1]*tmp[:,1:(end-(2^(scale+1)))]
    c1[:,1:(2^(scale+1))] += filter[1]*tmp[:,2^(scale+1):-1:1]

    c1[:,(2^(scale))+1:end] += filter[2]*tmp[:,1:(end-(2^(scale)))]
    c1[:,1:(2^(scale))] += filter[2]*tmp[:,2^(scale):-1:1]

    c1[:,1:(end-(2^(scale)))] += filter[4]*tmp[:,(2^(scale))+1:end]
    c1[:,(end-(2^(scale))+1):end] += filter[4]*tmp[:,end:-1:end-2^(scale)+1]

    c1[:,1:(end-(2^(scale+1)))] += filter[5]*tmp[:,(2^(scale+1))+1:end]
    c1[:,(end-(2^(scale+1))+1):end] += filter[5]*tmp[:,end:-1:end-2^(scale+1)+1]

    return c1

end
