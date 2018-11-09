<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadPaperwork.aspx.cs" Inherits="UploadPaperwork" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        a.set1:link {color: rgb(80, 124, 209);}
        a.set1:active {color: rgb(80, 124, 209);}
        a.set1:visited {color: rgb(80, 124, 209);}
    </style>
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
            
            <h2>Upload Paperwork</h2>
                           

   / <div class="tooltip"><a href="OrdersPage.aspx" class="set1">Available Orders</a> <span class="tooltiptext">Create orders, orders will sit available till dispatched.</span> </div>
        / <div class="tooltip"><a href="Trucks.aspx" class="set1">Truck Address Book</a> <span class="tooltiptext">Vehicles within your Fleet.</span> </div>
        / <div class="tooltip"><a href="AvailableTrucks.aspx" class="set1">Independent Drivers</a> <span class="tooltiptext">Drivers available for hire.</span> </div>
        / <div class="tooltip"><a href="TripMonitor.aspx" class="set1">Trip Monitor</a> <span class="tooltiptext">Orders currently on route.</span> </div>
        / <div class="tooltip"><asp:LinkButton ID="btnNewWindow" OnClick="OpenWindow" runat="server" CLASS="set1">Routing Calculator</asp:LinkButton><span class="tooltiptext">Find the miles / directions / ETA between two locations.</span> </div>
        / <div class="tooltip"><a href="Billing.aspx" class="set1">Billing</a> <span class="tooltiptext">Completed orders, view and print invoices, set driver pay, archive finished orders.</span> </div>
        / <div class="tooltip"><a href="UploadPaperwork.aspx" class="set1">Upload Paperwork</a> <span class="tooltiptext">Add and review paperwork from orders that are complete.</span> </div>
        / <div class="tooltip"><a href="ReportsPage.aspx" class="set1">Reports</a> <span class="tooltiptext">Review all current and past orders.</span> </div>
        / <div class="tooltip"><a href="RatePeople.aspx" class="set1">Rating</a> <span class="tooltiptext">Rate other carriers and drivers based on past interactions.</span> </div>
        / <div class="tooltip"><a href="PostedLoads.aspx" class="set1">Posted Loads</a> <span class="tooltiptext">View loads available from other carriers.</span> </div>
        / <div class="tooltip"><a href="VehicleControlBoard.aspx" class="set1">Vehicle Control Board</a> <span class="tooltiptext">Search for loads based on current truck location.</span> </div>
        /
        <br />
        <br />


            <table>
                <tr>
                    <td>
                        <asp:ListBox ID="ListBox1" runat="server" Height="227px" Width="117px" AutoPostBack="true" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
                    </td>
                    <td>Paperwork already attached:<br />
                        <asp:Label ID="labelAttachedPaperwork" runat="server" Text="none"></asp:Label>

                        &nbsp;..
                    <asp:LinkButton ID="delete1" runat="server" Font-Italic="True" Font-Size="Small" OnClick="delete1_Click"></asp:LinkButton>

                        <br />
                        <asp:Label ID="labelAttachedPaperwork0" runat="server" Text="none"></asp:Label>

                        &nbsp;..
                    <asp:LinkButton ID="delete2" runat="server" Font-Italic="True" Font-Size="Small" OnClick="delete2_Click"></asp:LinkButton>

                        <br />
                        <asp:Label ID="labelAttachedPaperwork1" runat="server" Text="none"></asp:Label>

                        &nbsp;..
                    <asp:LinkButton ID="delete3" runat="server" Font-Italic="True" Font-Size="Small" OnClick="delete3_Click"></asp:LinkButton>

                        <br />
                        <asp:Label ID="labelAttachedPaperwork2" runat="server"></asp:Label>

                        <br />
                        <asp:Label ID="labelAttachedPaperwork3" runat="server"></asp:Label>

                        <br />
                        <asp:Label ID="labelAttachedPaperwork4" runat="server"></asp:Label>

                    </td>
                </tr>
            </table>





            <asp:FileUpload ID="FileUpload1" runat="server" Width="358px" /> <asp:Button ID="Button1" runat="server" Text="Upload File" OnClick="Button1_Click" />

            <br />
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
