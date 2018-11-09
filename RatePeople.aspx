<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RatePeople.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://antenna.io/demo/jquery-bar-rating/jquery.barrating.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <link rel="stylesheet" href="http://antenna.io/demo/jquery-bar-rating/dist/themes/fontawesome-stars.css" />
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            $('#example').barrating({
                theme: 'fontawesome-stars'
            });
        });
    </script>
    <style type="text/css">
        a.set1:link {color: rgb(80, 124, 209);}
        a.set1:active {color: rgb(80, 124, 209);}
        a.set1:visited {color: rgb(80, 124, 209);}
    </style>
</head>

<body style="padding: 12px">
    <form id="form1" runat="server">
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
        <h2>Rate Carriers and Drivers</h2>

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
                    <asp:ListBox ID="ListBox1" runat="server" Height="324px" Width="230px" AutoPostBack="true" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
                </td>
                <td>Carrier/Driver :
                        <asp:Label ID="lbl_carrierdriver" runat="server" Text="....."></asp:Label><br />
                    <br />
                    Current Rating Average :
                        <asp:Label Style="margin-left: auto; margin-right: auto; text-align: center;" ID="lbl_currentrating" runat="server" Text="....." BackColor="#507CD1" ForeColor="White" Width="60px"></asp:Label><br />
                    <br />
                    <br />
                    <table bgcolor="#507CD1">
                        <tr>
                            <td>
                                <br />
                                <center><select id="example" name="example1">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    </select>
                                    <br />
                                    <br />
                                    <asp:Button ID="Button1" runat="server" Text="Submit Comment and Rating" OnClick="Button1_Click" Width="221px" EnableViewState="False" /></center>
                                <br />
                            </td>
                            <td width="30"></td>
                            <td>
                                <asp:TextBox ID="TextBox1" runat="server" Height="87px" Width="480px" onKeyDown="limitText(this, 299);" TextMode="MultiLine" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="TextBox2" runat="server" Height="22px" Width="54px" OnTextChanged="TextBox2_TextChanged" Font-Size="Small"></asp:TextBox>
                                &nbsp;<asp:Label ID="Label1" runat="server" Text="300 char limit" Font-Size="Small"></asp:Label></td>
                            <td width="9"></td>
                        </tr>
                    </table>
                    <p>*note* - when submitting, all previous ratings and comments for this driver/carrier will be deleted and only the new comment/rating will be recorded</p>
                </td>
            </tr>
        </table>

        <script language="javascript" type="text/javascript">
            function limitText(limitField, limitNum) {
                var limitCount = document.getElementById("<%=TextBox2.ClientID%>");
                if (limitField.value.length > limitNum) {
                    limitField.value = limitField.value.substring(0, limitNum);
                } else {
                    limitCount.value = limitNum - limitField.value.length;
                }
            }
        </script>

        <p>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Width="915px">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="rating" HeaderText="Rating" SortExpression="rating">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="comments" HeaderText="Comments" SortExpression="comments" />
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
        </p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT [comments], [rating] FROM [rating] WHERE ([ratingto] = @ratingto)" OnSelecting="SqlDataSource1_Selecting">
            <SelectParameters>
                <asp:ControlParameter ControlID="lbl_carrierdriver" Name="ratingto" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
