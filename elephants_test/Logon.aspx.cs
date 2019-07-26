//==================================================
//　　　　　　　　　Logon_aspx.cs
//　　　　　　助けるゾウ　ログオンページ
//　　　　坂口　裕宜　2019.5.26 最終更新
//
//　　　　　　バグとりはただの修行でしたわ
//==================================================
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace elephants_test
{
    public partial class Logon : System.Web.UI.Page
    {
        //メンバーの変数宣言
        int staffID;
        string staffName;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            UserTextBox.Focus();//フォーカスの自働セット

            this.Form.DefaultButton = LogonButton.UniqueID;//Enterでログオン処理
        }

        protected void LogonButton_Click(object sender, EventArgs e)
        {
            if (UserTextBox.Text == "")
            {
                MessageLabel.Text = "ユーザーIDを入力してください";
                return;
            }

            //パスワードの入力チェック
            if((PassTextBox.Text == "") && (UserTextBox.Text == "sakaguchi"))
            {
                MessageLabel.Text = "物好きマイペース人間でこのソフトの発案設計開発者らしいゾウ";
                return;
            }
            else if (PassTextBox.Text == "")
            {
                MessageLabel.Text = "パスワードを入力してください";
                return;
            }

            if (!CheckUserPassword(UserTextBox.Text, PassTextBox.Text))
            {
                MessageLabel.Text = "ユーザーIDまたはパスワードが違います";
                return;
            }
            //セッション変数への入力
            Session["StaffID"] = staffID;
            Session["StaffName"] = staffName;

            Response.Redirect("design_desk.aspx");
        }

        private bool CheckUserPassword(string userid,string password)
        {
            bool ret;
            string queryString;
            
            try
            {
                queryString = "SELECT staffID, staffname FROM tbl_staff " +
                    "WHERE userID = '" + userid.Replace("'", "''") +//WHERE userID = '入力したid'
                    "' AND password = '" + password.Replace("'", "'") + "' " +//AND password= '入力したpassword'
                    "COLLATE Japanese_CS_AS_KS_WS";//パスワードの大文字小文字の判定

                //接続文字列を取得する
                string connectionString = System.Configuration.ConfigurationManager.
                    ConnectionStrings["ELEPHANTS_TESTConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(queryString, connection);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    //データーリーダーから結果を読み込む
                    if (reader.Read())
                    {
                        staffID = Int32.Parse(reader["staffID"].ToString());
                        staffName = reader["staffname"].ToString();
                        ret = true;
                    }
                    else
                    {
                        ret = false;
                    } 


                }
            }
            catch(Exception)
            {
                ret = false;
            }

            return ret;
        }
    }
}