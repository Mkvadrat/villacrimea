<div class="modal-dialog modal-lg">
  <div class="modal-content">
    <div class="modal-header">
		<h4 class="modal-title"><?php echo $heading_title; ?></h4>
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -18px;">
			<i class="fa fa-times-circle-o"></i>
		</button>
    </div>
    <div class="modal-body">
		<div id="elfinder"></div>
    </div>
	<div class="modal-footer">
	</div>
  </div>
</div>

<script>
$(document).ready(function() {	
	$('#elfinder').elfinder({
		url: 'index.php?route=common/imagemanager/init&token=' + getURLVar('token'),
		width: '100%',
		resizable: false,
		dragUploadAllow: true,
		destroyOnClose: false,
		soundPath : '<?php echo $sound_path; ?>',
		commandsOptions: {
		  getfile: {
			multiple : true,
		  }
		},
		getFileCallback : function(files, fm) {
			if(count(files) > 1){
				$.each(files, function(item, file) {
					if ((file.read && file.hash)) {
						$.ajax({
							url: 'index.php?route=common/imagemanager/getTmb&thumb=' + encodeURIComponent(fm.path(file.hash)) + '&token=' + getURLVar('token'),
							method: 'POST',
							dataType: 'json',
							async: false,
							success: function(data) {	
								<?php if ($separator) { ?>
								<?php foreach ($languages as $language_id) { ?>
									parent.addImages(<?php echo $language_id['language_id']; ?>, data.thumb, data.link, item);
								<?php } ?>
								<?php }else{ ?>
									parent.addImages(data.thumb, data.link, item);
								<?php } ?>
								
								$('#modal-imagemanager').modal('hide');
							}
						});
					}
				});
			}else{	
				$.each(files, function(item, file) {
					if ((file.read && file.hash)) {
						$.ajax({
							url: 'index.php?route=common/imagemanager/getTmb&thumb=' + encodeURIComponent(fm.path(file.hash)) + '&token=' + getURLVar('token'),
							method: 'POST',
							dataType: 'json',
							success: function(data) {
								<?php if ($thumb) { ?>
									$('#<?php echo $thumb; ?>').find('img').attr('src', data.thumb);
								<?php } ?>
								<?php if ($target) { ?>
									$('#<?php echo $target; ?>').attr('value', data.link);
								<?php } ?>
								
								$('#modal-imagemanager').modal('hide');
							}
						});
					}
				});
			}
		},
		uiOptions : {
			toolbar : [
				['back', 'forward'],
				['reload'],
				['home', 'up'],
				['mkdir', 'upload'],
				['open', 'download', 'getfile'],
				['info'],
				['quicklook'],
				['copy', 'cut', 'paste'],
				['rm', 'empty'],
				['duplicate', 'rename', 'edit', 'resize'],
				['extract', 'archive'],
				['search'],
				['view', 'sort'],
				['help'],
				['fullscreen']
			]
		},
		contextmenu : {
			cwd    : ['reload', 'back', '|', 'upload', 'mkdir', 'paste', '|', 'info']
		}
	}); 
	
	function count(object) {
	  var count = 0; 
	  for(var prs in object){ 
			   if(object.hasOwnProperty(prs)) count++;
	  } 
	  return count; 
	}	
});
</script>