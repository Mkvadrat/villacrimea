<?php echo $header; ?>
  <div class="category_page"><?php echo $column_left; ?>
          
    <?php echo $content_top; ?>
    
    <div class="catalog">
      <h1><?php echo $heading_title; ?></h1>
      <label for="input-search"><?php echo $entry_search; ?></label>
      <div class="row">
        <div class="col-sm-4">
          <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" />
        </div>
        <div class="col-sm-3">
        <select name="category_id">
          <option value="0"><?php echo $text_category; ?></option>
          <?php foreach ($categories as $category_1) { ?>
          <?php if ($category_1['category_id'] == $category_id) { ?>
          <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
          <?php } ?>
          <?php foreach ($category_1['children'] as $category_2) { ?>
          <?php if ($category_2['category_id'] == $category_id) { ?>
          <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
          <?php } ?>
          <?php foreach ($category_2['children'] as $category_3) { ?>
          <?php if ($category_3['category_id'] == $category_id) { ?>
          <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
          <?php } ?>
          <?php } ?>
          <?php } ?>
          <?php } ?>
        </select>
        </div>
        <div class="col-sm-3">
          <label class="checkbox-inline">
          <?php if ($sub_category) { ?>
          <input type="checkbox" name="sub_category" value="1" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="sub_category" value="1" />
          <?php } ?>
          <?php echo $text_sub_category; ?></label>
        </div>
      </div>
      <p>
      <label class="checkbox-inline">
      <?php if ($description) { ?>
      <input type="checkbox" name="description" value="1" id="description" checked="checked" />
      <?php } else { ?>
      <input type="checkbox" name="description" value="1" id="description" />
      <?php } ?>
      <?php echo $entry_description; ?></label>
      </p>
      <input type="button" value="<?php echo $button_search; ?>" id="button-search" />
    
      <?php if($products) { ?>
        <div class="sort_filter">
          <div class="change_view">
          <span>Вид:</span>
          <button class="tab_veiw active"></button>
          <button class="list_veiw"></button>
          </div>
          
          <?php echo $text_limit; ?>
          <select id="input-limit" onchange="location = this.value;">
          <?php foreach ($limits as $limits) { ?>
          <?php if ($limits['value'] == $limit) { ?>
          <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
          <?php } ?>
          <?php } ?>
          </select>
          
          <?php echo $text_sort; ?>
          <select id="input-sort" onchange="location = this.value;">
          <?php foreach ($sorts as $sorts) { ?>
          <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
          <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
          <?php } ?>
          <?php } ?>
          </select>
          
          <?php if($arrow){?>
            <span class="<?php echo $arrow; ?>">i</span>
          <?php } ?>
        </div>
        
        <div class="tabs_catalog">
          <?php foreach ($products as $product) { ?>
          <div class="catalog_item">
          <a class="img" href="<?php echo $product['href']; ?>" style="background-image: url('<?php echo $product['thumb']; ?>')"></a>
          
          <?php if($product['sticker']){ ?>
          <div class="card_label">
          <?php foreach ($product['sticker'] as $sticker) { ?>
          <span><img src="<?php echo $sticker['image']; ?>"></span>
          <?php } ?>
          </div>
          <?php } ?>
          
          <div class="bormotology">
          <a class="name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          
          <?php if($product['filter_options']){ ?>
          <div class="tags">
          <?php $i = 0; ?>
          <?php foreach($product['filter_options'] as $option){ ?>
            <span><?php echo $option['name']; ?>: <?php echo $option['value'] . $option['postfix']; ?></span>
            <?php $i++; ?>
            <?php if($i > 2) break; ?>
          <?php } ?>
          
          <div>
          <?php $i = 0; ?>
          <?php foreach($product['filter_options'] as $option){ ?>
            <p><?php echo $option['name']; ?> <span><?php echo $option['value'] . $option['postfix']; ?></span></p>
            <?php $i++; ?>
            <?php if($i > 12) break; ?>
          <?php } ?>
          </div>
          </div>
          <?php } ?>
          
          <div class="prices">
          <a href="<?php echo $product['href']; ?>" class="casual_button list_button">Подробнее</a>
            <div>
              <?php if ($product['price'] || $product['rub']) { ?>
              <?php if (!$product['special']) { ?>
              <p class="price_rub"><?php echo $product['rub']; ?></p>
              <p class="price_usd"><?php echo $product['price']; ?></p>
              <?php } else { ?>
              <p class="price_rub"><?php echo $product['special']; ?></p>
              <p class="price_usd"><sup><strike><?php echo $product['price']; ?></strike></sup></p>
              <?php } ?>
              <?php } ?>
            </div>
          </div>
          <span class="object_id">№ <?php echo $product['model']; ?></span>
          </div>
          </div>
          <?php } ?>
      </div>
      
      <?php echo $pagination; ?>
      <?php } else { ?>
        <p><?php echo $text_empty; ?></p>
      <?php } ?>
    </div>
    
    <?php echo $content_bottom; ?>
    <?php echo $column_right; ?>
  </div>
  
<script type="text/javascript"><!--
$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';

	var search = $('.catalog input[name=\'search\']').prop('value');

	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('.catalog select[name=\'category_id\']').prop('value');

	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
	}

	var sub_category = $('.catalog input[name=\'sub_category\']:checked').prop('value');

	if (sub_category) {
		url += '&sub_category=true';
	}

	var filter_description = $('.catalog input[name=\'description\']:checked').prop('value');

	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});

$('.catalog input[name=\'search\']').bind('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').prop('disabled', true);
	} else {
		$('input[name=\'sub_category\']').prop('disabled', false);
	}
});

$('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>