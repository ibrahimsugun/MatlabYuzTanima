clear all
close all
clc
datapath = strcat(pwd,'/Veritabani'); 
TestImage =strcat(pwd,'/Test/onderbedo3.jpg');
A = imread(TestImage);      %TestImage yolundaki resmi okuyup A degiskenine atiyoruz.
FaceDetector = vision.CascadeObjectDetector();  %FaceDedector adinda  yuz bulma nesnesi olusturuyoruz.Resmimizde Kaskad yuz bulmaya calistiriyoruz.
BBOX = step(FaceDetector, A); %Bulunan yuzlerin koordinat degerlerini BBOX seklinde bir matris olarak aliyoruz.
resimsayisi = size(BBOX,1);  % kordinat degerlerinin satir sayisini aliyoruz ve resimsayisi diye bir degiskenine atiyoruz
anaresim = zeros(1,resimsayisi); %resimsayisi degiskeninle ayni boyutta bir sifir matrisi olusturuyoruz.
tanit = [];   
for sayi=1:resimsayisi
    I2 = imcrop(A,BBOX(sayi,:));   %bulunan yuz kesiliyor
    I2 = imresize (I2,[200 180]);     %resmin boyutu ayarlaniyor
    [taninma dbadi recog_img] = pcayontemi(datapath,I2);
    taninma
    dbadi
    recog_img
    anaresim(1,sayi) = dbadi;
    tanit(sayi) = taninma;
end

word = cell(1); 
for i=1:length(anaresim)
    olanbu = eslestir(anaresim(i), tanit(i));
    word(i) = {olanbu};
end
B = insertObjectAnnotation(A,'rectangle', BBOX, word,'TextBoxOpacity',0.8,'FontSize',30);
imshow(B);


