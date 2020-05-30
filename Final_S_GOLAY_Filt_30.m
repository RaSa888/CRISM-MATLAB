[file_name,path_name]= uigetfile('.img', 'Select resized 640*450*240 .img file');
dims= (str2double(inputdlg({'Rows=','Columns=','Bands='},'Enter Data Dims',1)))';
file_add=strcat(path_name,file_name);
data=multibandread(file_add,dims,'float',0,'bil','ieee-le' );
new_image= zeros(dims);
for r = 2: 449
    for  c= 32: 631
        spectrel= squeeze(data(r,c,:));
        new_spectrel= sgolayfilt(spectrel,30,51);
        new_image(r,c,:)=new_spectrel;
    end 
end 
output_file_name=strrep(file_name,'.img','_sgolay30.img');
output_file= strcat(path_name, output_file_name);
i=enviwrite(new_image,output_file);
msgbox('Done!', 'Complete')