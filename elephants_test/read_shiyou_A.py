#==================================================
#　　　　　　　　　data_read.py
#仕様書エクセルファイルから情報を抽出するプログラム
#　　　　坂口　裕宜　2019.6.22 最終更新
# 問補助仕様書内容の盛り込み
#==================================================
import sys,os,openpyxl,csv

#パイソン型の絶対パスに変換
path = sys.argv[1].replace('\n','\n\n')
wb = openpyxl.load_workbook(path, data_only=True)

#読みだすシートの指定
jutyu_sheet       = wb.get_sheet_by_name('受注仕様書')
shiyou_sheet      = wb.get_sheet_by_name('仕様指示書－印刷－')

#各変数に仕様書情報をセル値を指定し格納
# 引き当て番号名を付加したcsvに、仕様情報を書き込む

sheets.

#助けるゾウが読み込む場所とファイル名前の指定、ファイルには、辞書型変数に格納するための変数を用意。
with open("C:\\elephants\\elephants_test\\elephants_test\\eleph-"+sys.argv[2]+".csv", 'w') as f:
    writer = csv.writer(f)
    writer.writerow(['受注番号'  ,str(jutyu_sheet['AG8'].value  ) ])
    writer.writerow(['引き当て先',str(jutyu_sheet['AG10'].value) ])
    writer.writerow(['支店'      ,str(jutyu_sheet['L8'].value  ) ])
    writer.writerow(['担当者'    ,str(jutyu_sheet['Y6'].value  ) ])
    writer.writerow(['架装型式'  ,str(jutyu_sheet['L27'].value ) ])
    writer.writerow(['メーカー'  ,str(jutyu_sheet['L16'].value  ) ])
    writer.writerow(['車型'      ,str(jutyu_sheet['AG16'].value) ])
    writer.writerow(['乗員数'    ,str(jutyu_sheet['AG18'].value) ])
    writer.writerow(['タイヤ型式',str(jutyu_sheet['L21'].value ) ])
    writer.writerow(['要望積載量',str(jutyu_sheet['AG27'].value) ])
    #kasou_dataに選択式仕様書の架装情報を格納
    for row in range(4, 100):
        writer.writerow([str(shiyou_sheet['D' + str(row)].value),str(shiyou_sheet['E' + str(row)].value) ])
