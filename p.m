%��������ȡ���ҳ����еĶϵ�ͽ����

%��������ͼ����ÿ�����8����λ�ý������궨��
function j=p(img,x,y,i)
%  4   3   2
%  5   i   1
%  6   7   8
switch(i)
    case {1,9}
        j=img(x+1,y);
    case 2
        j=img(x+1,y-1);
    case 3
        j=img(x,y-1);
    case 4
        j=img(x-1,y-1);
    case 5
        j=img(x-1,y);
    case 6
        j=img(x-1,y+1);
    case 7
        j=img(x,y+1);
    case 8
        j=img(x+1,y+1);
end

        
