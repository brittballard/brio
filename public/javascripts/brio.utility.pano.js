brio.utility.pano = (function($){
  return {
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
})(jQuery);