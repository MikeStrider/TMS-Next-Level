<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Map.aspx.cs" Inherits="Map" %>

<html>
<head>
</head>

<style type="text/css">
    #panel {
        width: 750px;
    }
</style>


<body>

    <form id="form1" runat="server">

        <div id="map" style="width: 750px; height: 400px;"></div>
        <div style="padding: 9px 0cm 0cm 0cm;">
            Enter Address A:
            <input runat="server" id="address" type="text" />
            Enter Address B:
            <input runat="server" id="address1" type="text" />
            <input id="submit" type="submit" />
            <br /> </div>
        <div style="padding: 4px 0cm 0cm 0cm;">
            Current Truck Location
            <input runat="server" id="truckaddress" type="text" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" name="type" id='bt1' value='Hide Directions' onclick="setVisibility('panel');"></div>

        <div id="panel"></div>

        <script>

            function initMap() {

                var directionsService = new google.maps.DirectionsService();
                var directionsDisplay = new google.maps.DirectionsRenderer();
                var map = new google.maps.Map(document.getElementById('map'), {
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });

                directionsDisplay.setMap(map);
                directionsDisplay.setPanel(document.getElementById('panel'));

                var address = $('#address').val();
                var address1 = $('#address1').val();
                var request = {
                    origin: address,
                    destination: address1,
                    travelMode: google.maps.DirectionsTravelMode.DRIVING
                };

                directionsService.route(request, function (response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(response);
                        distance = response.routes[0].legs[0].distance.value / 1000;
<%--                document.getElementById('<%=Label1.ClientID %>').innerHTML = distance.toFixed(1);--%>
                    }
                });

                var image = {
                    url: 'Images/truckmapicon.png',
                    origin: new google.maps.Point(0, 0), // origin
                    scaledSize: new google.maps.Size(30, 50),
                    anchor: new google.maps.Point(15, 50)
                };

                // set truck position
                var geocoder = new google.maps.Geocoder();
                var query = $('#truckaddress').val();
                var address = query;
                geocoder.geocode({ 'address': address }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var lat = results[0].geometry.location.lat();
                        var lng = results[0].geometry.location.lng();
                        var myMarker = new google.maps.LatLng(lat, lng);
                        var marker = new google.maps.Marker({
                            position: myMarker,
                            icon: image
                        });
                        marker.setMap(map);
                    }
                });

                $('#submit').click(function () {
                    var address = $('#address').val();
                    var address1 = $('#address1').val();
                });
            }

        </script>

        <script>
            function setVisibility(id) {
                if (document.getElementById('bt1').value == 'Hide Directions') {
                    document.getElementById('bt1').value = 'Show Directions';
                    document.getElementById(id).style.display = 'none';
                } else {
                    document.getElementById('bt1').value = 'Hide Directions';
                    document.getElementById(id).style.display = 'inline-block';
                }
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCAlt5n6C_0MVw8kxPSj7Kj1RGDGdiD4Nk&callback=initMap"></script>
    </form>
</body>
</html>
