<?php if ($show_price) { ?>
<div class="list-group-item ocfilter-option" data-toggle="popover-price">
  <div id="sdsad" class="ocf-option-name">
		<?php echo $text_price; ?>
    <span id="price-from"><?php echo $min_price_get; ?></span>&nbsp;-&nbsp;<span id="price-to"><?php echo $max_price_get; ?></span>
    <span class="symbol_right"><?php echo $symbol_right; ?></span>
	</div>

  <div class="ocf-option-values">
		<div id="scale-price" class="scale ocf-target"
      data-option-id="p"
      data-start-min="<?php echo $min_price_get; ?>"
      data-start-max="<?php echo $max_price_get; ?>"
      data-range-min="<?php echo $min_price; ?>"
      data-range-max="<?php echo $max_price; ?>"
      data-element-min="#price-from"
      data-element-max="#price-to"
      data-control-min="#min-price-value"
      data-control-max="#max-price-value"
    ></div>
    <br>
    <?php if($currencys){ ?>
    <select class="currencys" id="currencys" name="currencys">	
      <?php foreach($currencys as $currency){ ?>
        <?php if($curent_currencys == $currency['code']){ ?>
          <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
        <?php }else{ ?>
          <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
        <?php } ?>
      <?php } ?>
    </select>
    <?php } ?>
  </div>
</div>
<?php } ?>