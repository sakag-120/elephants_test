<%@ Page Title="仕様/部品表" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Master_tbl.aspx.cs" Inherits="elephants_test.Master_tbl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            width: 750px;
            border-style: solid;
            border-width: 1px;
        }
        .auto-style4 {
            color: #FFFFFF;
            background-color: #000099;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style3">
        <tr>
            <td class="auto-style4">仕様項目／構成部品：</td>
            <td>
                <asp:Label ID="TblLabel" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns ="False" ShowFooter ="True" DataKeyNames ="id"
        ShowHeaderWhenEmpty ="True"
        
        OnRowCommand ="GridView1_RowCommand"
        
        CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <%---theme propertyies --%>
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
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
            <asp:TemplateField HeaderText="id">
              <ItemTemplate>
                  <asp:Label Text ='<%# Eval("id") %>' runat ="server"/>
              </ItemTemplate>
              <EditItemTemplate>
                  <asp:Textbox ID = "txtid" Text ='<%# Eval("id") %>' runat ="server" />
              </EditItemTemplate>  
              <FooterTemplate>
                  <asp:Textbox ID = "txtidFooter"  runat ="server" />
                </FooterTemplate>   
            </asp:TemplateField>
            <asp:TemplateField HeaderText="品目番号">
              <ItemTemplate>
                  <asp:Label Text ='<%# Eval("品目番号") %>' runat ="server"/>
              </ItemTemplate>
              <EditItemTemplate>
                  <asp:Textbox ID = "txt品目番号" Text ='<%# Eval("品目番号") %>' runat ="server" />
              </EditItemTemplate>  
              <FooterTemplate>
                  <asp:Textbox ID = "txt品目番号Footer"  runat ="server" />
                </FooterTemplate>   
            </asp:TemplateField>
            <asp:TemplateField HeaderText="品目名称">
              <ItemTemplate>
                  <asp:Label Text ='<%# Eval("品目名称") %>' runat ="server"/>
              </ItemTemplate>
              <EditItemTemplate>
                  <asp:Textbox ID = "txt品目名称" Text ='<%# Eval("品目名称") %>' runat ="server" />
              </EditItemTemplate>  
              <FooterTemplate>
                  <asp:Textbox ID = "txt品目名称Footer"  runat ="server" />
                </FooterTemplate>   
            </asp:TemplateField>
            <asp:TemplateField HeaderText="備考">
              <ItemTemplate>
                  <asp:Label Text ='<%# Eval("備考") %>' runat ="server"/>
              </ItemTemplate>
              <EditItemTemplate>
                  <asp:Textbox ID = "txt備考" Text ='<%# Eval("備考") %>' runat ="server" />
              </EditItemTemplate>  
              <FooterTemplate>
                  <asp:Textbox ID = "txt備考Footer"  runat ="server" />
                </FooterTemplate>   
            </asp:TemplateField>
            <asp:TemplateField HeaderText="個数">
              <ItemTemplate>
                  <asp:Label Text ='<%# Eval("個数") %>' runat ="server"/>
              </ItemTemplate>
              <EditItemTemplate>
                  <asp:Textbox ID = "txt個数" Text ='<%# Eval("個数") %>' runat ="server" />
              </EditItemTemplate>  
              <FooterTemplate>
                  <asp:Textbox ID = "txt個数Footer"  runat ="server" />
                </FooterTemplate>   
            </asp:TemplateField>
            <asp:TemplateField HeaderText="重量">
              <ItemTemplate>
                  <asp:Label Text ='<%# Eval("重量") %>' runat ="server"/>
              </ItemTemplate>
              <EditItemTemplate>
                  <asp:Textbox ID = "txt重量" Text ='<%# Eval("重量") %>' runat ="server" />
              </EditItemTemplate>  
              <FooterTemplate>
                  <asp:Textbox ID = "txt重量Footer"  runat ="server" />
                </FooterTemplate>   
            </asp:TemplateField>                      
        </Columns>
    </asp:GridView>
            <br />
            <asp:Label ID="lblSuccessMessage" Text ="" runat ="server" ForeColor ="Green"/>
            <br />
            <asp:Label ID="lblErroMessage" Text ="" runat ="server" ForeColor ="Red"/>
    
</asp:Content>
