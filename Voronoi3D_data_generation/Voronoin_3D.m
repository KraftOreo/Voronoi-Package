clc
clear all
num = 100;
S = gallery('uniformdata', [3 num], 1);

B = Polyhedron([0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1]);
[V, P] = mpt_voronoi(S, 'bound', B);
%pbound=polytope([0 0 0;150 0 0;150 150 0;0 150 0; 0 0 1;150 0 1;150 150 1;0 150 1]);
Options.pbounds = B;
Options.plot = 1;
Options.sortcells = 1;
%V=mpt_voronoi(S,Options);
plot(V);

% plot(V)
hold on
C = cell(num, 10);

for i = 1:num

    for j = 1:10
        C{i, j} = [];
    end

end

for i = 1:num
    A = V.Set(i, 1).V;
    k = 1;

    for j = 1:num

        if j == i
            continue
        end

        B = V.Set(j, 1).V;
        C1 = intersectfordouble(A, B);

        if size(C1, 1) >= 3
            C{i, k} = C1;
            k = k + 1;
        end

    end

    C2 = faceinbound(A);

    for l = 1:10
        C{i, k} = C2{l};
        k = k + 1;
    end

end

[n, m] = size(C);
filename = 'C:\Users\97653\Desktop\voronoi3D\test.xls';
Excel = actxserver('Excel.Application');
Workbooks = Excel.Workbooks;

if exist(filename, 'file')
    Workbook = invoke(Workbooks, 'Open', filename);
else
    Workbook = invoke(Workbooks, 'Add');
    Workbook.SaveAs(filename);
end

Excel.ActiveWorkbook.Close;

for i = 1:n
    printstr1 = ['Sheet' num2str(i)];
    printpa1 = 1; printpa2 = 3;

    for j = 1:m
        printse1 = 'A'; printse2 = 'B';

        if not(isempty(C{i, j}))
            X = C{i, j};

            for k = 1:m

                if k == j
                    continue
                end

                if not(isempty(C{i, k}))
                    Y = C{i, k};
                    Z = intersectfordouble(X, Y);
                    Z = Z';
                    printstr2 = [printse1 num2str(printpa1) ':' printse2 num2str(printpa2)];

                    if not(isempty(Z))
                        xlswrite('C:\Users\97653\Desktop\voronoi3D\test.xls', Z, printstr1, printstr2);
                        printse1 = char(printse1 + 2); printse2 = char(printse2 + 2);
                    end

                end

            end

        end

        printpa1 = printpa1 + 3; printpa2 = printpa2 + 3;
    end

end
