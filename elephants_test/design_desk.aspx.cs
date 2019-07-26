//==================================================
//　　　　　　　design_desk.aspx.cs
//　　　　　　助けるゾウ　設計デスクページ
//　　　　坂口　裕宜　2019.7.1 最終更新
//
//　　　データベース挿入のためのKEY列の導入
//==================================================
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Diagnostics;
using System.Text;//csv読み込み用
using Microsoft.VisualBasic.FileIO;//parse
using System.Windows.Forms;
using System.Threading;
using System.Data.SqlClient;
using System.Data;

namespace elephants_test
{
    public partial class design_desk : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["StaffID"] == null)
            {
                Response.Redirect("Logon.aspx");//ログオンせずにアクセスできない設定
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //キャッシュしないよう設定
        }


        protected void Bottun_jidousekkei_Click(object sender, EventArgs e)
        {
            //作成者と更新日の書き込み
            DesignerLabel.Text = Convert.ToString(Session["StaffName"]);
            DesigndataLabel.Text = DateTime.Now.ToString("yyyy/MM/dd");

            string fileName = null;//仕様書ファイルのパス格納変数

            //仕様書ファイルのパス取得ウィンドウ立ち上げ
            var t = new Thread((ThreadStart)(() => {
                OpenFileDialog op = new OpenFileDialog();
                op.Title = "ファイルを開く";
                op.InitialDirectory = @"C:\elephants\elephants_test\elephants_test";
                op.FileName = @"○○〇.xlsm";
                op.Filter = "仕様書データ(*.xlsm)|*.xlsm|すべてのファイル(*.*)|*.*";
                op.FilterIndex = 1;
                //オープンファイルダイアログを表示する
                DialogResult result = op.ShowDialog();

                if (result == DialogResult.OK)
                {
                    //「開く」ボタンが選択された時の処理
                    fileName = op.FileName;  //こんな感じで選択されたファイルのパスが取得できる

                }
                else if (result == DialogResult.Cancel)
                {
                    //「キャンセル」ボタンまたは「×」ボタンが選択された時の処理
                }

            }));

            t.SetApartmentState(ApartmentState.STA);
            t.Start();
            t.Join();

            // パイソンプログラムの指定
            string python = @"C:\Users\75110\Anaconda3\python.exe";

            // 仕様書読み込みプログラムコード場所の指定
            string myPythonApp = @"C:\elephants\elephants_test\elephants_test\read_shiyou.py";

            // Create new process start info
            ProcessStartInfo myProcessStartInfo = new ProcessStartInfo(python);

            // 標準出力からの読み込みを可能にする
            myProcessStartInfo.UseShellExecute = false;
            myProcessStartInfo.RedirectStandardOutput = true;

            // パイソンコードを実行する
            // 1st arguments はコードの指定、 2ndは　読み込む仕様書ファイル場所 3rdは作成したcsvの名前に当てる値。
            myProcessStartInfo.Arguments = myPythonApp + " " + fileName + " " + Convert.ToString(Session["StaffID"]);


            //仕様書読み込みコード実行準備
            Process myProcess = new Process();
            // 実行指示内容の入力
            myProcess.StartInfo = myProcessStartInfo;

            // 実行
            myProcess.Start();

            // 標準出力の読み込み 
            // でっとロック除けのため、先に標準出力を読み込み、プロセスが終わるのを待つ。:
            StreamReader myStreamReader = myProcess.StandardOutput;

            // 仕様書読み込みコードの終了信号を待ち、その後、本プログラムを終了する.
            myProcess.WaitForExit();
            myProcess.Close();

            //仕様書読み込みプログラムコードで作成したcsvファイル場所指定         
            TextFieldParser parser = new TextFieldParser(@"C:\elephants\elephants_test\elephants_test\eleph-" + Convert.ToString(Session["StaffID"]) + ".csv", Encoding.GetEncoding("Shift_JIS"));
            parser.TextFieldType = FieldType.Delimited;
            parser.SetDelimiters(",");// ","区切り
            //parser.SetDelimiters("\t");                    // タブ区切り(TSVファイルの場合)
            //csvファイルを辞書型変数に読み込み
            var shiyou_dic = new Dictionary<string, string>();

            while (!parser.EndOfData)
            {
                string[] row = parser.ReadFields();//1行分読み込み
                shiyou_dic.Add(row[0], row[1]);
            }


            //その他辞書登録
            string kasoukata = shiyou_dic["架装型式"];

            if (kasoukata.IndexOf("K4") != -1)
            {
                shiyou_dic.Add("ロードセル", "有");
            }
            else
            {
                shiyou_dic.Add("ロードセル", "無");
            }

            if (kasoukata.IndexOf("SC") != -1)
            {
                shiyou_dic.Add("反転装置", "有");
            }
            else
            {
                shiyou_dic.Add("反転装置", "無");
            }

            
            if (kasoukata.IndexOf("T1") != -1)
            {
                shiyou_dic.Add("都庁仕様", "有");
            }
            else
            {
                shiyou_dic.Add("都庁仕様", "無");
            }

            var q = "-";
            shiyou_dic.Add("架装分類", kasoukata.Substring(0, kasoukata.IndexOf(q)));

            shiyou_dic.Add("架装タイプ", kasoukata.Substring(0, 3));
            
            ////フォームの表示
            HikiateLabel.Text = shiyou_dic["受注番号"];
            HikiateNameLabel.Text = shiyou_dic["引き当て先"];
            ShitenLabel.Text = shiyou_dic["支店"];
            SalesLabel.Text = shiyou_dic["担当者"];
            KasouLabel.Text = shiyou_dic["架装型式"];
            SyasiMakerLabel.Text = shiyou_dic["メーカー"];
            SyasiLabel.Text = shiyou_dic["車型"];

            ///BOM作成開始
            string connectionString = System.Configuration.ConfigurationManager.
                            ConnectionStrings["ELEPHANTS_TESTConnectionString"].ConnectionString;
            string queryString, shiyoukoumoku, shiyounaiyou, joukenshiki;

            
            try
            {
                //部品リスト作成のため、仕様項目/部品構成表の名前(順番)、クエリを明記したcsvファイル場所指定         

                //設計テーブルの削除
                queryString = "DELETE  FROM tbl_design WHERE id = '" + Session["StaffID"] +"';";
                //row[0]=テーブル名
                DataTable dtbl = new DataTable();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    

                    TextFieldParser queryStrings = new TextFieldParser(@"C:\elephants\elephants_test\elephants_test\Master\"+ shiyou_dic["架装型式"].Substring(0, 2) + ".csv", Encoding.GetEncoding("Shift_JIS"));
                    queryStrings.TextFieldType = FieldType.Delimited;
                    queryStrings.SetDelimiters(",,");// ","区切り

                    while (!queryStrings.EndOfData)
                    {
                        //row[0]:テーブル名
                        //row[1...]:仕様項目1("を入れない、内容には'を入れない),仕様項目2,...（品目番号, 品目名称, 備考(!で注意喚起）, ID, ユーザーネーム, 最終更新日を除く）
                        string[] row = queryStrings.ReadFields();//1行分読み込み
                        int cols = row.Length;
                        shiyoukoumoku = "";
                        shiyounaiyou = "";
                        joukenshiki = "";

                        for (int i = 1; i < cols; i++)
                        {
                            if (row[i] != "")
                            {
                                shiyoukoumoku = shiyoukoumoku + "\"" + row[i] + "\"" + ", ";
                                shiyounaiyou = shiyounaiyou + "'" + shiyou_dic[row[i]] + "',";
                                if (i == 1)
                                {
                                    joukenshiki = joukenshiki + " \"" + row[i] + "\" = '" + shiyou_dic[row[i]] + "' ";
                                }
                                else
                                {
                                    joukenshiki = joukenshiki + " AND \"" + row[i] + "\" = '" + shiyou_dic[row[i]] + "' ";
                                }
                                //Console.WriteLine(i + "+" + row[i]);
                            }


                        }
                  

                        queryString = queryString + "INSERT INTO \"" + row[0] + "\"(品目番号, 品目名称, 備考, " +
                              shiyoukoumoku +
                              " ユーザーネーム, 更新日) SELECT '---設計必要---'," +
                              "'" + row[0] + "'" +
                              ",'---検図必！---'," +
                              shiyounaiyou +
                              " '"+ Session["StaffName"] + "', '" + DateTime.Now + "' " +
                              "WHERE NOT EXISTS(SELECT 'X' FROM \"" + row[0] + "\" WHERE" +
                              joukenshiki +
                              ");" +
                              "INSERT tbl_design(品目番号, 備考, 参照表名, id, 条件式) SELECT 品目番号, 備考, " + "'" + row[0] + "', " +
                              "'"+ Session["StaffID"] + "',  '" + joukenshiki.Replace("'", "''") + "'  " +
                              "FROM \"" + row[0] + "\" WHERE" +
                              joukenshiki + ";";

                        File.WriteAllText(@"C:\elephants\elephants_test\elephants_test\bugbird-web.txt", queryString);

                    }


                    
                    SqlCommand command = new SqlCommand(queryString, connection);
                    connection.Open();//接続開始
                    command.ExecuteNonQuery();//設計テーブルにBOM追加
                    GridView1.DataBind();
                }


            }
            catch (Exception)
            {
                Message.Text = "すんません、自動設計時にエラーが検出されました";
            }



        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                string bikou_grid = (string)DataBinder.Eval(e.Row.DataItem, "備考");
                //if (bikou_grid.IndexOf("!") > -1)
                if (bikou_grid.IndexOf("!") > -1)
                {
                    e.Row.BackColor = System.Drawing.Color.WhiteSmoke;
                    e.Row.ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    e.Row.BackColor = System.Drawing.Color.DarkGray;
                    e.Row.ForeColor = System.Drawing.Color.White; 
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
          string connectionString = System.Configuration.ConfigurationManager.
                          ConnectionStrings["ELEPHANTS_TESTConnectionString"].ConnectionString;
            if (e.CommandName.Equals("Addnew"))
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();//接続開始

                        string query_design_add = "INSERT INTO tbl_design(品目番号, 参照表名, 備考, 個数, 重量) VALUES (@品目番号, @参照表名, @備考, @個数, @重量)";
                        //string query_design_add = "INSERT INTO tbl_design(品目番号, 備考, 参照表名, id) VALUES +" +
                        //  "('" + (GridView1.FooterRow.FindControl("TextBox1") as TextBox).Text.Trim() + "'," +
                        // "'@備考'," + "" +
                        //"'@参照表名'," +
                        //"'@id')";
                        Message.Text = (GridView1.FooterRow.FindControl("txt品目番号Footer") as System.Web.UI.WebControls.TextBox).Text.Trim();
                        SqlCommand sqlCmd = new SqlCommand(query_design_add, connection);
                        sqlCmd.Parameters.AddWithValue("@品目番号", (GridView1.FooterRow.FindControl("txt品目番号Footer") as System.Web.UI.WebControls.TextBox).Text.Trim());
                        sqlCmd.Parameters.AddWithValue("@参照表名", (GridView1.FooterRow.FindControl("txt参照表名Footer") as System.Web.UI.WebControls.TextBox).Text.Trim());
                        sqlCmd.Parameters.AddWithValue("@個数", (GridView1.FooterRow.FindControl("txt個数Footer") as System.Web.UI.WebControls.TextBox).Text.Trim());
                        sqlCmd.Parameters.AddWithValue("@重量", (GridView1.FooterRow.FindControl("txt重量Footer") as System.Web.UI.WebControls.TextBox).Text.Trim());
                        sqlCmd.Parameters.AddWithValue("@備考", (GridView1.FooterRow.FindControl("txt備考Footer") as System.Web.UI.WebControls.TextBox).Text.Trim());

                        sqlCmd.ExecuteNonQuery();
                        //あとで追加Message.Text = "";

                        //SqlCommand command = new SqlCommand(query_design_add, connection);
                        sqlCmd.ExecuteNonQuery();//設計テーブルにBOM追加
                        GridView1.DataBind();
                        
                    }
                }
                catch (Exception)
                {

                }

            }
        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.
                          ConnectionStrings["ELEPHANTS_TESTConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection sqlCon = new SqlConnection(connectionString))
                {
                    sqlCon.Open();
                    string query = "UPDATE tbl_design SET 品目番号=@品目番号,参照表名=@参照表名,個数=@個数,重量=@重量 備考=@備考 WHERE 'key' = @key ";
                    SqlCommand sqlCmd = new SqlCommand(query, sqlCon);
                    sqlCmd.Parameters.AddWithValue("@品目番号", (GridView1.Rows[e.RowIndex].FindControl("TextBox1") as System.Web.UI.WebControls.TextBox).Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@参照表名", (GridView1.Rows[e.RowIndex].FindControl("TextBox2") as System.Web.UI.WebControls.TextBox).Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@個数", (GridView1.Rows[e.RowIndex].FindControl("TextBox3") as System.Web.UI.WebControls.TextBox).Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@重量", (GridView1.Rows[e.RowIndex].FindControl("TextBox4") as System.Web.UI.WebControls.TextBox).Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@備考", (GridView1.Rows[e.RowIndex].FindControl("TextBox5") as System.Web.UI.WebControls.TextBox).Text.Trim());
                    sqlCmd.ExecuteNonQuery();
                    GridView1.EditIndex = -1;
                    GridView1.DataBind();
                }
            }
            catch (Exception)
            {
                Message.Text = "すんません、なんかエラーが出て、更新できませんでした。";
            }
        }

        protected void Button_kenzuprint_Click(object sender, EventArgs e)
        {

        }
    }
}

