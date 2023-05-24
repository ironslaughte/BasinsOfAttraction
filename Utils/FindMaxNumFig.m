function numFig = FindMaxNumFig()
hw =  findobj('type','figure'); %find all figures
hwctr = length(hw);
Nmax = 0;
for j = 1:hwctr %find maximal figure number
      numb = hw(j,1).Number;
      if numb > Nmax
          Nmax = numb;
      end
end
numFig = Nmax + 1;
end