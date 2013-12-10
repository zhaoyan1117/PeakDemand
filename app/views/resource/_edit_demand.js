$(document).ready(function() {

	$('.btn_edit_demand').click(function(){
		var d_i = $('.demand_intensity').text();
		var d_d = $('.demand_description').text();
		var d_sd = $('.demand_short_description').text();
		var d_st = $('.demand_start_at').text();
		var d_ed = $('.demand_end_at').text();

		$('.demand_edit_short').val(d_sd);
		$('.demand_edit_des').val(d_d);

		switch (d_i) {
			case 'LIGHT':
				$('#edit_demand_modal #demand_intensity_light').prop('checked',true);
				break;
			case 'MODERATE':
				$('#edit_demand_modal #demand_intensity_moderate').prop('checked',true);
				break;
			case 'HEAVY':
				$('#edit_demand_modal #demand_intensity_heavy').prop('checked',true);
				break;
			case 'OCCUPY':
				$('#edit_demand_modal #demand_intensity_occupy').prop('checked',true);
				break;
			default:
				break;
		}

		$('#edit_demand_modal #demand_start_at').val(d_st);
		$('#edit_demand_modal #demand_end_at').val(d_ed);

	    var url = $('#edit_demand_modal form').attr('action');
	    if (url.indexOf("demand") == -1) {
	      url = url + '/demand/' + $(".demand_short_description").data('demand_id');
	      $('#edit_demand_modal form').attr('action', url);
	    }


		$('#show_demand_modal').modal('toggle');
		$('#edit_demand_modal').modal('toggle');
	});


	$(".demand_form").submit(function(e) {

		$(this).parent().parent().parent().parent().modal('toggle');

		$('#notice_msg').text('We are updating your event...');
		$('#notice_msg').fadeIn(300);
		$('#notice_msg').delay(3000).fadeOut(300);

	    var postData = $(this).serializeArray();
	    var formURL = $(this).attr("action");
	    var formMethod = $(this).attr('method');

	    $.ajax(
	    {
	        url : formURL,
	        type: formMethod,
	        data : postData,
	        dataType : 'json',
	        success:function(data, textStatus, jqXHR) 
	        {
	        	if (data.error == [] || data.error == null) {
		        	location.reload();
	        	} else {
	        		$('#error_msg').text(data.error);
	        		$('#error_msg').fadeIn(300);
	        		$('#error_msg').delay(3000).fadeOut(300);
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown) 
	        {
        		$('#error_msg').text('Error!');
        		$('#error_msg').fadeIn(300);
        		$('#error_msg').delay(3000).fadeOut(300);
	        }
	    });
	    e.preventDefault();
	});

	 
});
