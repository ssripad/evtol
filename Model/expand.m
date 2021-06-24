function [out] = expand(in, n)
    if length(in) < n
        out = in.*ones(1,n);
    else 
        out = in;
    end
end