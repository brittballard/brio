brio.utility.map = (function($){
  return {
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
  }
})(jQuery);