<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebForm1.aspx.cs" Inherits="HangfireTesting.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <center>
    <form id="form1" runat="server">
        <div>
            <h1>Testing HangFire !!</h1>
            
            <table>
                <tr>
                    <td>
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Job Fired in the Background" Width="220px" />
                    </td>
                    <td>
                        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Reoccurring Job - On" Width="170px" />
                    </td>
                    <td width="600" align="right">
                        <a href="HangFire">Launch HangFire Dashboard</a><br />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Reoccuring Job - Off" Width="170px" />
                    </td>
                </tr>
                <tr>
                    <td>

                        <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Run a Scheduled Job / Delayed" Width="220px" />

                    </td>
                </tr>
                <tr>
                    <td><asp:Button ID="Button5" runat="server" Text="Run Task at a certain time" OnClick="Button5_Click"></asp:Button></td>
                    <td><asp:TextBox ID="TextBox1" runat="server" Width="217px"></asp:TextBox>
                        <br />
                        Formate Expected : MM/dd/yyyy HH:mm
                    </td>
                </tr>
            </table>
            <br />
            
        </div>
    </form>
</body>
</html>
