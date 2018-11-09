<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TruckDriver.aspx.cs" Inherits="TruckDriver" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    </head>
<body>
    <br />
    <br />
    <form id="form2" runat="server">
        Truck and Driver<br />
        <br />
        Order number
        :
        <asp:Label ID="Label1" runat="server" Text="Label" />
        <br />
        Current Assigned Truck/Carrier :
        <asp:Label ID="Label3" runat="server" Text="Label" ForeColor="#0066FF"></asp:Label>
        <br />
        Enter the new Drivers Name
        <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged" />
        <br />
        <table>
            <tr>
                <td>
                    <asp:Panel ID="Panel1" runat="server">
                        <asp:RadioButtonList ID="RadioButtonList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="name" Width="151px">
                        </asp:RadioButtonList>
                    </asp:Panel>
                </td>
                <td>
                    <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Submit" />
                &nbsp;<asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Cancel" />
                </td>
            </tr>
        </table>
        .<br />
        <table>
            <tr>
                <td>
        <asp:RadioButtonList ID="RadioButtonList3" runat="server" DataSourceID="SqlDataSource3" DataTextField="name" DataValueField="name">
        </asp:RadioButtonList>
                </td>
                        <td>
                    <asp:Button ID="Button1" runat="server" OnClick="Button6_Click" Text="Submit" />
                &nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button7_Click" Text="Cancel" />
                </td>
            </tr>
        </table>

        <br />

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT name FROM Trucks WHERE (compid = @compid) ORDER BY name">
            <SelectParameters>
                <asp:SessionParameter Name="compid" SessionField="mySessionVar2" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT name FROM companyinfo ORDER BY name">
        </asp:SqlDataSource>
    </form>
</body>
</html>
