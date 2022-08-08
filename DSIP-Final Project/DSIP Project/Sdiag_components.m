I=double((imread('Photo.jpg'))); 
In=I; 

mask=[1, 1, 1;0, 0, 0;-1, -1, -1]; 
mask=flipud(mask); 
mask=fliplr(mask); 

for i=2:size(I, 1)-1
	for j=2:size(I, 2)-1
		neighbour_matrix=mask.*In(i-1:i+1, j-1:j+1); 
		avg_value=sum(neighbour_matrix(:)); 
		I(i, j)=avg_value; 
	end 
end 
figure, imshow(uint8(I)); 
