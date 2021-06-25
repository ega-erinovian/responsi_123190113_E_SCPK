clc;
%import data dari excel
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (3:8);
data = readmatrix('Real estate valuation data set.xlsx', opts);
data2 = data(1:50,1:3);
data3 = data(1:50,6);
data4 = [data2 data3];

%atribut tiap-tiap kriteria
k = [0,0,1,0];
%bobot tiap-tiap kriteria
w = [3,5,4,1];

%melakukan normalisasi
[m n]=size (data4);

%membagi bobot per kriteria dengan jumlah total seluruh bobot
w=w./sum(w);

%melakukan perhitungan vektor(s) per baris alternatif
for j=1:n 
    if k(j)==0
        w(j)=-1*w(j); 
    end 
end

%proses perankingan
for i=1:m 
    S(i)=prod(data4(i,:).^w); 
end

V= S/sum(S);
sortV = sort(V, 'descend')
maksV=max(V)
