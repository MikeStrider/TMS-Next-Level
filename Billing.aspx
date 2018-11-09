<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Billing.aspx.cs" Inherits="Billing" %>

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

        .auto-style1 {
            text-decoration: underline;
        }

        a.set1:link {
            color: rgb(80, 124, 209);
        }

        a.set1:active {
            color: rgb(80, 124, 209);
        }

        a.set1:visited {
            color: rgb(80, 124, 209);
        }

    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div style="padding: 12px">

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
            <h2 style="padding-bottom: 4px">Billing</h2>

            <asp:GridView ID="GridView1" OnRowDataBound="GridView1_RowDataBound" runat="server" AutoGenerateColumns="False" DataKeyNames="ordernumber"
                DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" />
                <Columns>

                    <asp:TemplateField HeaderText="Order Number" SortExpression="ordernumber">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ordernumber") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ordernumber") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" ForeColor="White" Text="update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" ForeColor="White" Text="cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="edit"></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="billto" HeaderText="Bill To Customer" SortExpression="billto">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="totalcharges" HeaderText="Total Charges" SortExpression="totalcharges">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="posted" SortExpression="tcposted">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Bind("tcposted") %>' NavigateUrl='<%# Eval("ordernumber", "~/Billing.aspx?id={0}")  %>'></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="paid" SortExpression="paid">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Bind("paid") %>' NavigateUrl='<%# Eval("ordernumber", "~/Billing.aspx?idpaid={0}")  %>'></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="driverpay" HeaderText="Driver Pay" SortExpression="driverpay">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="posted" SortExpression="dpposted">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink3" runat="server" Text='<%# Bind("dpposted") %>' NavigateUrl='<%# Eval("ordernumber", "~/Billing.aspx?iddp={0}")  %>'></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Paperwork" SortExpression="paperwork">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink4" runat="server" Text='<%# Bind("paperwork") %>' NavigateUrl='<%# Eval("ordernumber", "~/UploadPaperwork.aspx?idpaper={0}")  %>'></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="invoice" SortExpression="tcposted">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink5654" runat="server" Text='view invoice' NavigateUrl='<%# Eval("ordernumber", "~/invoice.aspx?id={0}")  %>'></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:TemplateField>

                </Columns>
                <EditRowStyle BackColor="#2461BF" ForeColor="White" />
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
            <table>
                <tr>
                    <td valign="top">
                        <input type="button" name="type" id='bt1' value='Show Billing Help' onclick="setVisibility('billingprocess');" /></td>
                    <td>
                        <p id="billingprocess" style="display: none">
                            <span class="auto-style1"><b>The Billing Process</b></span><br />
                            Invoice Posted - set to Y meaning the invoice has been sent or mailed to the customer<br />
                            Invoice Paid - set to Y meaning the funds have been receieved from the customer<br />
                            Driver Posted - set to Y meaning pay cheques have been sent out<br />
                            Create Batch File - all posted and paid invoices will be removed from view and gathered into a flat file
                        </p>
                    </td>
                </tr>
            </table>
            <table bgcolor="C4DEED">
                <tr>
                    <td valign="top">Invoice: Upload Logo
                    <br />
                        <asp:FileUpload ID="FileUpload1" Style="margin-top: 5px" runat="server" />
                        <br />
                        <asp:Button ID="Button2" Style="margin-top: 5px" runat="server" Text="Submit Logo Upload" Width="164px" OnClick="Button2_Click" />
                        <br />
                        <br />
                        <asp:Button ID="Button3" runat="server" Text="Submit T & C Text and Company Address" Width="289px" OnClick="Button3_Click" />
                    </td>
                    <td></td>
                    <td valign="top">Invoice: Enter Our Companys Address
                    <br />
                        <asp:TextBox ID="txtAddress" class="form-control" runat="server" TextMode="MultiLine" Height="118px"></asp:TextBox>
                    </td>
                    <td></td>
                    <td valign="top">Invoice: Footer Terms & Conditions
                    <br />
                        <asp:TextBox ID="txtFooter" class="form-control" runat="server" TextMode="MultiLine" Height="118px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            Generate File for Accounting Package
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Create Batch File" />
            &nbsp;<asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label>
            &nbsp;. <a href="BatchFilesPage.aspx">View All Batch Files</a><br />
            <br />

            <br />
            <br />
            <br />

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
                SelectCommand="SELECT Billing.ordernumber, Billing.billto, Billing.totalcharges, Billing.tcposted, Billing.paid, Billing.driverpay, Billing.dpposted, Billing.paperwork, orders.status FROM Billing FULL OUTER JOIN orders ON Billing.ordernumber = orders.id WHERE (orders.status = 'complete') AND (orders.compid = @compid) OR (orders.status = 'posted') AND (orders.compid = @compid)"
                DeleteCommand="DELETE FROM [Billing] WHERE [ordernumber] = @ordernumber"
                InsertCommand="INSERT INTO [Billing] ([ordernumber], [billto], [totalcharges], [tcposted], [paid], [driverpay], [dpposted], [paperwork]) VALUES (@ordernumber, @billto, @totalcharges, @tcposted, @paid, @driverpay, @dpposted, @paperwork)"
                UpdateCommand="UPDATE [Billing] SET [billto] = @billto, [totalcharges] = @totalcharges, [driverpay] = @driverpay WHERE [ordernumber] = @ordernumber" OnSelecting="SqlDataSource1_Selecting">
                <DeleteParameters>
                    <asp:Parameter Name="ordernumber" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ordernumber" Type="Int32" />
                    <asp:Parameter Name="billto" Type="String" />
                    <asp:Parameter Name="totalcharges" Type="Decimal" />
                    <asp:Parameter Name="tcposted" Type="String" />
                    <asp:Parameter Name="paid" Type="String" />
                    <asp:Parameter Name="driverpay" Type="Decimal" />
                    <asp:Parameter Name="dpposted" Type="String" />
                    <asp:Parameter Name="paperwork" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="billto" Type="String" />
                    <asp:Parameter Name="totalcharges" Type="Decimal" />
                    <asp:Parameter Name="driverpay" Type="Decimal" />
                    <asp:Parameter Name="ordernumber" Type="Int32" />
                </UpdateParameters>
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
        function setVisibility(id) {
            if (document.getElementById('bt1').value == 'Hide Billing Help') {
                document.getElementById('bt1').value = 'Show Billing Help';
                document.getElementById(id).style.display = 'none';
            } else {
                document.getElementById('bt1').value = 'Hide Billing Help';
                document.getElementById(id).style.display = 'inline-block';
            }
        }
    </script>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    / <a href="testing.aspx">Admin Functions</a> /
</body>
</html>
