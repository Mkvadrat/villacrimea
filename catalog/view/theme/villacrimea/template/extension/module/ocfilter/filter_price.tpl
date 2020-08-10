<?php if ($show_price) { ?>
<div class="list-group-item ocfilter-option" data-toggle="popover-price">
  <div class="ocf-option-name">
		<?php echo $text_price; ?>
    <span id="price-from"><?php echo $min_price_get; ?></span>&nbsp;-&nbsp;<span id="price-to"><?php echo $max_price_get; ?></span>
    <span class="symbol_right"><?php echo $symbol_right; ?></span>
	</div>
  <div class="search-filter-block">
    <div class="search-filter-item">
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
      </div>
    </div>
    <div class="search-filter-item">
      <?php if($manual_price){ ?>
      <div class="form-inline">
        <div class="form-group summ" data-option-id="p">
          <input name="price[min]"min="1" value="<?php echo $min_price_get; ?>" type="text" class="form-control input-sm" id="min-price-value" />
        </div>
        <div class="form-group">-</div>
        <div class="form-group summ" data-option-id="p">
          <input name="price[max]"min="1" value="<?php echo $max_price_get; ?>" type="text" class="form-control input-sm" id="max-price-value" />
        </div>
      </div>
      <?php } ?>
    </div>
    <div class="search-filter-item">
      <?php if($currencys){ ?>
        <div class="list-group-item ocfilter-option currency-wraper">
          <select class="currencys btn btn-block btn-search-filter" id="currencys" name="currencys">  
            <?php foreach($currencys as $currency){ ?>
              <?php if($curent_currencys == $currency['code']){ ?>
                <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
              <?php }else{ ?>
                <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
              <?php } ?>
            <?php } ?>
          </select>
          <input type="hidden" name="path" value="<?php echo $path; ?>">
        </div>
      <?php } ?>
    </div>
  </div>
</div>

<?php } ?>