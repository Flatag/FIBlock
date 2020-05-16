function Failureprob = es_manual_dist_interpolation( time , distribution )

if(time>distribution(length(distribution)))
Failureprob = 0;
return;
end

for i = 1:length(distribution)
    if(time>distribution(i))
        Xa = distribution(i);
        Ya = distribution(i,2);
    elseif(time==distribution(i))
        Failureprob = distribution(i,2);
        return;
    elseif(time<distribution(i))
        Xb = distribution(i);
        Yb = distribution(i,2);
        break;
    end

end

Failureprob = Ya + (Yb-Ya)*((time-Xa)/(Xb-Xa));

end

