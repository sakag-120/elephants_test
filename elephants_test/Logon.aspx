<%@ Page Title="ログオンだゾウ" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Logon.aspx.cs" Inherits="elephants_test.Logon" Trace="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 400px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style2">
        <tr>
            <td>ユーザーID:</td>
            <td>
                <asp:TextBox ID="UserTextBox" runat="server" CssClass="imeOff" TabIndex="1"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>パスワード:</td>
            <td>
                <asp:TextBox ID="PassTextBox" runat="server" CssClass="imeOff" TabIndex="2" TextMode="Password"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="LogonButton" runat="server" OnClick="LogonButton_Click" TabIndex="3" Text="ログオン" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:Label ID="MessageLabel" runat="server" ForeColor="#990000"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
