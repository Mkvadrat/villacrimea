<?php if ($options || $show_price) { ?>
<div class="container">
    <div class="row">
      <div class="col-md-12">
      <div class="panel ocfilter panel-default" id="ocfilter">
        <div class="panel-heading"><?php echo $heading_title; ?></div>
        <div class="hidden" id="ocfilter-button">
          <button class="btn btn-primary disabled " data-loading-text="<i class='fa fa-refresh fa-spin'></i> Загрузка.."></button>
        </div>
        <div class="list-group">
          <?php include 'selected_filter.tpl'; ?>
      
          <?php include 'filter_price.tpl'; ?>
      
          <?php include 'filter_list.tpl'; ?>
        </div>
      </div>
      </div>
    </div>
</div>

<script type="text/javascript"><!--
$(function() {
  $('.input-sm').mask('# ##0', {
    reverse: true,
  });
  
  $('#price-from').html('<span id="price-from"><?php echo number_format($min_price_get, 0, '', ' '); ?></span>');
  
  $('#price-to').html('<span id="price-to"><?php echo number_format($max_price_get, 0, '', ' '); ?></span>');
  
	var options = {
    mobile: $('.ocfilter-mobile').is(':visible'),
    php: {
      searchButton : <?php echo $search_button; ?>,
      showPrice    : <?php echo $show_price; ?>,
	    showCounter  : <?php echo $show_counter; ?>,
			manualPrice  : <?php echo $manual_price; ?>,
      link         : '<?php echo $link; ?>',
	    path         : '<?php echo $path; ?>',
	    params       : '<?php echo $params; ?>',
	    index        : '<?php echo $index; ?>'
	  },
    text: {
	    show_all: '<?php echo $text_show_all; ?>',
	    hide    : '<?php echo $text_hide; ?>',
	    load    : '<?php echo $text_load; ?>',
			any     : '<?php echo $text_any; ?>',
	    select  : '<?php echo $button_select; ?>'
	  }
	};

  if (options.mobile) {
    $('.ocf-offcanvas-body').html($('#ocfilter').remove().get(0).outerHTML);
  }

  $('[data-toggle="offcanvas"]').on('click', function(e) {
    $(this).toggleClass('active');
    $('body').toggleClass('modal-open');
    $('.ocfilter-mobile').toggleClass('active');
  });

  setTimeout(function() {
    $('#ocfilter').ocfilter(options);
  }, 1);
});
//--></script>
<?php } ?>