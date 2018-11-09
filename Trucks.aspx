<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Trucks.aspx.cs" Inherits="Trucks" %>

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
        <h2 style="padding-bottom: 4px">Truck Address Book</h2>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="name"
            DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
            ShowFooter="True" OnRowDataBound="GridView1_RowDataBound">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Truck" SortExpression="name">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("name") %>' ForeColor="White"></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtName" runat="server" Width="100%"></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Truck Type" SortExpression="trucktype">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("trucktype") %>'>
                            <asp:ListItem>Select Truck Type</asp:ListItem>
                            <asp:ListItem>Cargo Van</asp:ListItem>
                            <asp:ListItem>Straight Truck</asp:ListItem>
                            <asp:ListItem>Tractor</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("trucktype") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="100%">
                            <asp:ListItem>Select Truck Type</asp:ListItem>
                            <asp:ListItem>Cargo Van</asp:ListItem>
                            <asp:ListItem>Straight Truck</asp:ListItem>
                            <asp:ListItem>Tractor</asp:ListItem>
                        </asp:DropDownList>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Licences Plate" SortExpression="licencesplate">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("licencesplate") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("licencesplate") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtplate" runat="server" Width="100%"></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date Acquired" SortExpression="dateacquired">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("dateacquired", "{0:d}") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("dateacquired", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtacquired" runat="server" Width="100%"></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Position" SortExpression="lastposition">
                    <EditItemTemplate>
                        <asp:HyperLink ID="HyperLink3" runat="server" Text='<%# Eval("lastposition") %>' ForeColor="White"></asp:HyperLink>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink3" runat="server" Text='<%# Bind("lastposition") %>' NavigateUrl='<%# Eval("name", "~/PositionHistory.aspx?name={0}")  %>'></asp:HyperLink>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:LinkButton ID="LBInsert" runat="server" OnClick="lbInsert_Click" ForeColor="White">Insert New Truck</asp:LinkButton>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Date &amp; Time" SortExpression="lastdateandtime">
                    <EditItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("lastdateandtime") %>' ForeColor="White"></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("lastdateandtime", "{0:MM/dd/yyyy HH:mm:ss}") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" ForeColor="White" Text="update" OnClick="LinkButton1_Click1"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="White" CommandName="Cancel" Text="cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="edit"></asp:LinkButton>
                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
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

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            DeleteCommand="DELETE FROM [Trucks] WHERE [name] = @name"
            InsertCommand="INSERT INTO [Trucks] ([name], [dateacquired], [licencesplate], [trucktype], [compid], [searching]) VALUES (@name, @dateacquired, @licencesplate, @trucktype, @compid, '0')"
            SelectCommand="SELECT DISTINCT Trucks.name, Trucks.dateacquired, Trucks.licencesplate, Trucks.trucktype, TruckLatest.lastposition, TruckLatest.lastdateandtime, TruckLatest.compid
FROM            Trucks INNER JOIN
                             (SELECT DISTINCT name, lastposition, lastdateandtime, compid
                               FROM            Truck002 AS Truck1
                               WHERE        (lastdateandtime =
                                                             (SELECT        MAX(lastdateandtime) AS Expr1
                                                               FROM            Truck002 AS Truck2
                                                               WHERE        (name = Truck1.name) AND (compid = Truck1.compid)))) AS TruckLatest ON Trucks.name = TruckLatest.name AND Trucks.compid = TruckLatest.compid
WHERE        (Trucks.compid = @compid)
ORDER BY Trucks.trucktype, Trucks.name"
            UpdateCommand="UPDATE [Trucks] SET [dateacquired] = @dateacquired, [licencesplate] = @licencesplate, [trucktype] = @trucktype WHERE [name] = @name">
            <DeleteParameters>
                <asp:Parameter Name="name" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter DbType="Date" Name="dateacquired" />
                <asp:Parameter Name="licencesplate" Type="String" />
                <asp:Parameter Name="trucktype" Type="String" />
                <asp:Parameter Name="lastposition" Type="String" />
                <asp:Parameter Name="lastdateandtime" Type="DateTime" />
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter DbType="Date" Name="dateacquired" />
                <asp:Parameter Name="licencesplate" Type="String" />
                <asp:Parameter Name="trucktype" Type="String" />
                <asp:Parameter Name="lastposition" Type="String" />
                <asp:Parameter Name="lastdateandtime" Type="DateTime" />
                <asp:Parameter Name="name" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <br />
    </div>

    <div>
        <table>
            <tr>
                <td>
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Show Available Loads" AutoPostBack="true" />
                    <br />
                    <asp:CheckBox ID="CheckBox2" runat="server" Text="Use Small Icons" AutoPostBack="true" />
                    <br />
                    <asp:CheckBox ID="CheckBox3" runat="server" Text="Use Clustering on Truck Locations" AutoPostBack="true" OnCheckedChanged="CheckBox3_CheckedChanged" />
                </td>
                <td width="40px"></td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Launch Map Full Screen" OnClick="Button1_Click" />
                </td>
                <td width="7px"></td>
                <td>set height:
                        <asp:TextBox ID="txtSetHeight" runat="server"></asp:TextBox><br />
                    (ex: 1100px) *note* use F11 to remove browsers address bar and title
                </td>
<%--                <td>
                    <table>
                        <tr><td><asp:Button ID="Button3" runat="server" Text="Delete Cookie" OnClientClick="compare()" /></td>
                        </tr><tr><td><asp:Button ID="Button2" runat="server" Text="Run GeoCoding" OnClientClick="compare2();" />
                        </td></tr><tr><td><asp:Button ID="Button4" runat="server" Text="Show Cookie" OnClientClick="showCookie()" /></td>
                        </tr>
                    </table>
                </td>--%>
            </tr>
        </table>

    </div>

    <div id="map" runat="server" style="width: 1191px; height: 400px;">
    </div>
    <br />
    <div>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="pickuplocation" HeaderText="pickuplocation" SortExpression="pickuplocation" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT [pickuplocation], [id] FROM [orders] WHERE ([status] = @status) and ([compid] = @compid)">
            <SelectParameters>
                <asp:Parameter DefaultValue="available" Name="status" Type="String" />
                <asp:ControlParameter ControlID="lblcompid" DefaultValue="" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <script>

        function compare() {

            document.cookie = "locations=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            alert("Cookie Deleted");
            alert(document.cookie);
        }

        function compare2() {

            var adrsLength = [];
            var truckName = [];
            var orderid = [];
            var pickup = [];
            var markers = [];
            var addr = [];
            var locations2 = [];

            var Grid_Table = document.getElementById('<%= GridView1.ClientID %>');
            for (var row = 1; row < Grid_Table.rows.length - 1; row++) {
                truckName.push(Grid_Table.rows[row].cells[0].textContent.trim());
                adrsLength.push(Grid_Table.rows[row].cells[4].textContent.trim());
            }
            for (var i = 0, num = adrsLength.length; i < num; i++) {
                if (adrsLength[i] != "plz select a truck") {
                    setInfoWindow(i);
                }
            }

            function setInfoWindow(i) {
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': adrsLength[i] }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var ylat = results[0].geometry.location.lat();
                        var ylng = results[0].geometry.location.lng();
                        locations2.push({ lat: ylat, lng: ylng, addres: adrsLength[i].trim(), geoAddress: results[0].formatted_address, truckName: truckName[i].trim() });
                        document.cookie = "locations=" + JSON.stringify(locations2);
                    }
                });
            }

            // document.cookie = "locations=" + JSON.stringify(locations2);
            // alert("complete" + locations2);
            // alert(document.cookie);
        }

        function getCookie(name) {
            var re = new RegExp(name + "=([^;]+)");
            var value = re.exec(document.cookie);
            return (value != null) ? unescape(value[1]) : null;
        }

        function showCookie(name) {
            alert(document.cookie);
        }


        function initMap() {                   // THE MAP LOADS

            var geocoder = new google.maps.Geocoder();

            var myCenter = new google.maps.LatLng(39.50, -98.35);
            var mapCanvas = document.getElementById("map");
            var mapOptions = {
                center: myCenter,
                zoom: 4
            };

            var map = new google.maps.Map(mapCanvas, mapOptions);

            var adrsLength = [];
            var truckName = [];
            var orderid = [];
            var pickup = [];
            var markers = [];
            var addr = [];

            var locations = getCookie("locations");
            var stringObj = JSON.parse(locations);

            // CHECKBOX 1 -- Show Available Loads
            if (document.getElementById("CheckBox1").checked == true) {
                var Grid_Table2 = document.getElementById('<%= GridView2.ClientID %>');
                for (var row = 1; row < Grid_Table2.rows.length; row++) {
                    orderid.push(Grid_Table2.rows[row].cells[0].textContent);
                    pickup.push(Grid_Table2.rows[row].cells[1].textContent);
                }
                for (var x = 0, num = orderid.length; x < num; x++) {
                    setInfoWindow2(x)
                }
            }

            function setInfoWindow2(i) {
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': pickup[i] }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var lat = results[0].geometry.location.lat();
                        var lng = results[0].geometry.location.lng();
                        var myMarker = new google.maps.LatLng(lat, lng);
                        var mark = new google.maps.Marker({
                            position: myMarker,
                            map: map,
                            icon: image2
                        });
                        google.maps.event.addListener(mark, 'click', function (event) {
                            var iwindow = new google.maps.InfoWindow({
                                content: orderid[i] + " : " + pickup[i]
                            });
                            iwindow.open(map, this);
                        });
                    }
                });
            }

            // CHECKBOX2
            if (document.getElementById("CheckBox2").checked == true) {
                var image = {
                    url: 'Images/mapiconTRUCK.png',
                };
                var image2 = {
                    url: 'Images/mapiconLOADS.png',
                };
            }
            else {
                var image = {
                    url: 'Images/truckmapicon.png',
                    scaledSize: new google.maps.Size(30, 50),
                    anchor: new google.maps.Point(15, 50)
                };
                var image2 = {
                    url: 'Images/packagemapicon.png',
                    scaledSize: new google.maps.Size(30, 50),
                    anchor: new google.maps.Point(15, 50)
                };
            }

            // CHECKBOX 3 - TRY TO DO CLUSTERING
            if (document.getElementById("CheckBox3").checked == true) {
                compare2();
                if (stringObj == null) {
                    alert("Geocoding in Process, this page will now reload.");
                    setTimeout(function () {
                        location.reload();
                    }, 1000);
                } else {
                    markers = stringObj.map(function (location) {
                        var marker = new google.maps.Marker({
                            position: location,
                            map: map,
                            icon: image,
                        });

                        google.maps.event.addListener(marker, 'click', function (event) {
                            var iwindow = new google.maps.InfoWindow({
                                content: location.truckName + " : " + location.addres
                            });
                            iwindow.open(map, this);
                        });
                        return marker;
                    });
                }

                markerCluster = new MarkerClusterer(map, markers, {
                    imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
                });
            }

            // NO CLUSTERING
            else {
                var Grid_Table = document.getElementById('<%= GridView1.ClientID %>');
                for (var row = 1; row < Grid_Table.rows.length - 1; row++) {
                    truckName.push(Grid_Table.rows[row].cells[0].textContent);
                    adrsLength.push(Grid_Table.rows[row].cells[4].textContent);
                }
                for (var i = 0, num = adrsLength.length; i < num; i++) {
                    if (adrsLength[i] != "\n                        plz select a truck\n                    ") {
                        setInfoWindow(i);
                    }
                }
            }


            function setInfoWindow(i) {
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': adrsLength[i] }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var lat = results[0].geometry.location.lat();
                        var lng = results[0].geometry.location.lng();
                        var myMarker = new google.maps.LatLng(lat, lng);
                        var mark = new google.maps.Marker({
                            position: myMarker,
                            map: map,
                            icon: image
                        });
                        addr.push(adrsLength[i]);
                        google.maps.event.addListener(mark, 'click', function (event) {
                            var iwindow = new google.maps.InfoWindow({
                                content: truckName[i] + " : " + adrsLength[i]
                            });
                            iwindow.open(map, this);
                        });
                    }
                });
            }
            // alert(document.cookie);
            // document.cookie = locations;
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCAlt5n6C_0MVw8kxPSj7Kj1RGDGdiD4Nk&callback=initMap"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script>
        $(function () {
            $("#nav-placeholder").load("navpage.html");
        });
    </script>

    <br />
    <br />
    <br />
    </form>
        <br />
    <br />
    <br />
    <br />
</body>
</html>
