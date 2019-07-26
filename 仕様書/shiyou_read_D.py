#==================================================
#　　　　　　　　　data_read.py
#仕様書エクセルファイルから情報を抽出するプログラム
#　　　　坂口　裕宜　2019.6.25 最終更新
# 寮で、仕様指示書－印刷－の選択が重要であることに気づく
#==================================================
import sys,os,openpyxl,csv


wb = openpyxl.load_workbook('180607_171963_大八清掃社_PB681E-N(保護解除）.xlsm', data_only=True)
sheets=wb.sheetnames


#読みだすシートの指定
jutyu_sheet       = wb.get_sheet_by_name('受注仕様書')
shiyou_sheet      = wb.get_sheet_by_name('仕様指示書－作成－')
naiyou_sheet      = wb.get_sheet_by_name('仕様指示書－印刷－')

#各変数に仕様書情報をセル値を指定し格納
# 引き当て番号名を付加したcsvに、仕様情報を書き込む

 
#助けるゾウが読み込む場所とファイル名前の指定、ファイルには、辞書型変数に格納するための変数を用意。
with open("C:\\elephants\\elephants_test\\elephants_test\\eleph-test.csv", 'w') as f:
    writer = csv.writer(f)
    writer.writerow(['受注番号'  ,str(jutyu_sheet['AG8'].value  ).replace('\n','') ])
    writer.writerow(['引き当て先',str(jutyu_sheet['AG10'].value).replace('\n','')  ])
    writer.writerow(['支店'      ,str(jutyu_sheet['L8'].value  ).replace('\n','')  ])
    writer.writerow(['担当者'    ,str(jutyu_sheet['Y6'].value  ).replace('\n','')  ])
    writer.writerow(['架装型式'  ,str(jutyu_sheet['L27'].value ).replace('\n','')  ])
    writer.writerow(['メーカー'  ,str(jutyu_sheet['L16'].value  ).replace('\n','')  ])
    writer.writerow(['車型'      ,str(jutyu_sheet['AG16'].value).replace('\n','')  ])
    writer.writerow(['乗員数'    ,str(jutyu_sheet['AG18'].value).replace('\n','')  ])
    writer.writerow(['タイヤ型式',str(jutyu_sheet['L21'].value ).replace('\n','')  ])
    writer.writerow(['要望積載量',str(jutyu_sheet['AG27'].value).replace('\n','')  ])
    #kasou_dataに選択式仕様書の架装情報を格納
    for row in range(4, 100):
        writer.writerow([str(shiyou_sheet['D' + str(row)].value).replace('\n',''),str(naiyou_sheet['E' + str(row)].value).replace('\n','') ])


    #kasou_dataに補助仕様書の架装情報を格納  
    toku_shiyou = ""
    num_toku_shiyou = ""
    toku_shiyou_B = ""
    dic_toku = dict()
    for name_sheets in sheets:
        if name_sheets.find("補助") > -1:
            hojoshiyou_sheet = wb.get_sheet_by_name(name_sheets)
            for row in range(20, 44):
                cell_naiyou = str(hojoshiyou_sheet['C' + str(row)].value).replace('\n','')
                cell_koumoku = str(hojoshiyou_sheet['A' + str(row)].value).replace('\n','')
                if  cell_naiyou != "None":
                    if cell_koumoku != "None":
                        if num_toku_shiyou != cell_koumoku:
                            num_toku_shiyou = cell_koumoku
                            toku_shiyou_B = ""
                    toku_shiyou = cell_naiyou
                    toku_shiyou_B += toku_shiyou    
                    dic_toku[num_toku_shiyou] = toku_shiyou_B     

    for key, value in dic_toku.items():
        writer.writerow(['特' + key,value])    