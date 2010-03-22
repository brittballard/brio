// jQuery setup
jQuery.ajaxSetup({
  'beforeSend': function(xhr) {
          xhr.setRequestHeader("Accept", "text/javascript")
      }
})

jQuery.extend({
  delete_post: function( url, data, callback, type ) {
    // shift arguments if data argument was omited
    if ( jQuery.isFunction( data ) ) {
      type = type || callback;
      callback = data;
      data = {};
    }

    return jQuery.ajax({
      type: "DELETE",
      url: url,
      data: data,
      success: callback,
      dataType: type
    });
  }
})

jQuery.extend({
  put_post: function( url, data, callback, type ) {
    // shift arguments if data argument was omited
    if ( jQuery.isFunction( data ) ) {
      type = type || callback;
      callback = data;
      data = {};
    }

    return jQuery.ajax({
      type: "PUT",
      url: url,
      data: data,
      success: callback,
      dataType: type
    });
  }
})

// namespaces
var brio = {}
brio.utility = {}
brio.utility.map = {}
brio.utility.pano = {}

brio.utility.register_date_picker = function(ids){
  for(var index in ids){
    $('#' + ids[index]).datepicker();
  }
}

brio.utility.map.initialize_map = function(lat, lng, zoom, map_canvas_id, pano_canvas_id, overlays){
  if (GBrowserIsCompatible()) {
    var map = new GMap2(document.getElementById(map_canvas_id));
    map.setCenter(new GLatLng(lat, lng), zoom);
    map.setUIToDefault();

    if(overlays != null && overlays.length > 0){
      for(var i = 0; i < overlays.length; i++){
        map.addOverlay(overlays[i]);
      }
    }
    
    if(pano_canvas_id != null){
      var pano = brio.utility.pano.initialize_panorama(pano_canvas_id);
      
      GEvent.addListener(map,"click", function(overlay, latlng) {
        pano.setLocationAndPOV(latlng);
      });
    }
  }
}

brio.utility.pano.initialize_panorama = function(canvas_id){
  return new GStreetviewPanorama(document.getElementById(canvas_id));
}

brio.utility.pano.animate = function(lat, lng, canvas_id){
  var myPano = new GStreetviewPanorama(document.getElementById(canvas_id));
  var location = new GLatLng(lat, lng);
  myPano.setLocationAndPOV(location, myPano.getPOV());
}