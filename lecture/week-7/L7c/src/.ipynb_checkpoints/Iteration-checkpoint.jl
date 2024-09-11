function _rref!(A::Matrix{T}, ɛ=T <: Union{Rational,Integer} ? 0 : eps(norm(A,Inf))) where T
    nr, nc = size(A)
    i = j = 1
    while i <= nr && j <= nc
        (m, mi) = findmax(abs.(A[i:nr,j]))
        mi = mi+i - 1
        if m <= ɛ
            if ɛ > 0
                A[i:nr,j] .= zero(T)
            end
            j += 1
        else
            for k=j:nc
                A[i, k], A[mi, k] = A[mi, k], A[i, k]
            end
            d = A[i,j]
            for k = j:nc
                A[i,k] /= d
            end
            for k = 1:nr
                if k != i
                    d = A[k,j]
                    for l = j:nc
                        A[k,l] -= d*A[i,l]
                    end
                end
            end
            i += 1
            j += 1
        end
    end
    A
end

function _upper_triangular(matrix::Matrix)
    A = copy(matrix)
    (n, m) = size(A)
    for k = 1:min(n,m)
        for i = k+1:n
            l = A[i,k] / A[k,k]
            for j = k:m
                A[i,j] = A[i,j] - l*A[k,j]
            end
        end
    end
    return A
end

"""
    qriteration(A::Array{Float64,2}; maxiter::Int64 = 10, tolerance::Float64 = 1e-9) -> Tuple
"""
function qriteration(A::Array{Float64,2}; maxiter::Int64 = 10, tolerance::Float64 = 1e-9)

    # initialize 
    number_of_rows = size(A,1);
    AD = A;
    ϵ = Inf
    eigenvectors = Dict{Int64,Array{Float64,1}}()

    # compute iteration zero -
    Fₒ = qr(AD)
    Qₒ = Matrix(Fₒ.Q);
    λ = diag(Qₒ)

    # Phase 1: compute eigenvalues
    for _ ∈ 1:maxiter
        
        # factor -
        F = qr(AD)
        Q = Matrix(F.Q);

        # update
        AD = transpose(Q)*AD*Q

        # check: should we continute to iterate?
        λ′ = diag(AD);
        ϵ = norm(λ - λ′)
        if (ϵ < tolerance)
            
            # update the values
            λ = λ′
            
            # we are done with phase 1
            break;
        else
            # have not hit the tolerance - go around some more
            λ = λ′
        end
    end

    # sort the eigenvalues -
    sort!(λ)

    # Phase 2: compute the eigenvectors
    for i ∈ 1:number_of_rows
        
        # setup the homogenous system -
        AH = A - λ[i]*Matrix{Float64}(I, number_of_rows, number_of_rows);
        
        # use row-reduction to get a pivot element
        pivot_value = 1.0
        U = _upper_triangular(AH)
        if (U[end,end] != 0.0)
            pivot_value = U[end,end];
        end
        
        # create augmented system of equations 
        b = zeros(number_of_rows);
        b[number_of_rows] = pivot_value # replace last element w/pivot
        AM = [AH b];

        # compute the unscaled eigenvector -
        EVUS = _rref!(AM)[:,end];

        # compute a scaling normalizing parameter
        d = norm(EVUS);

        # compute the scaled eigenvector - not sure why the (-1)^(i+1)?
        eigenvectors[i] = ((-1)^(i+1))*(1/d)*EVUS
    end

    # return -
    return (λ, eigenvectors)
end
