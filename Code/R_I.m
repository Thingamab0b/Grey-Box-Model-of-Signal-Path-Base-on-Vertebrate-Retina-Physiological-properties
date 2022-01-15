function dRdt=R_I(R,I,t,a,tau)
% if(mod(t/tau,4)==1)
%    I_eff=I(t);
% else
%     I_eff=0;
% end
dRdt=a.*tau.*I-R./tau;
end