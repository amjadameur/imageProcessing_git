function filtered = applyConv2(filter, img)

filtered = conv2(img, filter, 'same');
filtered = uint8(filtered);

showFilteringResult(filter, img, filtered);




