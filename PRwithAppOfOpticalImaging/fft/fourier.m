% addpath('D:\Programing\MATLAB\fft')

change_phase(1, 3);

%for cnt = 1:3
%    printfft_abs(cnt);
%end

function printfft_abs(num)
    % 画像を読み込む
    img = imread("fourier_test" + int2str(num) +".jpg");
    
    % 画像をグレースケールに変換
    img_gray = rgb2gray(img);
    
    % 2次元フーリエ変換を行う
    img_fft = fft2(double(img_gray));
    
    % 中心に原点を移動
    img_fft_shift = fftshift(img_fft);
    
    % フーリエ変換係数の強度を計算
    img_fft_abs = abs(img_fft_shift);
    
    subplot(2, 3, num);
    % 元画像
    imshow(img);
    subplot(2, 3, num+3);
    % フーリエ変換係数の強度を表示
    imshow(log(1 + img_fft_abs), []);
    % 軸ラベルを表示
    xlabel('x');
    ylabel('y');
end


function change_phase(m, n)
    img1 = imread("fourier_test" + int2str(m) +".jpg");
    img2 = imread("fourier_test" + int2str(n) +".jpg");
    img_gray1 = rgb2gray(img1);
    img_gray2 = rgb2gray(img2);
    img_fft1 = fft2(double(img_gray1));
    img_fft2 = fft2(double(img_gray2));
    % img_fft_shift1 = fftshift(img_fft1);
    % img_fft_shift2 = fftshift(img_fft2);
    img_fft_abs1 = abs(img_fft1);
    img_fft_abs2 = abs(img_fft2);
    img_fft_phase1 = angle(img_fft1);
    img_fft_phase2 = angle(img_fft2);
    new_fft1 = img_fft_abs1*exp(1i*img_fft_phase2);
    new_fft2 = img_fft_abs2*exp(1i*img_fft_phase1);
    new_img1 = ifft2(new_fft1);
    new_img2 = ifft2(new_fft2);
    subplot(2, 2, 1);
    imshow(img1);
    subplot(2, 2, 2);
    imshow(img2);
    subplot(2, 2, 3);
    imshow(abs(new_img1));
    new_img1
    subplot(2, 2, 4);
    imshow(abs(new_img2));
end