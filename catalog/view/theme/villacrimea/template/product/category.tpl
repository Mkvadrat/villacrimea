<?php echo $header; ?>
  <div class="category_page"><?php echo $column_left; ?>
      
      <?php echo $content_top; ?>
       
      <?php if($newbuilding){ ?>     
        <?php if ($top_name || $description) { ?>
          <div class="object_page" style="padding:40px 0 0;">
              <div class="actual_object">
                  <h1 class="title" style="padding: 0 0 35px;margin: 0 auto;width: 100%;"><?php echo $heading_title; ?></h1>
                  <div class="left_side">
                      <div class="object_photo">
                          <?php if ($popup || $newbuildings_img) { ?>
                          <?php if ($popup) { ?>
                          <div class="custom_product_photo_slider">
                            <button class="prev_slide"></button>
                            <a href="<?php echo $popup; ?>" data-fancybox="gallery" class="main_photo">
                                <img src='<?php echo $popup; ?>'>
                            </a>
                            <button class="next_slide"></button>
                          </div>
                          <?php } ?>
                          <?php if ($newbuildings_img) { ?>
                          <?php foreach ($newbuildings_img as $image) { ?>
                          <a href="<?php echo $image['popup']; ?>" data-fancybox="gallery">
                            <img src="<?php echo $image['thumb']; ?>">
                          </a>
                          <?php } ?>
                          <?php } ?>
                        <?php } ?>
                      </div>
                      <?php if ($smallblocks) { ?>
                      <?php foreach ($smallblocks as $smallblock) { ?>
                        <div class="details mobile">
                          <?php echo $smallblock['text']; ?>
                        </div>
                      <?php } ?>
                      <?php } ?>
                      <div class="object_description spec_object_description">
                          <?php echo $category_spec; ?>
                      </div>
                      <div class="object_description">
                        <?php echo $description; ?>
                      </div>
                      <div class="realtor mobile">
                          <p class="tel">Телефон: <a href="«tel:88006000019&quot;">8 800 600 00 19</a></p>
                          <p class="tel">E-mail: <a href="mailto:villa-crimea@mail.ru">villa-crimea@mail.ru</a></p>
                          <a href="#callback_agent" class="casual_button callback">Написать сообщение</a>
                      </div>
                  </div>
                  <div class="right_side">
                      <?php if($category_downloads){ ?>
                     <div class="link-demo">
                        <?php foreach ($category_downloads as $download) { ?> 
                      <a href="<?php echo $download['href']; ?>"><span><img src="catalog/view/theme/villacrimea/image/dw.svg"></span><?php echo $download['name']; ?></a>
                      <?php } ?>
                     </div>
                      <?php } ?>
                      <?php if ($smallblocks) { ?>
                      <?php foreach ($smallblocks as $smallblock) { ?>
                        <div class="details">
                          <?php echo $smallblock['text']; ?>
                        </div>
                      <?php } ?>
                      <?php } ?>
                      <div class="realtor">
                          <p class="tel">Телефон: <a href="«tel:88006000019&quot;">8 800 600 00 19</a></p>
                          <p class="tel">E-mail: <a href="mailto:villa-crimea@mail.ru">villa-crimea@mail.ru</a></p>
                          <a href="#callback_agent" class="casual_button callback">Написать сообщение</a>
                          <div id="callback_agent" style="display: none;">
                              <button data-fancybox-close="" class="fancybox-close-small" title="Close"><span>X</span></button>
                              <div class="call_me_back_inner">
                                  <p class="title">Форма обратной связи</p>
                                  <div>
                                      <input type="text" id="name_agent" placeholder="Имя*">
                                      <input type="text" id="phone_agent" placeholder="Телефон*">
                                      <input type="text" id="email_agent" placeholder="E-mail">
                                      <input type="hidden" value="villa-crimea@mail.ru" id="hidden_email">
                                      <div class="textarea">
                                          <textarea id="message_agent" onkeyup="textAreaAdjust(this);" placeholder="Вопрос"></textarea>
                          <script>
                            function textAreaAdjust(o) {
                              o.style.height = "1px";
                              o.style.height = (5+o.scrollHeight)+"px";
                            }
                          </script>
                                      </div>
                                      <input type="checkbox" name="" id="conf_politics_one">
                                      <label for="conf_politics_one">
                                          я согласен(согласна)<br>
                                          с <a href="/privacy-policy">политикой конфиденциальности</a>
                                      </label>
                                      <button type="submit" onclick="sendFormAgent();" class="casual_button">Отправить</button>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
        <?php } ?>
      <?php }else{ ?>
        <?php if ($top_name || $description) { ?>
          <!-- <p class="title"><?php echo $top_name; ?></p> -->
          <?php echo $description; ?>
        <?php } ?>
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
                          <!--<?php /*$i = 0; ?>
                          <?php foreach($product['filter_options'] as $option){ ?>
                              <span><?php echo $option['name']; ?>: <?php echo $option['value'] . $option['postfix']; ?> /</span>
                              <?php $i++; ?>
                              <?php if($i > 2) break; ?>
                          <?php }*/ ?>-->
                          
                          <div>
                            <?php foreach($product['slider_filter_options'] as $option){ ?>
                              <p><?php echo $option['name']; ?> <span><?php echo $option['value'] . ' ' . $option['postfix']; ?></span></p>
                            <?php } ?>
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
        <div  class="owlDemo owl-carousel owl-theme">
          <?php foreach ($categories as $category) { ?>
          <div class="item">
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
          </div>
          <?php } ?>
        </div>
      </div>
      <?php } ?>
      
      <div class="seotext">
          <div class="agent">
              <div class="img" style="background-image: url('/image/catalog/persons/elenacopy.png');"></div>
              <p class="name">Коцеблюк Елена</p>
              <p>Решили купить недвижимость в Крыму?<br>Сделайте заявку на подбор недвижимости в Крыму прямо сейчас и получите сопровождение сделки в подарок.</p>
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
