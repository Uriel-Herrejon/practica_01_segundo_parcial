%---------Bloque para reestablecer matlab a su forma inicial---------------
clear all % Se encarga de borrar las variables en el workspace  
clc % Se encarga de borrar el todo lo que se observa en la ventana de comandos
close all % Se encarga de cerrar las ventanas que se tienen abiertas
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%---------Bloque para insertar los datos de los �ngulos y longitudes de la
%articulacion uno y dos del robot------------------------------------------
angdeg = input('Ingresa los grados que deseas rotar la primera aticulac�n:\n');
L1= input('Ingresa la longitud para la articulaci�n 1:\n');

angdeg2 = input('Ingresa los grados que deseas rotar la segunda aticulac�n:\n');
L2= input('Ingresa la longitud para la articulac�n 2:\n');
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%-------Bloque de conversi�n de los �ngulos a radianes---------------------
angrad = deg2rad(angdeg); % se encarga de convertir los grados de la 
                          % articulaci�n 1 a radianes 
angrad2 = deg2rad(angdeg2);% se encarga de convertir los grados de la 
                          % articulaci�n 2 a radianes 
% Se realiza la conversi�n porque matlab no puede leer grados matlab solo
% puede trabajar con radianes, y esa conversi�n la guardamos en unas
% variables.
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%------Bloque de funcion printAxis Para establecer y trazar lso ejes-------
printAxis() % Esta funci�n fue creada en otro script con el c�digo para 
            % establecer los ejes del plano carteciano, los cuales por el 
            % por el momento son el eje X y el eje Y
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--------Bloque del punto de origen establecido como un vector rengl�n-----
p1=[0 0 0]'; % Se coloca el punto principal en cero en el eje X,Y,Z para
             % que sea el punto de partida y se realiza su transpuesta 
             % para que se genere un vector columna y sea una matriz de 3x1
             % y se pueda multiplicar por otra matriz
%--------------------------------------------------------------------------           
             
%--------------------------------------------------------------------------
%-----Bloque de condici�n para realizar rotacion positiva y negativa de la
% primera articulaci�n-----------------------------------------------------
if angdeg>=0 % S� el �ngulo es mayor o igual a 0 hace la siguiente acci�n 
    angVec = 0:0.01:angrad % El �ngulo del vector va incrementar en 0.01�
                           % desde 0 hasta el �gulo indicado por el usuario
                           % sobre el eje positivo.
                           
else  % S� no cumple la condici�n realiza lo siguiente 
    
    angVec =0:-0.01:angrad % El �ngulo del vector va a decrementar en -0.01�
                           % desde 0 hasta el �gulo indicado por el usuario
                           % sobre el eje negativo.
end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%-----bloque de ciclo for para realizar la animaci�n e ir imprimiendo las 
% lineas de la rotaci�n de la articulaci�n 1-------------------------------
for  i=1:length(angVec) % Se encarga de realizar una animaci�n de la 
                        % primera articulaci�n  que va incrementando desde
                        % 1 hasta el �ngulo que el usuario introdujo en 
                        % angdeg con un incremento 0.01 en 
                        % la primera articulaci�n
                        
    clf % Se encarga de ir borrando cada uno de los trazos realizados para
        % para que se observe el efector final y no se vean todas las 
        % impresiones
        
    printAxis() % Esta funci�n fue creada en otro script con el c�digo para 
              % establecer los ejes del plano carteciano, los cuales por el 
              % por el momento son el eje X y el eje Y
              
    TRz1 = [ cos(angVec(i)) -sin(angVec(i)) 0 0 ; sin(angVec(i)) cos(angVec(i)) 0 0 ; 0 0 1 0;  0 0 0 1 ];
           % Se coloc� la matriz de rotaci�n en el eje Z, y se encarga de 
           % ir realizando la rotaci�n en Z de uno hasta el �ngulo
           % requerido de 0.01 en 0.01
           
    TTx1 = [ 1 0 0 L1; 0 1 0 0; 0 0 1 0; 0 0 0 1]; % Se coloca la matriz 
           % traslacion en el eje X dejando como variable L1 la cual ser�
           % introducida por el usuario
           
    T1 = TRz1 * TTx1; % Se guarda en la variable T1 la multiplicaci�n de la
                      % matriz de rotaci�n en el eje Z y la matriz de 
                      % traslaci�n en el eje X para poder crear una matriz
                      % de transformacion homogenea y poder realizar la
                      % impresi�n de las lineas
                      
    p2 = T1 (1:3,4); % Se encarga de tomar la posicion final de la matriz 
                     % T1 recuperando  el valor 1 hasta el 3 de la columna
                     % 4
                     
    line([p1(1) p2(1)],[p1(2) p2(2)],[p1(3) p2(3)]) % Se realiza la impres-
                     % i�n final del eslabon 1 
    
%--------------------------------------------------------------------------
%------------Bloque de articulaci�n 2 en estado inicial--------------------
    TRz2 = [ cos(0) -sin(0) 0 0 ; sin(0) cos(0) 0 0 ; 0 0 1 0; 0 0 0 1 ];
           % Se coloc� la matriz de rotaci�n en el eje Z, y se encarga de 
           % ir realizando la rotaci�n en Z de uno hasta el �ngulo
           % requerido de 0.01 en 0.01
           
    TTx2 = [ 1 0 0 L2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
           % traslacion en el eje X dejando como variable L2 la cual ser�
           % introducida por el usuario
           
    T2 = TRz2 * TTx2; % Se guarda en la variable T1 la multiplicaci�n de la
                     % matriz de rotaci�n en el eje Z y la matriz de 
                     % traslaci�n en el eje X para poder crear una matriz
                     % de transformacion homogenea y poder realizar la
                     % impresi�n de las lineas
    
    Tf = T1*T2; % Se encarga de realizar el efector final o punto final
    
    p3 = Tf (1:3,4); % Se encarga de tomar la posicion final de la matriz 
                     % Tf recuperando  el valor 1 hasta el 3 de la columna
                     % 4
    
    line([p2(1) p3(1)],[p2(2) p3(2)],[p2(3) p3(3)],'color',[0 1 1]);
                     % Se realiza la impresi�n final del eslabon 2 
%--------------------------------------------------------------------------
    pause(0.1)
    
end

