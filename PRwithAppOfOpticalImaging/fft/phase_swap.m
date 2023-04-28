%image1 = imread('jpgmono/LENNA.jpg');
%image2 = imread('jpgmono/Cameraman.jpg');
image1 = imread('Ganyu.jpg');
image2 = imread('line.jpg');

% グレースケールに変換 (必要に応じて実行)
if size(image1, 3) == 3
    image1 = rgb2gray(image1);
end
if size(image2, 3) == 3
    image2 = rgb2gray(image2);
end

% フーリエ変換(imreadは'uint8'なので、doubleに変換して精度向上)
f_transform1 = fft2(double(image1));
f_transform2 = fft2(double(image2));

% 絶対値と位相を取得
abs1 = abs(f_transform1);
abs2 = abs(f_transform2);
phase1 = angle(f_transform1);
phase2 = angle(f_transform2);

% 位相を入れ替えて複素数を再構成
complex_polar1 = abs1 .* exp(1i * phase2);
complex_polar2 = abs2 .* exp(1i * phase1);

% 逆フーリエ変換
ifft_image1 = ifft2(complex_polar1);
ifft_image2 = ifft2(complex_polar2);

% 実部を取り出し、uint8に変換
result_image1 = uint8(real(ifft_image1));
result_image2 = uint8(real(ifft_image2));

% 結果の画像を表示
figure;
subplot(2, 2, 1); imshow(image1); title('Original Image 1');
saveas(gcf, 'img/monoGanyu.jpg')
subplot(2, 2, 2); imshow(image2); title('Original Image 2');
saveas(gcf, 'img/monoline.jpg')
subplot(2, 2, 3); imshow(result_image1); title('Swapped Phase Image 1');
saveas(gcf, 'img/swapedGanyu.jpg')
subplot(2, 2, 4); imshow(result_image2); title('Swapped Phase Image 2');
saveas(gcf, 'img/swapedline.jpg')
