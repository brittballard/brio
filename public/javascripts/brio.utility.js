brio.utility = (function($){
  return {
    register_date_picker : function(date_pickers){
      for(var i = 0; i < date_pickers.length; i++){
        date_pickers[i].datepicker();
      }
    },
    
    set_data : function(element, data_defs){
      for(var i = 0; i < data_defs.length; i++){
        element.data(data_defs[i][0], data_defs[i][1]);
      }
    }
  }
})(jQuery);