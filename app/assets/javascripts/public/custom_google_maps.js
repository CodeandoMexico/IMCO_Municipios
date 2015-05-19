// This function is the one that will render th gmap

var map;
var markers = [];

function initialize(markerData) {
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
  var new_marker;
  for (var i = 0; i < markerData.length; i++){
    new_point = new google.maps.LatLng(markerData[i]["lat"], markerData[i]["lng"]);
    addMarker(new_point);
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

var addMarker = function(location) {
  var marker = new google.maps.Marker({
    position: location,
    map: map
  });
  markers.push(marker);
};

var fetchPoint = function(lat, lng){
  return new google.maps.LatLng(lat, lng);
};
