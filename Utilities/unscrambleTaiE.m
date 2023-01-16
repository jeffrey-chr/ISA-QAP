[D,F] = qap_readFile("..\Instances\ProblemData\DreTai\tai27e02.dat");
Din = D;
Fin = F;
D = unscrM(Din);
F = unscrM(Fin);

function F = unscrM(Fin)
    F = Fin;
    n = size(F,1);
    Fdots = zeros(n);
    for i = 1:n
        Fdots(i,i) = 1;
        for j = i:n
            Fdots(i,j) = 0.5*(F(i,:)/norm(F(i,:)) * F(:,j)/norm(F(:,j))) + 0.5*sum(F(i,:) == F(j,:))/n;
            Fdots(j,i) = Fdots(i,j);
        end
    end
    pileF = ones(n,1);
    currF = [];
    listF = [];
    while any(pileF)
        nxt = find(pileF,1);
        pileF(nxt,1) = 0;
        currF = [nxt];
        for i = find(pileF)'
            if Fdots(i,nxt) > 1-(1-mean(mean(Fdots)))
                pileF(i) = 0;
                currF = [currF,i];
            end
        end
        curr2F = [];
        pile2F = ones(length(currF),1);
        while any(pile2F)
            nxt2 = find(pile2F,1);
            pile2F(nxt2) = 0;
            curr2F = [curr2F,currF(nxt2)];
            for i = find(pile2F)'
                if Fdots(currF(i),currF(nxt2)) > 1-(1-mean(mean(Fdots(currF,currF))))%/2
                    pile2F(i) = 0;
                    curr2F = [curr2F,currF(i)];
                end
            end
        end
        listF = [listF,curr2F];
    end
    F = F(listF,listF);

end