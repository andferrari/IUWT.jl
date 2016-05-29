# IUWT

`IUWT.jl` contains a Julia implementation of the second generation Isotropic Undecimated Wavelet Transform (IUWT):

J.-L. Starck, J. Fadili, and F. Murtagh, “The Undecimated Wavelet Decomposition and its Reconstruction,” *Image Processing, IEEE Transactions on*, vol. 16, no. 2, pp. 297–309, 2007.

This Julia implementation is a transcription of this [Python code](https://github.com/ratt-ru/PyMORESANE/blob/master/pymoresane/iuwt.py).

## Installation

```julia
Pkg.clone("https://github.com/andferrari/IUWT.jl.git")
```
## Usage

```julia
using IUWT
x = rand(128,128)
coef, c0 = iuwt_decomp(x, 7, store_c0 = true);
norm(x - iuwt_recomp(coef, 0, c0 = c0))
```

`IUWT.iuwt_decomp_adj()` implements a very slow adjoint operator of the IUWT transform.
