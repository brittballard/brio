// utility methods

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

var brio = {}

brio.register_date_picker = function(ids){
  for(var index in ids){
    $('#' + ids[index]).datepicker();
  }
}

brio.initialize_map = function(lat, lng, canvas_id){
  var latlng = new google.maps.LatLng(lat, lng);
  var myOptions = {
    zoom: 8,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById(canvas_id), myOptions);
}