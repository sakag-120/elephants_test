<%@ Page Title="設計デスク" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="design_desk.aspx.cs" Inherits="elephants_test.design_desk" Trace="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 212px;
        }
        .auto-style4 {
            text-decoration: underline;
            color: #FFFFFF;
            background-color: #006600;
        }
        .auto-style5 {
            color: #FFFFFF;
            background-color: #006600;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style1">
        <tr>
            <td>
                <asp:Button ID="Bottun_jidousekkei" runat="server" ForeColor="Black" OnClick="Bottun_jidousekkei_Click" Text="自動設計" />
                <span class="auto-style5">設計者</span></td>
            <td>
                <asp:Label ID="DesignerLabel" runat="server"></asp:Label>
            </td>
            <td class="auto-style5">作成/要求日</td>
            <td>
                <asp:Label ID="DesigndataLabel" runat="server"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style1">
        <tr>
            <td class="auto-style5">受注番号</td>
            <td>
                <asp:Label ID="HikiateLabel" runat="server" EnableViewState="False" ForeColor="Black"></asp:Label>
            </td>
            <td class="auto-style5">引き当て先</td>
            <td>
                <asp:Label ID="HikiateNameLabel" runat="server"></asp:Label>
            </td>
            <td class="auto-style5">支店・担当者</td>
            <td>
                <asp:Label ID="ShitenLabel" runat="server"></asp:Label>
            </td>
            <td>
                <asp:Label ID="SalesLabel" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="auto-style1">
        <tr>
            <td class="auto-style5">架装型式</td>
            <td>
                <asp:Label ID="KasouLabel" runat="server"></asp:Label>
            </td>
            <td class="auto-style4">メーカー・車型</td>
            <td>
                <asp:Label ID="SyasiMakerLabel" runat="server"></asp:Label>
            </td>
            <td>
                <asp:Label ID="SyasiLabel" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="auto-style1">
        <tr>
            <td class="auto-style5">積載量　設計/要望（ｋｇ）</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style1">
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ELEPHANTS_TESTConnectionString %>"  OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT [品目番号], [参照表名], [重量], [個数], [備考], [id] FROM [tbl_design]">
                </asp:SqlDataSource>
                <asp:Label ID="Message" runat="server" ForeColor="#FF5050"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" ShowFooter ="True" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" DataKeyNames="id" OnRowDataBound="GridView1_RowDataBound" AllowSorting="True" OnRowCommand="GridView1_RowCommand" OnRowUpdating="GridView1_RowUpdating">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
              <ItemTemplate>
                  <asp:ImageButton ImageUrl="~/Models/images/edit.png" runat ="server" CommandName ="Edit" ToolTip ="Edit" Width ="30px" Height ="30px" />
                  <asp:ImageButton ImageUrl="~/Models/images/delete.png" runat ="server" CommandName ="Delete" ToolTip ="Delete" Width ="30px" Height ="30px" />
              </ItemTemplate>
              <EditItemTemplate>
                  <asp:ImageButton ImageUrl="~/Models/images/save.png" runat ="server" CommandName ="Update" ToolTip ="Update" Width ="30px" Height ="30px" />
                  <asp:ImageButton ImageUrl="~/Models/images/cancel.png" runat ="server" CommandName ="Canel" ToolTip ="Cancel" Width ="30px" Height ="30px" />
              </EditItemTemplate>  
              <FooterTemplate>
                  <asp:ImageButton ImageUrl="~/Models/images/add.png" runat ="server" CommandName ="Addnew" ToolTip ="Addnew" Width ="30px" Height ="30px" />
              </FooterTemplate>   
            </asp:TemplateField>
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" />
                        <asp:TemplateField HeaderText="品目番号" SortExpression="品目番号">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("品目番号") %>'></asp:TextBox>
                            </EditItemTemplate>
                              <FooterTemplate>
                  <asp:Textbox ID = "txt品目番号Footer"  runat ="server" />
                </FooterTemplate>   
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("品目番号") %>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="参照表名" SortExpression="参照表名">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("参照表名") %>'></asp:TextBox>
                            </EditItemTemplate>
                              <FooterTemplate>
                  <asp:Textbox ID = "txt参照表名Footer"  runat ="server" />
                </FooterTemplate>   
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("参照表名") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
            
                        <asp:TemplateField HeaderText="個数" SortExpression="個数">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("個数") %>'></asp:TextBox>
                            </EditItemTemplate>
                              <FooterTemplate>
                  <asp:Textbox ID = "txt個数Footer"  runat ="server" />
                </FooterTemplate>   
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("個数") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="重量" SortExpression="重量">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("重量") %>'></asp:TextBox>
                            </EditItemTemplate>
                              <FooterTemplate>
                  <asp:Textbox ID = "txt重量Footer"  runat ="server" />
                </FooterTemplate>   
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("重量") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="備考(!で注意喚起)" SortExpression="備考">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("備考") %>'></asp:TextBox>
                            </EditItemTemplate>
                              <FooterTemplate>
                  <asp:Textbox ID = "txt備考Footer"  runat ="server" />
                </FooterTemplate>   
            
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("備考") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
                <br />
            </td>
        </tr>
    </table>
    <table class="auto-style1">
        <tr>
            <td>
                <asp:Button ID="Button1" runat="server" Text="保存" />
            </td>
            <td class="auto-style2">&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="Button_datatouroku" runat="server" Text="マスタ送信(!のところのみ)" OnClick="Button_kenzuprint_Click" />
            </td>
            <td>
                <asp:Button ID="Button_syogenprint" runat="server" Text="緒元作成" />
            </td>
        </tr>
    </table>
    <br />
</asp:Content>
