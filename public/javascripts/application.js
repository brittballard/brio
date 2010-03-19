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
brio.jQueryInit = {}

brio.utility.register_date_picker = function(ids){
  for(var index in ids){
    $('#' + ids[index]).datepicker();
  }
}

brio.utility.initialize_map = function(lat, lng, canvas_id){
  var latlng = new google.maps.LatLng(lat, lng);
  var myOptions = {
    zoom: 8,
    center: latlng
  };
  
  var map = new Map(document.getElementById(canvas_id), myOptions);
}

brio.utility.initialize_panorama = function(lat, lng, canvas_id){
  var streetView = new google.maps.LatLng(lat, lng);
  panoramaOptions = { latlng:streetView };
  var myPano = new GStreetviewPanorama(document.getElementById(canvas_id), panoramaOptions);
}

brio.utility.animate = function(lat, lng, canvas_id){
  var myPano = new GStreetviewPanorama(document.getElementById(canvas_id));
  var location = new GLatLng(lat, lng);
  myPano.setLocationAndPOV(location, myPano.getPOV());
}

brio.jQueryInit.initialize_panorama_view = function(){
  $('#start_button').click(function(){
    brio.utility.animate(32.78502,-96.801589, 'map_canvas');
    return false;
  })
}
