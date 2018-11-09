<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrdersPage.aspx.cs" Inherits="orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        td, th {
            padding: 5px;
        }
    </style>
</head>
<body>
    <div style="padding: 12px">
        <form id="form1" runat="server">
            <table width="100%">
                <tr>
                    <td width="300">
                        <img src="Images/logo.png" style="width: 100%; height: auto;">
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
    </div>

    <div id="nav-placeholder"></div>

    <div style="padding-left: 12px">
        <h2 style="padding-bottom: 4px">Available Orders</h2>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
            DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None"
            OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="id" HeaderText="Order Number" ReadOnly="True" SortExpression="id" InsertVisible="False">
                    <HeaderStyle Wrap="False" HorizontalAlign="Left" />
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="pickuplocation" HeaderText="Pick Up Location" SortExpression="pickuplocation">
                    <HeaderStyle Wrap="False" HorizontalAlign="Left" />
                    <ItemStyle Wrap="True" />
                </asp:BoundField>
                <asp:BoundField DataField="pickupdateandtime" HeaderText="Pick Up - Date &amp; Time" DataFormatString="{0:MM/dd/yyyy HH:mm}" SortExpression="pickupdateandtime">
                    <HeaderStyle Wrap="False" HorizontalAlign="Left" />
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="dropofflocation" HeaderText="Drop Off Location" SortExpression="dropofflocation">
                    <HeaderStyle Wrap="False" HorizontalAlign="Left" />
                    <ItemStyle Wrap="True" />
                </asp:BoundField>
                <asp:BoundField DataField="dropoffdateandtime" HeaderText="Drop Off - Date &amp; Time" DataFormatString="{0:MM/dd/yyyy HH:mm}" SortExpression="dropoffdateandtime">
                    <HeaderStyle Wrap="False" HorizontalAlign="Left" />
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="bookedby" HeaderText="Booked By" SortExpression="bookedby">
                    <HeaderStyle Wrap="False" HorizontalAlign="Left" />
                    <ItemStyle Wrap="False" />
                </asp:BoundField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("id", "~/EditPage.aspx?id={0}") %>' Text="edit"></asp:HyperLink>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="delete"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle ForeColor="#0066FF" />
                </asp:TemplateField>

                <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="~/TripMonitor.aspx?id={0}" Text="dispatch">
                    <ItemStyle ForeColor="#0066FF" />
                </asp:HyperLinkField>

                <asp:BoundField DataField="Posted" SortExpression="Posted">

                    <ItemStyle Wrap="False" />
                </asp:BoundField>

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
        <br />
        <a class="set1 btn btn-default" href="AddPage.aspx">Add a New Order</a>

        <%-- <div class="tooltip"><span class="tooltiptext">Create a new order.</span> </div>--%>
        -- all dates are in mm/dd/year<br />
        <br />

        <%-- <div class="tooltip"><span class="tooltiptext">Change contact phone number and email address.</span> </div>--%>
        <br />
        <br />
        <a href="testing.aspx">Admin Functions</a>
        &nbsp;

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            InsertCommand="INSERT INTO [orders] ([pickupdateandtime], [dropoffdateandtime], [pickuplocation], [dropofflocation]) VALUES 
            (@pickupdateandtime, @dropoffdateandtime, @pickuplocation, @dropofflocation)"
            ProviderName="<%$ ConnectionStrings:TMSProgramConnectionString.ProviderName %>"
            SelectCommand="SELECT id, pickupdateandtime, dropoffdateandtime, pickuplocation, dropofflocation, bookedby, Posted FROM orders WHERE (status = 'available') AND (compid = @compid)"
            DeleteCommand="DELETE FROM [orders] WHERE [id] = @id">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
    </div>

    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script>
        $(function () {
            $("#nav-placeholder").load("navpage.html");
        });
    </script>
</body>
</html>
