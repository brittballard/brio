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

function register_date_picker(ids){
	for(var index in ids){
		$('#' + ids[index]).datepicker();
	}
}

// end utility methods