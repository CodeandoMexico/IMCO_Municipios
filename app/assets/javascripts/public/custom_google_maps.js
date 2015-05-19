var map;
var markers = [];

// This function is the one that will render th gmap
function initialize(markersData) {
  // get center point
  var centerPoint = fetchPoint(22.1498200, -100.9791600);

  // paint a map into the view
  var mapOptions = {
    zoom: 4,
    center: centerPoint,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('gmap'), mapOptions);

  // load all marker into the array from locations
  var new_point;
  var infoWindow;
  for (var i = 0; i < markersData.length; i++){
    new_point = new google.maps.LatLng(markersData[i]["latitude"], markersData[i]["longitude"]);
    infoWindow = fetchInfoWindow(markersData[i]);
    addMarker(new_point, infoWindow);
  }

  // lets check if toogle checkbox is checked
  toogleMap();
}

// If the show hide maps checkbox is checked then show, else hide.
var toogleMap = function(){
  var toogle = $('#map-toogle')[0].checked;

  if(toogle){
    setAllMap(map);
  } else{
    clearMarkers();
  }
};

// Sets the map on all markers in the array.
var setAllMap = function(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
};

// Removes the markers from the map, but keeps them in the array.
var clearMarkers = function() {
  setAllMap(null);
};

var addMarker = function(location, infoWindow) {
  var marker = new google.maps.Marker({
    position: location,
    map: map
  });
  // add a listener to pop up a infowindow on the marker
  google.maps.event.addListener(marker, 'click', function() {
    infoWindow.open(map, marker);
  });

  // save it on a marker array.
  markers.push(marker);
};

var fetchPoint = function(lat, lng){
  return new google.maps.LatLng(lat, lng);
};

var fetchInfoWindow = function(markerData){
  var name = markerData["name"];
  var address = markerData["address"];
  var schedule = markerData["schedule"];
  var phone = markerData["phone"];

  var contentString = '<div id="content">'+
        '<div id="siteNotice">' +
        '</div>' +
        '<h1 id="firstHeading" class="firstHeading">' + name +'</h1>' +
        '<div id="bodyContent">' +
        '<ul>' +
        '<li>' + name + '</li>' +
        '<li>' + address + '</li>' +
        '<li>' + schedule + '</li>' +
        '<li>' + phone + '</li>' +
        '</ul>' +
        '</div>' +
        '</div>';
  return new google.maps.InfoWindow({
     content: contentString
   });
};
