rgbValues = spectrumRGB(400:0.2:700); % go from 400 to 650 nm wavelength
image = repmat(rgbValues, 200, 1, 1); % 200 is the height of image in pixel
imshow(image)