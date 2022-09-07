%Uma volta no eixo = 4075 pulsos / 512 x 8 = 4096
%Meia Volta no eixo = 512x4 = 2048

clear a;
a = arduino("COM4", "Uno");
v = 0.0002;
posicaoAtual = returnToHome(a,v)
posicaoDesejada = 0
% posicaoAtual = rotate(posicaoAtual, posicaoDesejada, a, v)
% posicaoDesejada = -45
% posicaoAtual = rotate(posicaoAtual, posicaoDesejada, a, v)
tensao = mensuredLight(a,v)
plot(0:5:180,tensao)
save ledBranco_teste tensao

return

function tensao = mensuredLight(a, v)
posicaoAtual = 0;
posicaoDesejada = 0;
for n=1:37
posicaoAtual = rotate(posicaoAtual, posicaoDesejada, a, v);
% writeDigitalPin(a,'D2',0);
% writeDigitalPin(a,'D3',0);
% writeDigitalPin(a,'D4',0);
% writeDigitalPin(a,'D5',0);
pause(1);
beep;

        for aux=1:10
            tensao_aux(aux) = readVoltage(a,"A0");
        end
        tensao(n) = mean(tensao_aux);
        posicaoDesejada = posicaoAtual + 5;
    end

end
function posicaoAtual = rotate(posicaoAtual, posicaoDesejada, a, v)
N = round((280*4 * (posicaoDesejada - posicaoAtual))/ 180);
passo_atual = 1;
if(N < 0)
for n=1:-N
n
%move4passosCW(a,v);
passo_atual = move1passoCW(a,v,passo_atual);
end
else
for n=1:N
n
%move4passosCCW(a,v)
passo_atual = move1passoCCW(a,v,passo_atual);
end
end
posicaoAtual = posicaoDesejada
end

function passo_atual = move1passoCW(a,v,passo_atual)
switch passo_atual
case 1
writeDigitalPin(a,'D2',1);
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
case 2
writeDigitalPin(a,'D2',0);
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',0);
case 3
writeDigitalPin(a,'D2',0);
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',1);
case 4
writeDigitalPin(a,'D2',1);
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',1);
end
pause(v);
if passo_atual == 4
passo_atual =1;
else
passo_atual = passo_atual + 1;
end
end

function passo_atual = move1passoCCW(a,v,passo_atual)
switch passo_atual
case 1
writeDigitalPin(a,'D2',0);
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',1);
case 2
writeDigitalPin(a,'D2',0);
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',0);
case 3
writeDigitalPin(a,'D2',1);
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
case 4
writeDigitalPin(a,'D2',1);
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',1);
end
pause(v);
if passo_atual == 4
passo_atual =1;
else
passo_atual = passo_atual + 1;
end
end

function move4passosCW(a,v)
writeDigitalPin(a,'D2',1);
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
pause(v);

    writeDigitalPin(a,'D2',0);
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',1);
    writeDigitalPin(a,'D5',0);
    pause(v);

    writeDigitalPin(a,'D2',0);
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',1);
    writeDigitalPin(a,'D5',1);
    pause(v);

    writeDigitalPin(a,'D2',1);
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D5',1);
    pause(v);

end

function move4passosCCW(a,v)
writeDigitalPin(a,'D2',0);
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',1);
pause(v);

    writeDigitalPin(a,'D2',0);
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',1);
    writeDigitalPin(a,'D5',0);
    pause(v);

    writeDigitalPin(a,'D2',1);
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D5',0);
    pause(v);

    writeDigitalPin(a,'D2',1);
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D5',1);
    pause(v);

end

function posicaoAtual = returnToHome(a,v)
n = 0
while(readDigitalPin(a,'D6'))
n = n + 1
writeDigitalPin(a,'D2',1);
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
pause(v);

        writeDigitalPin(a,'D2',0);
        writeDigitalPin(a,'D3',1);
        writeDigitalPin(a,'D4',1);
        writeDigitalPin(a,'D5',0);
        pause(v);

        writeDigitalPin(a,'D2',0);
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D4',1);
        writeDigitalPin(a,'D5',1);
        pause(v);

        writeDigitalPin(a,'D2',1);
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D4',0);
        writeDigitalPin(a,'D5',1);
        pause(v);
    end
    posicaoAtual = -90

end
