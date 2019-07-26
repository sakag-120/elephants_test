using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace elephants_test
{
    public partial class Master_tbl : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.
                            ConnectionStrings["ELEPHANTS_TESTConnectionString"].ConnectionString;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                PopularGridview();
            }
        }

        void PopularGridview()
        {
            string tablename = Request.QueryString["tbl"];
            TblLabel.Text = "SELECT * FROM " + tablename;

            var dt = new DataTable();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    var cmd = connection.CreateCommand();
                    cmd.CommandText = "SELECT * FROM " + tablename;
                    var sda = new SqlDataAdapter(cmd);
                    sda.Fill(dt);
                }
                if(dt.Rows.Count >0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    dt.Rows.Add(dt.NewRow());
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    GridView1.Rows[0].Cells.Clear();
                    GridView1.Rows[0].Cells.Add(new TableCell());
                    GridView1.Rows[0].Cells[0].ColumnSpan = dt.Columns.Count;
                    GridView1.Rows[0].Cells[0].Text = "データありませんわぁ。。";
                    GridView1.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
                }

            }
            catch (Exception)
            {

            }
            

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string tablename = Request.QueryString["tbl"];
            if (e.CommandName.Equals("Addnew"))
            {
                var dt = new DataTable();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    var cmd = connection.CreateCommand();
                    cmd.CommandText = "INSERT INTO " + tablename + "";
                    var sda = new SqlDataAdapter(cmd);
                    sda.Fill(dt);
                }
                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    dt.Rows.Add(dt.NewRow());
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    GridView1.Rows[0].Cells.Clear();
                    GridView1.Rows[0].Cells.Add(new TableCell());
                    GridView1.Rows[0].Cells[0].ColumnSpan = dt.Columns.Count;
                    GridView1.Rows[0].Cells[0].Text = "データがありません。。";
                    GridView1.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
                }
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}