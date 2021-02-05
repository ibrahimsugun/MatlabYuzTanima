faceDetector=vision.CascadeObjectDetector('FrontalFaceCART'); %yuz bulma dedektoru olusturuluyor



img=imread('oraybora4.jpg'); %resim yukleniyor



BB=step(faceDetector,img); % resimlerin x y eksenine gore  kordinatlari BB degiskenine atiliyor

iimg = insertObjectAnnotation(img, 'rectangle', BB, 'Face'); %kordinatlardaki yuzler cerceveye aliniyor

figure(1);  %birinci figur gosteriliyor
imshow(iimg); %birinci figurdeki resim gosteriliyor
title('Detected face'); %resmin basligi


htextinsface = vision.TextInserter('Text', 'face   : %2d', 'Location',  [5 2],'Font', 'Courier New','FontSize', 14);


%imshow(img);
hold on  %resmi donduruyoruz
for i=1:size(BB,1)  %BB degiskeninin satir sayisina kadar doner ve herbir yuzu rectangle ile gosterir
    rectangle('position',BB(i,:),'Linewidth',2,'Linestyle','-','Edgecolor','y');
end
hold on %bulunan yuzleri ekranda dondur
N=size(BB,1); %BB degiskeninin satir sayisini N degiskinine ata
handles.N=N;
counter=1;
for i=1:N
    face=imcrop(img,BB(i,:));
    savenam = strcat('C:\Detect face\' ,num2str(counter), '.jpg'); %resimlerin alinacagi klasor yolu
    baseDir  = 'C:\Detect face\TestDatabase\'; %kesilen yuzlerin atilacagi klasor klasor
    %     baseName = 'image_';
    newName  = [baseDir num2str(counter) '.jpg'];
    handles.face=face;
    while exist(newName,'file')
        counter = counter + 1;
        newName = [baseDir num2str(counter) '.jpg'];
    end
    fac=imresize(face,[200,180]);
    imwrite(fac,newName);

figure(2);
imshow(face); 
title('crop pic');
   
    pause(.5);

end