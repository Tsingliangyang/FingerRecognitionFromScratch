%ȥ��ͼ���Ե�Ķ˵�

function txy=cut(thin,txy)
% thin=thin1;
% txy=txy1;
%����һ��8*8�ľ���
s(8,8)=0;
delta(8,8)=0;
n=size(txy,1);
for i=1:8
    for j=1:8
        %����һ�����鼯�� m{1��2}=3   m=[] [3]
%          m{2,5}=6
% 
% m = 
% 
%     [1,2,3]    [3]    []    []     []
%     []     []    []    []    [6]

% ÿ��ȡ31*31 �ȴ��ϵ��� �ٴ�������
        mp{i,j}=thin(1+31*(i-1):31+31*(i-1),1+31*(j-1):31+31*(j-1));
        s(i,j)=sum(sum(mp{i,j}))/(31*31);
        mp{i,j}=(mp{i,j}-s(i,j)).^2
        delta(i,j)=sum(sum(mp{i,j}));
%         ��Ե ��ɫ�� ��ɫ��
        if delta(i,j)<=70
            for k=1:n
                if (txy(k,1)>=1+31*(i-1)&&txy(k,1)<31+31*(i-1)&&txy(k,2)>=1+31*(j-1)&&txy(k,2)<=31+31*(j-1)&&txy(k,3)==2)
                    txy(k,:)=[0,0,0];
                end
            end
        end
    end
end
% find()��ѯ����Ԫ�����ڵ�λ��
txy=txy(find(txy(:,1)),:);
plot(txy(:,1),txy(:,2),'ro');
