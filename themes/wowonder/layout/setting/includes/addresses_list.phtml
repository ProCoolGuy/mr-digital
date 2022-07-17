<div class="col-md-6 address_<?php echo $wo['address']->id ?>">
	<div class="address_book">
		<div class="address_book_innr">
			<div class="address_box">
				<p class="addrs_name"><?php echo $wo['address']->name ?></p>
				<p class="addrs_phone"><?php echo $wo['address']->phone; ?></p>
				<p class="addrs_street"><?php echo $wo['address']->city; ?><br><?php echo $wo['address']->country; ?></p>
				<p class="addrs_count"><?php echo $wo['address']->zip; ?></p>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<a href="javascript:void(0)" class="btn btn-info" onclick="EditAddress('<?php echo $wo['address']->id ?>')" title="<?php echo $wo['lang']['edit'] ?>">
						<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"><path fill="currentColor" d="M20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18,2.9 17.35,2.9 16.96,3.29L15.12,5.12L18.87,8.87M3,17.25V21H6.75L17.81,9.93L14.06,6.18L3,17.25Z" /></svg>
					</a>
					<a href="javascript:void(0)" class="btn btn-danger" onclick="DeleteAddress('<?php echo $wo['address']->id ?>','hide')" title="<?php echo $wo['lang']['delete'] ?>">
						<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"><path fill="currentColor" d="M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z" /></svg>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="edit_address_modal_<?php echo $wo['address']->id ?>" role="dialog" data-keyboard="false">
	<div class="modal-dialog wow_mat_mdl">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg></span></button>
				<h4 class="modal-title"><?php echo $wo['lang']['edit_address'] ?></h4>
			</div>

			<form class="form form-horizontal edit_address_form_<?php echo $wo['address']->id ?>" method="post" action="#">
				<div class="modal-body twocheckout_modal">
					<div class="modal_edit_address_modal_alert_<?php echo $wo['address']->id ?>"></div>
					<div class="clear"></div>
					<div class="row">
						<div class="col-md-12">
							<div class="wow_form_fields">
								<label for="name"><?php echo $wo['lang']['name']; ?></label>
								<input id="name" name="name" type="text" autocomplete="off" placeholder="<?php echo $wo['lang']['name']; ?>" value="<?php echo $wo['address']->name ?>">
							</div>
						</div>
						<div class="col-md-6">
							<div class="wow_form_fields">
								<label for="phone"><?php echo $wo['lang']['phone_number']; ?></label>
								<input id="phone" name="phone" type="text" autocomplete="off" placeholder="<?php echo $wo['lang']['phone_number']; ?>" value="<?php echo $wo['address']->phone ?>">
							</div>
						</div>
						<div class="col-md-6">
							<div class="wow_form_fields">
								<label for="country"><?php echo $wo['lang']['country']; ?></label>
								<input id="country" name="country" type="text" autocomplete="off" placeholder="<?php echo $wo['lang']['country']; ?>" value="<?php echo $wo['address']->country ?>">
							</div>
						</div>
						<div class="col-md-6">
							<div class="wow_form_fields">
								<label for="city"><?php echo $wo['lang']['city']; ?></label>
								<input id="city" name="city" type="text" autocomplete="off" placeholder="<?php echo $wo['lang']['city']; ?>" value="<?php echo $wo['address']->city ?>">
							</div>
						</div>
						<div class="col-md-6">
							<div class="wow_form_fields">
								<label for="zip"><?php echo $wo['lang']['zip']; ?></label>
								<input id="zip" name="zip" type="text" autocomplete="off" placeholder="<?php echo $wo['lang']['zip']; ?>" value="<?php echo $wo['address']->zip ?>">
							</div>
						</div>
						<div class="col-md-12">
							<div class="wow_form_fields">
								<label for="address"><?php echo $wo['lang']['name']; ?></label>
								<textarea placeholder="<?php echo $wo['lang']['address']; ?>" name="address" rows="3"><?php echo $wo['address']->address ?></textarea>
							</div>
						</div>
					</div>
					<input type="hidden" name="id" value="<?php echo $wo['address']->id ?>">
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
				<div class="modal-footer">
					<div class="ball-pulse"><div></div><div></div><div></div></div>
					<button type="submit" class="btn btn-main btn-mat"><?php echo $wo['lang']['edit']; ?></button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() { 
	    var options = { 
	    	url: Wo_Ajax_Requests_File() + '?f=address&s=edit&hash=' + $('.main_session').val(),
	        beforeSubmit:  function () {
	        	$('.modal_edit_address_modal_alert_<?php echo $wo['address']->id ?>').empty();
	        	$("#edit_address_modal_<?php echo $wo['address']->id ?>").find('.btn-mat').attr('disabled', 'true');
	        	$("#edit_address_modal_<?php echo $wo['address']->id ?>").find('.btn-mat').text("<?php echo($wo['lang']['please_wait']) ?>");
	        }, 
	        success: function (data) {
	        	$("#edit_address_modal_<?php echo $wo['address']->id ?>").find('.btn-mat').removeAttr('disabled')
	        	$("#edit_address_modal_<?php echo $wo['address']->id ?>").find('.btn-mat').text("<?php echo($wo['lang']['edit']) ?>");
	        	if (data.status == 200) {
	        		$('.modal_edit_address_modal_alert_<?php echo $wo['address']->id ?>').html('<div class="alert alert-success bg-success"><i class="fa fa-check"></i> '+
		            data.message
		            +'</div>');
		            if (data.url && data.url != '') {
		            	setTimeout(function () {
			            	location.href = data.url;
			            },2000);
		            }
	        	} else {
	        		$('.modal_edit_address_modal_alert_<?php echo $wo['address']->id ?>').html('<div class="alert alert-danger bg-danger"> '+
	            data.message
	            +'</div>');
	        	} 
	        }
	    }; 
	    $('.edit_address_form_<?php echo $wo['address']->id ?>').ajaxForm(options); 
	});
</script>