var brio = (function(){
  return {
    utility: {
      register_date_picker : function(date_pickers){
        for(var i = 0; i < date_pickers.length; i++){
          date_pickers[i].datepicker();
        }
      },
      
      set_data : function(id, data_defs){
        var dom_object = document.getElementById(id);
      
        for(var i = 0; i < data_defs.length; i++){
          $(dom_object).data(data_defs[i][0], data_defs[i][1]);
        }
      },

      map: {
        initialize_map : function(lat, lng, zoom, map_canvas_id, pano_canvas_id, overlays){
          if (GBrowserIsCompatible()) {
            var map_div = document.getElementById(map_canvas_id);
            var map = new GMap2(map_div);
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
        },
      
        save_lat_lng_data_point : function(latlng){
          $.post($(this).data("app_info").new_step_path, {"step[recipe_id]":$(this).data("app_info").recipe_id}, null, "script");
          return false;
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
  }
})();