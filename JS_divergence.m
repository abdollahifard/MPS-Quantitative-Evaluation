function d=JS_divergence(h,g)
% Jensen shannon divergence between two (not necessarily normalized)
%    histograms

h=h/sum(h);
g=g/sum(g);
h(h==0) = eps;
g(g==0) = eps;
d=sum(0.5*h.*log2(h./g)+0.5*g.*log2(g./h));
d= min(d,1);