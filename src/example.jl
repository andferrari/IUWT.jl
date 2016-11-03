 include("wave.jl")
#
#  function a_trous(c0::Array{Float64,2}, filter::Array{Float64,1}, scale::Int64)
#
#      scale = scale - 1
#      tmp = filter[3]*c0
#
#      tmp[(2^(scale+1))+1:end,:] += filter[1]*c0[1:(end-(2^(scale+1))),:]
#      tmp[1:(2^(scale+1)),:] += filter[1]*c0[2^(scale+1):-1:1,:]
#
#      tmp[(2^(scale))+1:end,:] += filter[2]*c0[1:(end-(2^(scale))),:]
#      tmp[1:(2^(scale)),:] += filter[2]*c0[2^(scale):-1:1,:]
#
#      tmp[1:(end-(2^(scale))),:] += filter[4]*c0[(2^(scale))+1:end,:]
#      tmp[(end-(2^(scale)))+1:end,:] += filter[4]*c0[end:-1:end-2^(scale)+1,:]
#
#      tmp[1:(end-(2^(scale+1))),:] += filter[5]*c0[2^(scale+1)+1:end,:]
#      tmp[(end-(2^(scale+1))+1):end,:] += filter[5]*c0[end:-1:end-2^(scale+1)+1,:]
#
#      c1 = filter[3]*tmp
#
#      c1[:,(2^(scale+1))+1:end] += filter[1]*tmp[:,1:(end-(2^(scale+1)))]
#      c1[:,1:(2^(scale+1))] += filter[1]*tmp[:,2^(scale+1):-1:1]
#
#      c1[:,(2^(scale))+1:end] += filter[2]*tmp[:,1:(end-(2^(scale)))]
#      c1[:,1:(2^(scale))] += filter[2]*tmp[:,2^(scale):-1:1]
#
#      c1[:,1:(end-(2^(scale)))] += filter[4]*tmp[:,(2^(scale))+1:end]
#      c1[:,(end-(2^(scale))+1):end] += filter[4]*tmp[:,end:-1:end-2^(scale)+1]
#
#      c1[:,1:(end-(2^(scale+1)))] += filter[5]*tmp[:,(2^(scale+1))+1:end]
#      c1[:,(end-(2^(scale+1))+1):end] += filter[5]*tmp[:,end:-1:end-2^(scale+1)+1]
#
#      return c1
#
#  end
#
#
#  function a_trous2(c0::Array{Float64,2}, filter::Array{Float64,1}, scale::Int64)
#
#    N = size(c0,1)
#    scale = scale - 1
#    ind0 = 2^(scale)
#    ind1 = 2^(scale+1)
#
#    ind0N = ind0+1:N
#    ind1N = ind1+1:N
#    Nind0 = 1:(N-ind0)
#    Nind1 = 1:(N-ind1)
#
#    rev1 = ind1:-1:1
#    rev0 = ind0:-1:1
#    Nrev1 = N:-1:N-ind1+1
#    Nrev0 = N:-1:N-ind0+1
#
#    iind1 = 1:ind1
#    iind0 = 1:ind0
#    rev1N = (N-ind1+1):N
#    rev0N = (N-ind0+1):N
#
#    tmp = filter[3]*c0
#
#    tmp[ind1N,:] += filter[1]*c0[Nind1,:]
#    tmp[iind1,:] += filter[1]*c0[rev1,:]
#
#    tmp[ind0N,:] += filter[2]*c0[Nind0,:]
#    tmp[iind0,:] += filter[2]*c0[rev0,:]
#
#    tmp[Nind0,:] += filter[4]*c0[ind0N,:]
#    tmp[rev0N,:] += filter[4]*c0[Nrev0,:]
#
#    tmp[Nind1,:] += filter[5]*c0[ind1N,:]
#    tmp[rev1N,:] += filter[5]*c0[Nrev1,:]
#
#    c1 = filter[3]*tmp
#
#    c1[:,ind1N] += filter[1]*tmp[:,Nind1]
#    c1[:,iind1] += filter[1]*tmp[:,rev1]
#
#    c1[:,ind0N] += filter[2]*tmp[:,Nind0]
#    c1[:,iind0] += filter[2]*tmp[:,rev0]
#
#    c1[:,Nind0] += filter[4]*tmp[:,ind0N]
#    c1[:,rev0N] += filter[4]*tmp[:,Nrev0]
#
#    c1[:,Nind1] += filter[5]*tmp[:,ind1N]
#    c1[:,rev1N] += filter[5]*tmp[:,Nrev1]
#
#      return c1
#
#  end
#
#
#  function a_trous3(c0::Array{Float64,2}, filter::Array{Float64,1}, scale::Int64)
#
#    N = size(c0,1)
#    scale = scale - 1
#
#    ind0 = 2^(scale)
#    ind1 = 2^(scale+1)
#    Nind0 = 1:(N-ind0)
#    Nind1 = 1:(N-ind1)
#    ind0N = ind0+Nind0
#    ind1N = ind1+Nind1
#    iind1 = 1:ind1
#    iind0 = 1:ind0
#    rev1 = ind1:-1:1
#    rev0 = ind0:-1:1
#    Nrev1 = N:-1:N-ind1+1
#    Nrev0 = N:-1:N-ind0+1
#    rev1N = (N-ind1+1):N
#    rev0N = (N-ind0+1):N
#
#
#    tmp = filter[3]*c0
#
#    tmp[ind1N,:] += filter[1]*c0[Nind1,:]
#    tmp[iind1,:] += filter[1]*c0[rev1,:]
#
#    tmp[ind0N,:] += filter[2]*c0[Nind0,:]
#    tmp[iind0,:] += filter[2]*c0[rev0,:]
#
#    tmp[Nind0,:] += filter[4]*c0[ind0N,:]
#    tmp[rev0N,:] += filter[4]*c0[Nrev0,:]
#
#    tmp[Nind1,:] += filter[5]*c0[ind1N,:]
#    tmp[rev1N,:] += filter[5]*c0[Nrev1,:]
#
#    c1 = filter[3]*tmp
#
#    c1[:,ind1N] += filter[1]*tmp[:,Nind1]
#    c1[:,iind1] += filter[1]*tmp[:,rev1]
#
#    c1[:,ind0N] += filter[2]*tmp[:,Nind0]
#    c1[:,iind0] += filter[2]*tmp[:,rev0]
#
#    c1[:,Nind0] += filter[4]*tmp[:,ind0N]
#    c1[:,rev0N] += filter[4]*tmp[:,Nrev0]
#
#    c1[:,Nind1] += filter[5]*tmp[:,ind1N]
#    c1[:,rev1N] += filter[5]*tmp[:,Nrev1]
#
#      return c1
#
#  end
#
# # ---------------------------------------------------------------------------
#
#   function a_trous4(c0::Array{Float64,2}, filter::Array{Float64,1}, scale::Int64)
#
#     N = size(c0,1)
#     scale = scale - 1
#
#     ind0 = 2^(scale)
#     ind1 = 2^(scale+1)
#
#     ind1N = ind1+1:N
#     Nind1 = ind1N - ind1
#
#     ind0N = ind0+1:N
#     Nind0 = ind0N - ind0
#
#
#     iind1 = 1:ind1
#     rev1 = ind1+1 - iind1 #:-1:1
#
#     iind0 = 1:ind0
#     rev0 = ind0+1 - iind0 # :-1:1
#
#     ind = 1-ind0:0
#     rev0N = N + ind
#     Nrev0 = N+1-ind0 - ind
#
#     ind = 1-ind1:0
#     rev1N = N + ind
#     Nrev1 = N+1-ind1 - ind
#
#
#
#     tmp = filter[3]*c0
#
#     tmp[ind1N,:] += filter[1]*c0[Nind1,:]
#     tmp[iind1,:] += filter[1]*c0[rev1,:]
#
#     tmp[ind0N,:] += filter[2]*c0[Nind0,:]
#     tmp[iind0,:] += filter[2]*c0[rev0,:]
#
#     tmp[Nind0,:] += filter[4]*c0[ind0N,:]
#     tmp[rev0N,:] += filter[4]*c0[Nrev0,:]
#
#     tmp[Nind1,:] += filter[5]*c0[ind1N,:]
#     tmp[rev1N,:] += filter[5]*c0[Nrev1,:]
#
#     c1 = filter[3]*tmp
#
#     c1[:,ind1N] += filter[1]*tmp[:,Nind1]
#     c1[:,iind1] += filter[1]*tmp[:,rev1]
#
#     c1[:,ind0N] += filter[2]*tmp[:,Nind0]
#     c1[:,iind0] += filter[2]*tmp[:,rev0]
#
#     c1[:,Nind0] += filter[4]*tmp[:,ind0N]
#     c1[:,rev0N] += filter[4]*tmp[:,Nrev0]
#
#     c1[:,Nind1] += filter[5]*tmp[:,ind1N]
#     c1[:,rev1N] += filter[5]*tmp[:,Nrev1]
#
#       return c1
#
#   end
#
#   # ---------------------------------------------------------------------------
#
#     function for_a_trous(c0::Array{Float64,2}, filter::Array{Float64,1}, scale::Int64)
#
#       N = size(c0,1)
#       scale = scale - 1
#
#       ind0 = 2^(scale)
#       ind1 = 2^(scale+1)
#
#       tmp = filter[3]*c0
#
#
#       for ind1N in ind1+1:N
#           tmp[ind1N,:] += filter[1]*c0[ind1N - ind1,:]
#       end
#       for iind1 in 1:ind1
#           tmp[iind1,:] += filter[1]*c0[ind1+1 - iind1,:]
#       end
#       for ind0N in ind0+1:N
#           tmp[ind0N,:] += filter[2]*c0[ind0N - ind0,:]
#       end
#       for iind0 in 1:ind0
#           tmp[iind0,:] += filter[2]*c0[ind0+1 - iind0,:]
#       end
#       for ind0N in ind0+1:N
#           tmp[ind0N - ind0,:] += filter[4]*c0[ind0N,:]
#       end
#       for ind in 1:ind0
#           tmp[N-ind0 + ind,:] += filter[4]*c0[N+1 - ind,:]
#       end
#       for ind1N in ind1+1:N
#           tmp[ind1N - ind1,:] += filter[5]*c0[ind1N,:]
#       end
#       for ind in 1:ind1
#           tmp[N-ind1+ind,:] += filter[5]*c0[N+1-ind,:]
#       end
#       c1 = filter[3]*tmp
#
#       for ind1N in ind1+1:N
#           c1[:,ind1N] += filter[1]*tmp[:,ind1N - ind1]
#       end
#       for iind1 in 1:ind1
#           c1[:,iind1] += filter[1]*tmp[:,ind1+1 - iind1]
#       end
#       for ind0N in ind0+1:N
#           c1[:,ind0N] += filter[2]*tmp[:,ind0N - ind0]
#       end
#       for iind0 in 1:ind0
#           c1[:,iind0] += filter[2]*tmp[:,ind0+1 - iind0]
#       end
#       for ind0N in ind0+1:N
#           c1[:,ind0N - ind0] += filter[4]*tmp[:,ind0N]
#       end
#       for ind in 1:ind0
#           c1[:,N-ind0+ind] += filter[4]*tmp[:,N+1-ind]
#       end
#       for ind1N in ind1+1:N
#           c1[:,ind1N - ind1] += filter[5]*tmp[:,ind1N - ind1]
#       end
#       for ind in 1:ind1
#           c1[:,N-ind1+ind] += filter[5]*tmp[:,N+1-ind]
#       end
#
#         return c1
#
#     end
#

 N = 1024

 filter = (1/16)*[1,4,6,4,1]

 c0 = rand(N,N)

 scale = 10



# A = 0
# B = 0
# C = 0
# tic()
# for n in 1:5
#  A = a_trous_v_old(c0, scale)
#  end
#  println(" result ")
# toc()
# println("")
# println("")
tic()
for n in 1:5
 B = a_trous(c0,  scale)
 end
 println(" result ")
toc()

# tic()
# for n in 1:5
#  C = for_a_trous(c0, scale)
#  end
# toc()
#
# sum(abs2(A-B))
