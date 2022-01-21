% Modeling Materials (ME EN 556) - QM Lab 1 - P1

%space over which to test the potential
x=-1.1:.01:1.1;

%potential well depth
V=100;

%pre-allocate vector for the probabilities
p=zeros(size(x));

%iterate over all x and calculate the potential
for i=1:length(x)
    p(i)=potential(x(i),V);
end
