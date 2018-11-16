<?php echo $header; ?>
  <div class="category_page"><?php echo $column_left; ?>
      
       <?php echo $content_top; ?>
      
      <?php if ($top_name || $description) { ?>
        <!-- <p class="title"><?php echo $top_name; ?></p> -->
        <?php echo $description; ?>
      <?php } ?>
  
      <?php if($products) { ?>
      <div class="catalog">
          <div class="sort_filter">
              <div class="change_view">
                  <span>Вид:</span>
                  <button class="tab_veiw active"></button>
                  <button class="list_veiw"></button>
              </div>
              <div class="show-up-to">
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
              </div>
              <div class="sort-up-to">
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
              </div>
              <!-- <span class="<?php echo $arrow; ?>">i</span> -->
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
                              <span><?php echo $option['name']; ?>: <?php echo $option['value'] . $option['postfix']; ?> /</span>
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
                      <span class="object_id">Обьект № <?php echo $product['model']; ?></span>
                  </div>
              </div>
            <?php } ?>
          </div>
          
          <?php echo $pagination; ?> <p class="center"><?php echo $results; ?></p>
      </div>
      <?php }else{ ?>
      <div class="have-no-items">
        <p><?php echo $text_empty; ?></p>
        <div class="buttons">
            <a href="<?php echo $continue; ?>" class="btn btn-primary" style="margin: 0 0 10px;"><?php echo $button_continue; ?></a>
        </div>
      </div>
      <?php } ?>
      
      <?php if ($categories) { ?>
      <div class="realtor_category">
        <?php foreach ($categories as $category) { ?>
          <div class="realtor_item">
              <a href="<?php echo $category['href']; ?>" class="realtor">
                  <div class="img" style="background-image: url('<?php echo $category['image']; ?>')"></div>
                  <div>
                    <p class="name"><?php echo $category['name']; ?></p>
                    <p class="job"><?php echo $category['specialization']; ?></p>
                    <p class="obj_count">Объектов в продаже –
                        <span><?php echo $category['count']; ?></span>
                    </p>
                  </div>
              </a>
              <?php //if ($category['view_case']) { ?>
                <a href="<?php echo $category['href']; ?>" class="watch_cases">Посмотреть объекты агента</a>
                <!-- <a href="<?php /*echo $category['view_case'];*/ ?>" class="watch_cases">Посмотреть кейсы агента</a> -->
              <?php //} ?>
          </div>
        <?php } ?>
      </div>
      <?php } ?>
      
      <div class="seotext">
          <div class="agent">
              <div class="img" style="background-image: url('/image/catalog/persons/elenacopy.png');"></div>
              <p class="name">Коцеблюк Елена</p>
              <p>Решили купить недвижимость в Крыму?<br>
Сделайте заявку на подбор недвижимости в Крыму прямо сейчас и получите сопровождение сделки в подарок.</p>
              <a class="casual_button callback" href="#order_selection">Заказать подбор</a>
          </div>
          <div class="text">
              <h1 class="title"><?php echo $heading_title; ?></h1>
              
              <?php if ($bottom_description) { ?>
                <?php echo $bottom_description; ?>
              <?php } ?>
          </div>
      </div>
      
      <?php if($cases){ ?>
      <div class="case_with">
        <?php foreach($cases as $case){ ?>
          <p class="title"><?php echo $case_name; ?></p>
          <div>
              <div class="case">
                  <p class="title"><?php echo $case['name']; ?></p>
                  <?php echo $case['description']; ?>
                  <a href="<?php echo $case['href']; ?>" class="casual_button">Подробнее об этом кейсе</a>
              </div>
              <div class="realtor">
                  <div class="img" style="background-image: url('<?php echo $case['image_agent']; ?>')"></div>
                  <p><?php echo $case['category_name']; ?></p>
              </div>
              <div class="description">
                  <div class="img" style="background-image: url('<?php echo $case['image']; ?>')"></div>
                  <?php echo $case['short_description']; ?>
              </div>
          </div>
        <?php } ?>
        <a href="<?php echo $view_all_cases; ?>" class="watch_cases">Смотреть все кейсы</a>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?>
    <?php echo $column_right; ?>
  </div>
<?php echo $footer; ?>
