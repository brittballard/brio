var brio = {
  utility: {
    register_date_picker : function(ids){
      for(var index in ids){
        $('#' + ids[index]).datepicker();
      }
    },

    map: {
      initialize_map : function(lat, lng, zoom, map_canvas_id, pano_canvas_id, overlays){
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
    },
    
    pano: {
      initialize_panorama : function(canvas_id){
        return new GStreetviewPanorama(document.getElementById(canvas_id));
      },

      animate : function(lat, lng, canvas_id){
        var myPano = new GStreetviewPanorama(document.getElementById(canvas_id));
        var location = new GLatLng(lat, lng);
        myPano.setLocationAndPOV(location, myPano.getPOV());
      }
    }
  }
};