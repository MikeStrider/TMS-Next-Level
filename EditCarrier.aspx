<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditCarrier.aspx.cs" Inherits="EditCarrier" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="padding: 7px">
    <br />
    <form id="form1" runat="server">
    <div>
    
        Update Info for Carrier :
    
        <b><asp:Label ID="Label3" runat="server" Text="Label"></asp:Label></b>
        &nbsp;<asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Return" />
        <br />
        <br />
        <table bgcolor="#E9EBEF">   
            <tr>
                <td>
                      <strong>Update Info for Posted Loads</strong><br />
        <asp:Label ID="Label1" runat="server" Text="Phone Number"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox1" runat="server" Width="219px"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Email Address"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox2" runat="server" Width="281px"></asp:TextBox>
        &nbsp;<asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
                </td>
            </tr>
            </table> 
        <br />
        <table bgcolor="#E9EBEF">    
            <tr>
                <td>
                     <b>Setup Notfication Rules<br />
                     <br /></b>
        contact name
        <asp:TextBox ID="TextBox4" runat="server" Width="203px"></asp:TextBox>
&nbsp; company name
        <asp:TextBox ID="TextBox8" runat="server" Width="272px"></asp:TextBox>
&nbsp; 
                     <br />
                     email
        <asp:TextBox ID="TextBox3" runat="server" Width="251px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <asp:Button ID="Button2" runat="server" Text="Add Email" Width="93px" OnClick="Button2_Click" />
                     <br />
        <br />
        EDI host URL
        <asp:TextBox ID="TextBox5" runat="server" Width="240px"></asp:TextBox>
&nbsp; user name
        <asp:TextBox ID="TextBox6" runat="server" Width="232px"></asp:TextBox>
&nbsp;
                     <br />
                     password
        <asp:TextBox ID="TextBox7" runat="server" Width="199px"></asp:TextBox>
        &nbsp; company name
        <asp:TextBox ID="TextBox9" runat="server" Width="272px"></asp:TextBox>
&nbsp;<asp:Button ID="Button3" runat="server" Text="Add EDI" Width="92px" OnClick="Button3_Click" />
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
            GridLines="None" DataKeyNames="index" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="emailurl" HeaderText="emailurl" SortExpression="emailurl" />
                <asp:BoundField DataField="companyName" HeaderText="companyName" SortExpression="companyName" />
                <asp:BoundField DataField="username" HeaderText="username" SortExpression="username" />
                <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
                </td>
            </tr>
        </table>
       

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ProviderName="<%$ ConnectionStrings:TMSProgramConnectionString.ProviderName %>"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            SelectCommand="SELECT name, emailurl, companyName, username, password, compid, [index] FROM Notifications WHERE (compid = @compid)"
            DeleteCommand="DELETE FROM [Notifications] WHERE [index] = @index">
            <SelectParameters>
                <asp:SessionParameter Name="compid" SessionField="mySessionVar2" />
            </SelectParameters>
          
        </asp:SqlDataSource>
        <br />
        <br />
    
    </div>
    </form>
</body>
</html>
