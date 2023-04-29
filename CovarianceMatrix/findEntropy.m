function [entropy] = findEntropy(N_D)
    entropy = -1*sum(N_D(N_D~=0).*log(N_D(N_D~=0)));
end