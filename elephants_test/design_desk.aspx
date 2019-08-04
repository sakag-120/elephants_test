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
        .auto-style6 {
            margin-top: 13px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style1">
        <tr>
            <td>
                <asp:DropDownList ID="Desk_number" runat="server">
                    <asp:ListItem Selected="True" Value="0">設計デスクを選んで！</asp:ListItem>
                    <asp:ListItem Value="1">設計デスク1</asp:ListItem>
                    <asp:ListItem Value="2">設計デスク2</asp:ListItem>
                    <asp:ListItem Value="3">設計デスク3</asp:ListItem>
                    <asp:ListItem Value="4">設計デスク4</asp:ListItem>
                    <asp:ListItem Value="5">設計デスク5</asp:ListItem>
                    <asp:ListItem Value="6">設計デスク6</asp:ListItem>
                    <asp:ListItem Value="7">設計デスク7</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="Bottun_jidousekkei" runat="server" ForeColor="Black" OnClick="Bottun_jidousekkei_Click" Text="自動設計" />
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
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ELEPHANTS_TESTConnectionString %>"  OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT * FROM [tbl_design_1]" DeleteCommand="DELETE FROM [tbl_design_1] WHERE [key] = @key" InsertCommand="INSERT INTO [tbl_design_1] ([品目番号], [参照表名], [個数], [重量], [備考], [key_tbl], [デスクナンバー]) VALUES (@品目番号, @参照表名, @個数, @重量, @備考, @key_tbl, @デスクナンバー)" UpdateCommand="UPDATE [tbl_design_1] SET [品目番号] = @品目番号, [参照表名] = @参照表名, [個数] = @個数, [重量] = @重量, [備考] = @備考, [key_tbl] = @key_tbl, [デスクナンバー] = @デスクナンバー WHERE [key] = @key">
                    <DeleteParameters>
                        <asp:Parameter Name="key" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="品目番号" Type="String" />
                        <asp:Parameter Name="参照表名" Type="String" />
                        <asp:Parameter Name="個数" Type="Byte" />
                        <asp:Parameter Name="重量" Type="Double" />
                        <asp:Parameter Name="備考" Type="String" />
                        <asp:Parameter Name="key_tbl" Type="Int32" />
                        <asp:Parameter Name="デスクナンバー" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="品目番号" Type="String" />
                        <asp:Parameter Name="参照表名" Type="String" />
                        <asp:Parameter Name="個数" Type="Byte" />
                        <asp:Parameter Name="重量" Type="Double" />
                        <asp:Parameter Name="備考" Type="String" />
                        <asp:Parameter Name="key_tbl" Type="Int32" />
                        <asp:Parameter Name="デスクナンバー" Type="Int32" />
                        <asp:Parameter Name="key" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True" CssClass="auto-style6" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/Models/images/save.png" Width="60px"/>
                                <asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/Models/images/cancel.png" Width="50px" />
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/Models/images/add.png" Width="60px" OnClick="ImageButton5_Click" />
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Models/images/edit.png"  Width="30px" CommandName="Edit"/>
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Models/images/delete.png" Width="30px" CommandName="Delete" />
                            </ItemTemplate>
                            <ItemStyle Width="70px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="No.">
                            <EditItemTemplate>
                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("key") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("key") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="品目番号">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("品目番号") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox5" runat="server">---------A</asp:TextBox>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("品目番号") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="参照表名">
                            <EditItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("参照表名") %>'></asp:Label>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox7" runat="server">品目名称を入れるんや！</asp:TextBox>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("参照表名") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="個数">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Eval("個数") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox8" runat="server">個数（整数）</asp:TextBox>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("個数") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="備考">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Eval("備考") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox9" runat="server">部品の説明</asp:TextBox>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("備考") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="重量">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Eval("重量") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox10" runat="server">重量(半角,小数点可)</asp:TextBox>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("重量") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField HeaderText="リンクへ" />
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
                <asp:Label ID="Message" runat="server" ForeColor="#FF5050"></asp:Label>
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
