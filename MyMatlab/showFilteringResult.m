function showFilteringResult(filter, img, filtered)
% filter, img, filtered


%% TF
figure,
subplot(3, 2, 1);
showTf2(img);
title('TF2 Before Filtering');

subplot(3, 2, 2);
showTf2(filtered);
title('TF2 After Filtering');

% Filter
subplot(3, 2, 4),
%freqz2(filter);
showTf2(filter);
title('The frequency response of the filter')

%% Image
subplot(3, 2, 5),
imshow(img);
title('Image Before Filtering')


subplot(3, 2, 6),
imshow(filtered);
title('Image After Filtering')



