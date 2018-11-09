<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Invoice.aspx.cs" Inherits="Invoice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <link rel="stylesheet" href="StyleSheet.css" type="text/css" />
     <style type="text/css">

        a.set1:link {color: rgb(80, 124, 209);}
        a.set1:active {color: rgb(80, 124, 209);}
        a.set1:visited {color: rgb(80, 124, 209);}
        


        .auto-style1 {
            width: 900px;
        }
        .auto-style2 {
            width: 148px;
        }
        .auto-style4 {
            width: 490px;
        }
        .auto-style5 {
            width: 142px;
        }
        .auto-style8 {
            width: 376px;
        }
        .auto-style9 {
            text-decoration: underline;
        }
        .auto-style10 {
            width: 310px;
        }
        .auto-style11 {
            width: 357px;
        }
        .auto-style13 {
            width: 448px;
        }
    </style>

 
</head>
<body style="padding: 12px">
    <form id="form1" runat="server">
        <div style="font-family: Verdana; font-size: 15px">
           
           
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Image ID="Image1" runat="server"/>
                    </td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtAddress" runat="server" BorderWidth="0px" Font-Size="15px" Height="126px" ReadOnly="True" TextMode="MultiLine" Width="312px" Font-Names="Verdana">address goes here</asp:TextBox>
                    </td>
                    <td align="center"><asp:Label ID="Label1" runat="server" Text="Invoice Number"></asp:Label>
                        <br />
                        <asp:Label ID="ordernumber" runat="server" Text="ordernumber"></asp:Label>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text="Post Date"></asp:Label>
                        <br />
                        <asp:Label ID="posteddate" runat="server" Text="posteddate"></asp:Label>
                    </td>
                </tr>
            </table>
           
           
            <br />
           
           

    <table class="auto-style1">
        <tr>
            <td class="auto-style4">Bill To :
                <asp:Label ID="billto" runat="server" Text="billto"></asp:Label>
                <br />
                &lt;insert address here&gt;</td>
            <td>Booked By :
                <asp:Label ID="bookedby" runat="server" Text="bookedby"></asp:Label>
                <br />
                Truck :
                <asp:Label ID="truck" runat="server" Text="truck"></asp:Label>
                <br />
                Driver :
                <asp:Label ID="driver" runat="server" Text="driver"></asp:Label>
            </td>
        </tr>
    </table>
        <br />
        <asp:Image ID="Image2" runat="server" ImageUrl="Images/line.png" />
        <br />
        <table class="auto-style1">
            <tr>
                <td class="auto-style5"><span class="auto-style9">Event</span><br />
                    Pick Up<br />
                    Drop Off</td>
                <td>
                    <br />
                    <asp:Label ID="pickuplocation" runat="server" Text="pickuplocation"></asp:Label>
                    <br />
                    <asp:Label ID="dropofflocation" runat="server"  Text="dropofflocation"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <asp:Image ID="Image3" runat="server" ImageUrl="Images/line.png" />
        <br />
        <br />
        <table class="auto-style1">
            <tr>
                <td class="auto-style10"><span class="auto-style9">Charge Type</span><br />
                    Linehaul</td>
                <td class="auto-style8">
                    <br />
                </td>
                <td class="auto-style6"><span class="auto-style9">Amount</span><br />
                    $
                    <asp:Label ID="totalcharges" runat="server" Text="totalcharges"></asp:Label>
                </td>
            </tr>
        </table>
        <table class="auto-style1">
            <tr>
                <td class="auto-style13">&nbsp;</td>
                <td>Total Charges : $
                    <asp:Label ID="totalcharges2" runat="server" Text="totalcharges"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <table class="auto-style1">
            <tr>
                <td>
                    <asp:TextBox ID="txtCandTtext" runat="server" BorderWidth="0px" Height="121px" ReadOnly="True" TextMode="MultiLine" Width="883px" Font-Size="15px" Font-Names="Verdana">T and C Text goes here</asp:TextBox>
                </td>
            </tr>
        </table>
                </div>
        <br />
        <br />
        <br />
&nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="download as pdf" Width="126px" />
        &nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="email as pdf" Width="126px" />
&nbsp;<asp:TextBox ID="txtTo" runat="server" Width="222px"></asp:TextBox>
        <br />


        <br />

/ <div class="tooltip"><a href="Billing.aspx" class="set1">Billing</a> <span class="tooltiptext">Back to the Billing page.</span> </div> &nbsp;/

    </form>
    
    </body>
</html>
