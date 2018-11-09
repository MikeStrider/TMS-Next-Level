<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditPage.aspx.cs" Inherits="AddPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="StyleSheet.css" rel = "stylesheet" type="text/css" />
</head>
<body style="padding: 12px">
    <form id="form1" runat="server">
        <div>
            <table width="100%">
                <tr>
                    <td width="400">
                        <img src="Images/logo.png" style=" width:70%;  height:auto;">
                    </td>
                    <td>
                        <center>logged in as:
                        <asp:Label ID="lblusername" runat="server"></asp:Label> <br />
                            company id:
                        <asp:Label ID="lblcompid" runat="server"></asp:Label>
                        </center>
                    </td>
                    <td align="right">ASP.NET and MS SQL<br />
                        <i>proof of concept - </i>
                        <asp:LinkButton ID="LinkButton_signout" runat="server" OnClick="LinkButton1_Click">sign out</asp:LinkButton>
                    </td>
                </tr>
            </table>
        <h3>Edit Order</h3>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None" Height="50px" Width="292px" DefaultMode="Edit" onItemUpdated="DetailView_ItemUpdate"
        onItemCommand="DetailView_ItemCommand">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="id" HeaderText="Order Number" InsertVisible="False" ReadOnly="True" SortExpression="id" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" ForeColor="White" />
                </asp:BoundField>
                <asp:BoundField DataField="pickuplocation" HeaderText="Pick Up Location" SortExpression="pickuplocation" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="pickupdateandtime" HeaderText="Pick Up - Date &amp; Time" SortExpression="pickupdateandtime" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="dropofflocation" HeaderText="Drop Off Location" SortExpression="dropofflocation" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="dropoffdateandtime" HeaderText="Drop Off - Date &amp; Time" SortExpression="dropoffdateandtime" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="bookedby" HeaderText="Booked By" SortExpression="bookedby" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:CommandField ShowEditButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
            SelectCommand="SELECT [id], [pickupdateandtime], [dropoffdateandtime], [pickuplocation], [dropofflocation], [bookedby] FROM [orders] WHERE [id] = @id" 
            UpdateCommand="UPDATE [orders] SET [pickupdateandtime] = @pickupdateandtime, [dropoffdateandtime] = @dropoffdateandtime, [pickuplocation] = @pickuplocation, [dropofflocation] = @dropofflocation, [bookedby] = @bookedby WHERE [id] = @id">
           <SelectParameters>
               <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
           </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="pickupdateandtime" Type="String" />
                <asp:Parameter Name="dropoffdateandtime" Type="String" />
                <asp:Parameter Name="pickuplocation" Type="String" />
                <asp:Parameter Name="dropofflocation" Type="String" />
                <asp:Parameter Name="bookedby" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
