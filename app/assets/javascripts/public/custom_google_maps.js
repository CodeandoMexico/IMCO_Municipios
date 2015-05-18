// This function is the one that will render th gmap

var loadGoogleMaps = function(markerData){
  var handler = Gmaps.build('Google');
  handler.buildMap({ internal: {id: 'gmap'}}, function(){
    var markers = handler.addMarkers(markerData);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
};
