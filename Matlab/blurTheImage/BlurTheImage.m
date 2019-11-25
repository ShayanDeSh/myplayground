im = imread('Ritchie-Dennis.jpg');
c = ones(7,7) / 49;
blured = imfilter(im, c);
subplot(1,2,1);
imshow(im);
subplot(1,2,2);
imshow(blured);
imwrite(blured,'blured.jpg');