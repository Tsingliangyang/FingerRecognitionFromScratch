function [w,pxy]=guanghua(thin,txy)
%���߹⻬����.ԭ���ҵ�ÿ���˵㣬ʹ���������ߵķ����ƶ�5�����أ������5������֮����������㣬����Ϊ�˶˵�Ϊë�̣���ȥ���˵�
for j=1:5
    txy=point(thin);
    %txy������Ϊ2�ı�Ϊ1 �����Ϊ0
    pxy=txy(find(txy(:,3)==2),:);
    %��ȡ����
    n=size(pxy,1);
    for i=1:n
        error=0;
        error=walk(thin,pxy(i,1),pxy(i,2),5);
        if error==1;
            thin(pxy(i,2),pxy(i,1))==0;
        end
    end
end
w=thin;
imshow(w);