%clc,clear,close all;
function w=tuxiangyuchuli(image)
f=imread(image);%��ȡͼ���ڴ�
f=imresize(f,[363,312]);%�ú������ڶ�ͼ�������Ŵ���
figure;imshow(f);
%��rgb2gray ����ɫͼ��ת��Ϊ�Ҷ�ͼ��matlab����ͼ���������uint8����matlab����ֵһ�����double�ͣ�64λ���洢�����㡣
%����Ҫ�Ƚ�ͼ��תΪdouble��ʽ�Ĳ�������
gray=double(rgb2gray(f));
%ת��uint8 imshow()��ʾͼ��ʱ��double������Ϊ��0~1��Χ�ڼ�����1ʱ������ʾΪ��ɫ����imshow��ʾuint8��ʱ��0~255��Χ��
%���Զ�double���͵�ͼ����ʾ��ʱ��Ҫô��һ����0~1֮�䣬Ҫô��double���͵�0~255����תΪuint8���͡�
figure;imshow(uint8(gray));
[m,n]=size(gray);
%��һ�����Ҷ�ֵ������ĳһ��Χ
M=0;var=0;
%��ֵ
for x=1:m
    for y=1:n
        M=M+gray(x,y);
    end
end
M1=M/(m*n);%M1Ϊ��ֵ ���������ܹ��ͳ��Զ��ٸ�����
%����
for x=1:m
    for y=1:n
        var=var+(gray(x,y)-M1).^2;
    end;
end;
var1=var/(m*n);%���㷽�����յĴ�С var1
%��һ�� ********************************
for x=1:m
    for y=1:n
        if gray(x,y)>M1
            gray(x,y)=150+sqrt(2000*(gray(x,y)-M1)/var1);
        else
            gray(x,y)=150-sqrt(2000*(M1-gray(x,y))/var1);
        end
    end
end
figure;imshow(uint8(gray));
%*************************************************************************************************************
%��һ��������Ϻ���ͼ����зָ��Ŀ�������ֳ�ǰ��ɫ�ͱ���ɫ���Ҳ��õķָ�Ϊ���ݶ�������ֵ�ָ
%������ָ��Ч��ȡ��������Ĵ�С����ָ�Ƶ������Ϊһ��һ����ã�������ѡ��3x3�������С���һ���ݶ������ν������ֵ�ͷ�����зָ
%�ָ� �ֳɶ��3*3�Ŀ��С 
M=3;
H=floor(m/M);L=floor(n/M);
aveg1=zeros(H,L);
var1=zeros(H,L);
%����ÿһ���ƽ��ֵ
for x=1:H
    for y=1:L
        aveg=0;var=0;
        %ÿһ��ľ�ֵ
        for i=1:M
            for j=1:M
                aveg=gray(i+(x-1)*M,j+(y-1)*M)+aveg;
            end;
        end;
        aveg1(x,y)=aveg/(M*M);
        %ÿһ��ķ���ֵ
        for i=1:M
            for j=1:M
                var=(gray(i+(x-1)*M,j+(y-1)*M)-aveg1(x,y)).^2+var;
            end;
        end;
        var1(x,y)=var/(M*M);
    end;
end;
%���п��ƽ��ֵ�ͷ���
Gmean=0;Vmean=0;
for x=1:H
    for y=1:L
        Gmean=Gmean+aveg1(x,y);
        Vmean=Vmean+var1(x,y);
    end
end
Gmean1=Gmean/(H*L);
Vmean1=Vmean/(H*L);

%ÿһС���������ȣ��ٴ����ֵ����
% ǰ������ɫ��
gtemp=0;gtotle=0;vtotle=0;vtemp=0;
for x=1:H
    for y=1:L
        if Gmean1>aveg1(x,y)%�����ǰ��ľ�ֵС��ȫ�־�ֵ ����Ϊ��ǰ�� 
            gtemp=gtemp+1;
            gtotle=gtotle+aveg1(x,y);
        end
        if Vmean1<var1(x,y)%�����ǰ��ķ������ȫ�ַ��� ��Ϊ��ǰ��
            vtemp=vtemp+1;
            vtotle=vtotle+var1(x,y);
        end
    end
end
% ǰ����ֵ
G1=gtotle/gtemp;
% ǰ������
V1=vtotle/vtemp;

%�ٴ���ող�����ֵ���
% ��ñ�������ɫ����ֵ���� ���ӿɿ���
gtemp1=0;gtotle1=0;vtotle1=0;vtemp1=0;
for x=1:H
    for y=1:L
        if G1<aveg1(x,y)%�����ǰ��ľ�ֵ����ǰ���ľ�ֵ ����Ϊ�Ǳ���
            gtemp1=gtemp1+1;
            gtotle1=gtotle1+aveg1(x,y);
        end
        if 0<var1(x,y)<V1%�����ǰ�ķ���С��ǰ���ķ��� ����Ϊ�Ǳ���
            vtemp1=vtemp1+1;
            vtotle1=vtotle1+var1(x,y);
        end
    end
end
% ������ֵ
G2=gtotle1/gtemp1;
% ��������
V2=vtotle1/vtemp1;
%�һ���ݶ������ν������ֵ�ͷ�����зָ�ɼ�����ָ��ͼ�����ĻҶ�ֵ����ǰ��ɫ��������ҪΪ��Ƶ�����Ա����ķ���С��ǰ���ķ��
%�ҷֱ���ñ�����ǰ���ľ�ֵ�ͷ���Ȼ���õ�����Ϊ��ɫ ����Ϊ��ɫ��
%Ȼ�󱣴��ھ���e����ֵͼ���У��һ����e��λ�õ���1�ĵ�İ������ĺ�С���ĵõ�����ɫ���ﵽ������ǰ�����루e���󣩡�
%****************************************
%��������H*L��
e=zeros(H,L);
for x=1:H
    for y=1:L
        if aveg1(x,y)>G2 && var1(x,y)<V2 %��ǰ��С���ֵ ���ڱ�����ֵ �ҵ�ǰС��ķ���С�ڱ������� 
            %   ����
            e(x,y)=1;
        end
        %  ǰ���еĸ��ӽ���ɫ�ı�Ϊ��ɫ
        if aveg1(x,y)<G1-100 && var1(x,y)<V2
            e(x,y)=1;
        end
    end
end




%�õ������С����Ϊ0
%����e��λ�õ���1�ĵ�İ������ĺ�С���ĵõ�����ɫ���ﵽ������ǰ�����루e����
for x=2:H-1
    for y=2:L-1
        if e(x,y)==1
            if e(x-1,y) + e(x,y+1)+e(x+1,y+1)+e(x-1,y+1)+e(x+1,y)+e(x+1,y-1)+e(x,y-1)+e(x-1,y-1) <=4
                e(x,y)=0;
            end
        end
    end
end
%Ȼ��ڰ׷�ת�ø���Ȥ��ǰ��ɫ��Ϊ��ɫ��������Icc�У����Ҷ�ͼ��gray���ı���ֵ�滻ΪС�����ĺ͵ľ�ֵ��G1��.
%����m*m����
Icc=ones(m,n);
for x=1:H
    for y=1:L
        if e(x,y)==1 %��� ��ǰ �� 1 ��������Ҫ��
            for i=1:M
                for j=1:M
                    gray(i+(x-1)*M,j+(y-1)*M)=G1;
                    Icc(i+(x-1)*M,j+(y-1)*M)=0;
                end
            end
        end
    end
end
figure,imshow(uint8(gray));
figure,imshow(Icc);

%���ǵõ��ļ��߷��򲢲��ܴﵽ׼ȷʶ��ָ�ơ�������һ�����ؼ��߷�����ǿָ����·�����õķ���Ϊ���ڼ��߷��򳡵���ǿ������
%Ϊ�˹��Ƽ��ߵķ��򳡣��Ѽ��ߵķ��򳡻���Ϊ�˸�����Ȼ����ݰ˸�����ĻҶ�ֵ���ܺ����õ����ߵķ��򡣲���ͼ����ж�ֵ����

%��ָ�Ƽ��߷��򲢶�ֵ��

%*******************************
%*������ͼ�����Ӱ��ܴ���Ӱ��ͼ��������롢�ɼ��ʹ���ȸ��������Լ�����������ˣ��ڽ���������ͼ����ǰ����Ҫ��ͼ�����ȥ�봦��
%*��ֵ�˲������ǣ��Դ�����ĵ�ǰ���أ�ѡ��һ��ģ�壬��ģ��Ϊ���ڽ������ɸ�������ɣ���ģ��ľ�ֵ�����ԭ���ص�ֵ�ķ�����
temp=(1/9)*[1,1,1;1,1,1;1,1,1];%ģ��ϵ��  ��ֵ�˲�
Im=gray;
In=zeros(m,n);
for a=2:m-1
    for b=2:n-1
        In(a,b)=Im(a-1,b-1)*temp(1,1)+Im(a-1,b)*temp(1,2)+Im(a-1,b+1)*temp(1,3)+Im(a,b-1)*temp(2,1)...
            +Im(a,b)*temp(2,2)+Im(a,b+1)*temp(2,3)+Im(a+1,b-1)*temp(3,1)+Im(a+1,b)*temp(3,2)+Im(a+1,b+1)*temp(3,3);
    end
end
gray=In;%ƽ�����ͼ�����
Im=zeros(m,n);
%Ϊ�˹��Ƽ��ߵķ��򳡣��Ѽ��ߵķ��򳡻���Ϊ�˸�����Ȼ����ݰ˸�����ĻҶ�ֵ���ܺ����õ����ߵķ��򡣲���ͼ����ж�ֵ����
%��˸�����ÿ������ĺ�
for x=5:m-5
    for y=5:n-5
        %0-7����ĺ�
        sum1=gray(x,y-4)+gray(x,y-2)+gray(x,y+2)+gray(x,y+4);
        sum2=gray(x-2,y+4)+gray(x-1,y+2)+gray(x+1,y-2)+gray(x+2,y-4);
        sum3=gray(x-2,y+2)+gray(x-4,y+4)+gray(x+2,y-2)+gray(x+4,y-4);
        sum4=gray(x-2,y+1)+gray(x-4,y+2)+gray(x+2,y-1)+gray(x+4,y-2);
        sum5=gray(x-2,y)+gray(x-4,y)+gray(x+2,y)+gray(x+4,y);
        sum6=gray(x-4,y-2)+gray(x-2,y-1)+gray(x+2,y+1)+gray(x+4,y+2);
        sum7=gray(x-4,y-4)+gray(x-2,y-2)+gray(x+2,y+2)+gray(x+4,y+4);
        sum8=gray(x-2,y-4)+gray(x-1,y-2)+gray(x+1,y+2)+gray(x+2,y+4);
        sumi=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8];
        %���ֵ
        summax=max(sumi);
        %��Сֵ
        summin=min(sumi);
        %�� &&ƽ��ֵ
        summ=sum(sumi);
        b=summ/8;
        
        if(summax+summin+4*gray(x,y))> (3*b)
            sumf=summin;
        else
            sumf=summax;
        end
        
        if sumf>b
            Im(x,y)=128;
        else
            Im(x,y)=255;
        end
    end
end
% imshow(Im);


%���������� Icc ��ɫ���Ǹ���Ȥ������ ��ɫ�� 0 ��ʾ���Ǳ�Ե ������Ȥ�ģ���Ҫ�Ե�
for i=1:m
    for j=1:n
        Icc(i,j)=Icc(i,j)*Im(i,j);
    end
end
%ת��Ϊ��ֵͼ
for i=1:m
    for j=1:n
        if (Icc(i,j)==128)
            Icc(i,j)=0;
        else
            Icc(i,j)=1;
        end
    end
end
figure;imshow(double(Icc));
title('Icc');
%��Ϊ���ֲɼ�ԭ����֬ˮ�ֵȣ���ʹָ��ճ�����ѣ���Ӱ�������������ȡ��ʶ�𣬽�������ȥ��ָ���еĿն���ë�̣�
%�����ǰλ�õ�ֵΪ0���������õ��������㣨�������ң��ĺʹ���3��Ϊë�̣�
%�ն����жϷ���Ϊ�õ�Ϊ��ɫ��������������Ϊ��ɫ��ǰ��������������ĺ�Ϊ0����Ϊ�ն���
%ȥ���ն���ë��
u=Icc;
for x=2:m-1
    for y=2:n-1
        if u(x,y)==0
            %�õ��4����㣨�������ң� ������������϶��ǰ׵㣨1����õ�Ϊë��
            if u(x,y-1)+u(x-1,y)+u(x,y+1)+u(x+1,y)>=3
                u(x,y)=1;
            end
        else
            u(x,y)=u(x,y);
        end
    end
end
figure;imshow(u);
title('ȥ��ë��');
%ȥ���ն�
for a=2:m-1
    for b=2:n-1
        if u(a,b)==1
            %Ѱ�Ҷ˵�
            if abs(u(a,b+1)-u(a-1,b+1))+abs(u(a-1,b+1)-u(a-1,b))+abs(u(a-1,b)-u(a-1,b-1))...
                    +abs(u(a-1,b-1)-u(a,b-1))+(abs(u(a,b-1)-u(a+1,b-1)))+abs(u(a+1,b-1)-u(a+1,b))...
                    +abs(u(a+1,b)-u(a+1,b+1))+abs(u(a+1,b+1)-u(a,b+1))~=1
                if (u(a,b+1)+u(a-1,b+1)+u(a-1,b))*(u(a,b-1)+u(a+1,b-1)+u(a+1,b))+(u(a-1,b)+u(a-1,b-1)+u(a,b-1))...
                        *(u(a+1,b)+u(a+1,b+1)+u(a,b+1))==0
                    %ȥ���ն�
                    u(a,b)=0;
                end
            end
        end
    end
end

figure;imshow(u);
title('ȥ���ն�');

%ͼ��ϸ��
v=~u;
figure;imshow(v);
se=strel('square',3);%�������͸�ʴ����������Ȳ����ĽṹԪ�ض���

% ��̬ѧ�����и�ʴ�����ͣ�������ͱ����㡣
% 
% 1. ��ʴ��һ�������߽�㣬ʹ�߽����ڲ������Ĺ��̡�������������С������������塣
% ��ʴ���㷨��
% ��3x3�ĽṹԪ�أ�ɨ��ͼ���ÿһ������
% �ýṹԪ�����串�ǵĶ�ֵͼ�������롱����
% �����Ϊ1�����ͼ��ĸ�����Ϊ1������Ϊ0��
% �����ʹ��ֵͼ���СһȦ
% 
% 2. �����ǽ�������Ӵ������б�����ϲ����������У�ʹ�߽����ⲿ���ŵĹ��̡���������������еĿն���
% ���͵��㷨��
% ��3x3�ĽṹԪ�أ�ɨ��ͼ���ÿһ������
% �ýṹԪ�����串�ǵĶ�ֵͼ�������롱����
% �����Ϊ0�����ͼ��ĸ�����Ϊ0������Ϊ1
% �����ʹ��ֵͼ������һȦ
% 
% 
% 3. �ȸ�ʴ�����͵Ĺ��̳�Ϊ�����㡣��������С���塢����ϸ�㴦�������塢ƽ���ϴ�����ı߽��ͬʱ�������Ըı��������
% 4. �����ͺ�ʴ�Ĺ��̳�Ϊ�����㡣�������������ϸС�ն��������ڽ����塢ƽ����߽��ͬʱ�������Ըı��������
%  
%��ͼ����п��ղ���
fo=imopen(v,se);
figure;imshow(fo);
% �ȸ�ʴ�����ͣ������ǣ�����ʹ�߽�ƽ��������ϸС�ļ�̣��Ͽ�խС������,���������С����
title('������')
v=imclose(fo,se);
figure;imshow(v);
title('������')
w=bwmorph(v,'thin',Inf);%��ͼ�����ϸ��
figure;imshow(w);
title('ϸ��ͼ');
imshow(Icc)
