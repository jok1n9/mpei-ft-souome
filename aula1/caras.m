function [probSimulacao] = caras(p, n, c, e)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

lancamentos = rand(n,e) > p;
sucessos= sum(lancamentos)==c;
probSimulacao= sum(sucessos)/e;
end

