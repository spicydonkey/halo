function Vect_filt = ballfilter(Vect, R)
% input: Vect must be a 3xN double vector array; R is a non-negative double
% output: Vect_filt is a 3XM double vector array of all vectors in Vect
% with magnitude less than R

in_ball = sqrt(sum(Vect.^2,1))<R;   % boolean array of elements in ball
n = sum(in_ball);       % number of vectors in ball
Vect_filt = zeros(3,n);

% Fill output vector with only the vectors in ball
counter = 1;
for i=1:size(Vect,2)
    if in_ball(i)
        Vect_filt(:,counter) = Vect(:,i);
        counter = counter + 1;
    end
end

return