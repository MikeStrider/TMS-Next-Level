<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogEmpty.aspx.cs" Inherits="LogLoaded" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <br />
    <br />
    <form id="form1" runat="server">
        Log Arrive and Empty  &nbsp; <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Return" /> <br /><br />
        <br />
        Order number
            <asp:Label ID="Label1" runat="server" Text="Label" />
        <br />
        The Scheduled Drop Off Date and Time is
        <asp:Label ID="Label2" runat="server" Text="Label" />
        <br />
        Enter the Actual Arrive Time
        <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged" />
        <br />
        Enter the Actual Empty Time
        <asp:TextBox ID="TextBox2" runat="server" />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Submit" Width="116px" OnClick="Button1_Click" /> 
        
        <br />
        <br />
        Send EDI or Email Notification<br />
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="exp1" DataValueField="emailurl"></asp:RadioButtonList>

               <br />
        Go to Edit Carrier to add more Notification Rules / EDI or Auto E-Mails . <a href="EditCarrier.aspx">click here</a><br />

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT companyName + ' - ' + ISNULL(name, ' ') + ' - ' + ISNULL(emailurl, ' ') AS exp1, [emailurl] FROM Notifications WHERE (compid = @compid) ORDER BY name">
            <SelectParameters>
                <asp:SessionParameter Name="compid" SessionField="mySessionVar2" />
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
    </body>
</html>
