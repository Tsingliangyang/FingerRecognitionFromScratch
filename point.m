%�ҳ�ϸ����ͼ������ж˵�
%��һ����İ˸������������������ȡ����ֵ���������н����ӣ���ϸ��ͼ���������˵
%��Ϊ2ʱΪ�˵� ��Ϊ6ʱΪ�����
function txy=point(thin)
count=1;
txy(count,:)=[0,0,0];
%ȡ��������������Сֵ
siz=min(size(thin,1),size(thin,2))
for x=40:siz-40
    for y=40:siz-40
        if(thin(y,x))
            CN=0;
            for i=1:8
                CN=CN+abs(p(thin,y,x,i)-p(thin,y,x,i+1));
            end
            if (CN==2)%��Ϊ2ʱΪ�˵� ��Ϊ6ʱΪ�����
                txy(count,:)=[x,y,2];
                count=count+1;
            end
            if(CN==6)%��Ϊ2ʱΪ�˵� ��Ϊ6ʱΪ�����
                txy(count,:)=[x,y,6];
                count=count+1;
            end
        end
    end
end

for i=1:count-1
    x(i)=txy(i,1);
    y(i)=txy(i,2);
end
imshow(double(thin));
% hold on ֪ͨ���潫Ҫ��ͼ
hold on;
plot(x,y,'.');