var brio = (function($){
  return {
    utility: {
      register_date_picker : function(date_pickers){
        for(var i = 0; i < date_pickers.length; i++){
          date_pickers[i].datepicker();
        }
      },
      
      set_data : function(element, data_defs){
        for(var i = 0; i < data_defs.length; i++){
          element.data(data_defs[i][0], data_defs[i][1]);
        }
      },

      map: {
        initialize_map : function(map, lat_lng, zoom){
            map.setCenter(lat_lng, zoom);
            map.setUIToDefault();

          return map;
        },
        
        add_overlays : function(map, overlays){
          for(var i = 0; i < overlays.length; i++){
            map.addOverlay(overlays[i]);
          }
        },
        
        save_lat_lng_data_point : function(latlng){
          $.post($(this).data("app_info").new_step_path, {"step[recipe_id]":$(this).data("app_info").recipe_id}, null, "script");
          return false;
        }
      },

      pano: {
        initialize_pano : function(map, pano, gEvent){
          gEvent.addListener(map, "click", function(overlay, latlng) {
            pano.setLocationAndPOV(latlng);
          });
          
          return pano;
        },
        
        animate : function(lat_lng, pano){
          pano.setLocationAndPOV(lat_lng, pano.getPOV());
        }
      }
    }
  }
})(jQuery);