#==================================================
#�@�@�@�@�@�@�@�@�@data_read.py
#�d�l���G�N�Z���t�@�C��������𒊏o����v���O����
#�@�@�@�@����@�T�X�@2019.6.22 �ŏI�X�V
# ��⏕�d�l�����e�̐��荞��
#==================================================
import sys,os,openpyxl,csv

#�p�C�\���^�̐�΃p�X�ɕϊ�
path = sys.argv[1].replace('\n','\n\n')
wb = openpyxl.load_workbook(path, data_only=True)

#�ǂ݂����V�[�g�̎w��
jutyu_sheet       = wb.get_sheet_by_name('�󒍎d�l��')
shiyou_sheet      = wb.get_sheet_by_name('�d�l�w�����|����|')

#�e�ϐ��Ɏd�l�������Z���l���w�肵�i�[
# �������Ĕԍ�����t������csv�ɁA�d�l������������

sheets.

#������]�E���ǂݍ��ޏꏊ�ƃt�@�C�����O�̎w��A�t�@�C���ɂ́A�����^�ϐ��Ɋi�[���邽�߂̕ϐ���p�ӁB
with open("C:\\elephants\\elephants_test\\elephants_test\\eleph-"+sys.argv[2]+".csv", 'w') as f:
    writer = csv.writer(f)
    writer.writerow(['�󒍔ԍ�'  ,str(jutyu_sheet['AG8'].value  ) ])
    writer.writerow(['�������Đ�',str(jutyu_sheet['AG10'].value) ])
    writer.writerow(['�x�X'      ,str(jutyu_sheet['L8'].value  ) ])
    writer.writerow(['�S����'    ,str(jutyu_sheet['Y6'].value  ) ])
    writer.writerow(['�ˑ��^��'  ,str(jutyu_sheet['L27'].value ) ])
    writer.writerow(['���[�J�['  ,str(jutyu_sheet['L16'].value  ) ])
    writer.writerow(['�Ԍ^'      ,str(jutyu_sheet['AG16'].value) ])
    writer.writerow(['�����'    ,str(jutyu_sheet['AG18'].value) ])
    writer.writerow(['�^�C���^��',str(jutyu_sheet['L21'].value ) ])
    writer.writerow(['�v�]�ύڗ�',str(jutyu_sheet['AG27'].value) ])
    #kasou_data�ɑI�����d�l���̉ˑ������i�[
    for row in range(4, 100):
        writer.writerow([str(shiyou_sheet['D' + str(row)].value),str(shiyou_sheet['E' + str(row)].value) ])
