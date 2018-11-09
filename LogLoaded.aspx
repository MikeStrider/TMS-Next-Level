<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogLoaded.aspx.cs" Inherits="LogLoaded" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <br />
    <br />
    <form id="form1" runat="server">
        Log Arrive and Loaded &nbsp; <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Return" /> <br />
        <br />
        Order number
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        The Scheduled PickUp Date and Time is
        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        <br />
        Enter the Actual Arrive Time
        <asp:TextBox ID="TextBox1" runat="server" Width="180px"></asp:TextBox>
        <br />
        Enter the Actual Loaded Time
        <asp:TextBox ID="TextBox2" runat="server" Width="180px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Submit" Width="116px" OnClick="Button1_Click" />
        <br />
        <br />
        Send EDI or Email Notification<br />
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="exp1" DataValueField="emailurl"></asp:RadioButtonList>

        <br />
        Go to Edit Carrier to add more Notification Rules / EDI or Auto E-Mails . <a href="EditCarrier.aspx">click here</a><br />

        <br />

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT companyName + ' - ' + ISNULL(name, ' ') + ' - ' + ISNULL(emailurl, ' ') AS exp1, [emailurl] FROM Notifications WHERE (compid = @compid) ORDER BY name">
            <SelectParameters>
                <asp:SessionParameter Name="compid" SessionField="mySessionVar2" />
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>
