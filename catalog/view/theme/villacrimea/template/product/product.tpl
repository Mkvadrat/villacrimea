<?php echo $header; ?>
  <div class="object_page">
      <div class="breadcrumbs">
          <hr>
          <ul>
              <?php			
                  $count = count($breadcrumbs);
                  $i=1;
                  foreach ($breadcrumbs as $breadcrumb) {
                      if($i!=$count){
              ?>
                      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a><?php echo ' ' . $breadcrumb['separator']; ?></li>
              <?php
                      }else{
                          echo '<li><span> '.$breadcrumb['text'] . '</span></li>'; 
                      }		
                      $i++;
                  } 
              ?>
          </ul>
          <hr>
      </div>
      
      <div class="object_title ">
          <a class="backward back"><img src="catalog/view/theme/villacrimea/image/backward.png" alt="">К списку</a>
          <p class="title" id="print1"><?php echo $heading_title; ?></p>
          
          <span id="print6"><?php echo $heading_description; ?></span>
      </div>
      
      <div class="actual_object">
          <div class="left_side">
              <div class="object_photo" id="print7">
              <?php if ($popup || $images) { ?>
                <?php if ($popup) { ?>
                <a href="<?php echo $popup; ?>" data-fancybox="gallery" class="main_photo" style="background-image: url('<?php echo $popup; ?>');"></a>
                <?php } ?>
                <?php if ($images) { ?>
                <?php foreach ($images as $image) { ?>
                <!-- <a href="<?php echo $image['popup']; ?>" data-fancybox="gallery" style="background-image: url('<?php echo $image['thumb']; ?>');"> -->
                <a href="<?php echo $popup; ?>" data-fancybox="gallery">
                    <img src="<?php echo $popup; ?>">
                </a>
                </a>
                <?php } ?>
                <?php } ?>
              <?php } ?>
              </div>
              
              <div class="object_description" id="print8">
                  <p class="title">Описание:</p>
                  <?php echo $description; ?>
              </div>
              <div class="object_map">
                  <p class="title">Объекты рядом:</p>
                  <?php if($maps){ ?>
                    <div id="map-products" style="width:100%; height:536px"></div>
                    <script type="text/javascript">
                      ymaps.ready(init); // карта соберется после загрузки скрипта и элементов
                      var myMap; // заглобалим переменную карты чтобы можно было ею вертеть из любого места
                      function init () { // функция - собиралка карты и фигни
                        myMap = new ymaps.Map("map-products", {
                          <?php foreach($maps as $product){ ?>
                            <?php if($product_id == $product['product_id']){ ?>
                              center: [<?php echo $product['lat_lng']; ?>],
                            <?php } ?>
                          <?php } ?>
                          zoom: 15,
                          controls: ['zoomControl']
                        });
                           
                        var myGeoObjects = [];
                        
                        <?php $i = 0; ?>
                        <?php foreach($maps as $product){ ?>
                        
                        myGeoObjects[<?php echo $i; ?>] = new ymaps.Placemark([<?php echo $product['lat_lng']; ?>], { // Создаем метку с такими координатами и суем в переменную
                                balloonContent: '<div class="ballon"><img src="<?php echo $product['image']; ?>" class="ll"/><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?><br><span>Подробнее</span></a><img class="close-button" onclick="myMap.balloon.close()" src="catalog/view/theme/villacrimea/image/maps/close.png"/></div>' // сдесь содержимое балуна в формате html, все стили в css
                              }, {
                                iconLayout: 'default#image',
                                <?php if($product_id == $product['product_id']){ ?>
                                  iconImageHref: 'catalog/view/theme/villacrimea/image/maps/icon-main.png', // картинка иконки
                                <?php }else{ ?>
                                  iconImageHref: 'catalog/view/theme/villacrimea/image/maps/icon.png', // картинка иконки
                                <?php } ?>
                                iconImageSize: [64, 64], // размер иконки
                                iconImageOffset: [-32, -64], // позиция иконки
                                balloonContentSize: [270, 99], // размер нашего кастомного балуна в пикселях
                                balloonLayout: "default#imageWithContent", // указываем что содержимое балуна кастомная херь
                                balloonImageHref: 'catalog/view/theme/villacrimea/image/maps/baloon2.png', // Картинка заднего фона балуна
                                balloonImageOffset: [-65, -89], // смещание балуна, надо подогнать под стрелочку
                                balloonImageSize: [260, 89], // размер картинки-бэкграунда балуна
                                balloonShadow: false,
                                balloonAutoPan: false // для фикса кривого выравнивания
                              });
                        <?php $i++ ?>
                        <?php } ?>
                                      
                        var clusterer = new ymaps.Clusterer({
                          clusterDisableClickZoom: false,
                          clusterOpenBalloonOnClick: false,
                          // Устанавливаем стандартный макет балуна кластера "Карусель".
                          clusterBalloonContentLayout: 'cluster#balloonCarousel',
                          // Устанавливаем собственный макет.
                             //clusterBalloonItemContentLayout: customItemContentLayout,
                          // Устанавливаем режим открытия балуна. 
                          // В данном примере балун никогда не будет открываться в режиме панели.
                          clusterBalloonPanelMaxMapArea: 0,
                          // Устанавливаем размеры макета контента балуна (в пикселях).
                          clusterBalloonContentLayoutWidth: 300,
                          clusterBalloonContentLayoutHeight: 200,
                          // Устанавливаем максимальное количество элементов в нижней панели на одной странице
                          clusterBalloonPagerSize: 5
                          // Настройка внешего вида нижней панели.
                          // Режим marker рекомендуется использовать с небольшим количеством элементов.
                          // clusterBalloonPagerType: 'marker',
                          // Можно отключить зацикливание списка при навигации при помощи боковых стрелок.
                          // clusterBalloonCycling: false,
                          // Можно отключить отображение меню навигации.
                          // clusterBalloonPagerVisible: false
                        });
                        
                        clusterer.add(myGeoObjects);
                        myMap.geoObjects.add(clusterer);
                      }
                    </script>
                <?php } ?>
              </div>
          </div>
          <div class="right_side">
              <div class="save_object">
                  <a href="<?php echo $action_pdf; ?>"><img src="catalog/view/theme/villacrimea/image/pdf1.png" alt="">Сохранить PDF</a>
                  <a id="print"><img src="catalog/view/theme/villacrimea/image/print.png" alt="">Напечатать страницу</a>
              </div>
              
              <div class="card_label">
                <?php if($stickers){ ?>
                  <?php foreach ($stickers as $sticker) { ?>
                      <span><img src="<?php echo $sticker['image']; ?>"></span>
                  <?php } ?>
                <?php } ?>
                
                <span class="object_id" id="print9">№ <?php echo $model; ?></span>
              </div>
              
              <div class="details" id="print10">
                  <p class="title">Детали:</p>
                  <?php if ($price || $rub) { ?>
                  <?php if (!$special) { ?>
                  <p>Цена: <span><?php echo $rub; ?> / <span class="usdPrice"><?php echo $price; ?></span></span></p>
                  <?php } else { ?>
                  <p>Цена: <span><?php echo $special; ?></span><sup><strike><?php echo $price; ?></strike></sup></p>
                  <?php } ?>
                  <?php } ?>
                  
                  <?php if($uniq_options){ ?>
                  <?php if($product_options){ ?>
                    <?php foreach($product_options as $option){ ?>
                    <?php if($option['product_option_value']){ ?>
                      <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <p><?php echo $option['name']; ?>: <span><?php echo $option_value['name']; ?></span></p>
                      <?php } ?>
                    <?php }else{ ?>
                        <p><?php echo $option['name']; ?>: <span><?php echo $option['value']; ?></span></p>
                    <?php } ?>
                    <?php } ?>
                  <?php } ?>	
                <?php }else{ ?>
                  <?php if($filter_options){ ?>
                    <?php foreach($filter_options as $option){ ?>
                      <p><?php echo $option['name']; ?>: <span><?php echo $option['value']; ?></span></p>
                    <?php } ?>
                  <?php } ?>
                <?php } ?>
              </div>
              
              <?php if ($features) { ?>
              <div class="specials">
                  <?php echo $features; ?>
              </div>
              <?php } ?>
              
              <div class="realtor">
                  <div class="img" style="background-image: url('<?php echo $image_agent; ?>')"></div>
              
                  <p class="name" id="print2"><?php echo $agent_name; ?></p>
                  
                  <?php if($specialization){ ?>
                  <p class="job" id="print3"><?php echo $specialization; ?></p>
                  <?php } ?>
                  
                  <?php if($case_id) {?>
                    <a href="<?php echo $view_all_cases; ?>" class="cases"><img src="catalog/view/theme/villacrimea/image/case.png" alt="">Посмотреть все кейсы агента</a>
                  <?php } ?>
                  
                  <?php if($category_id_object) {?>
                  <a href="<?php echo $view_all_object; ?>" class="realtor_objects"><img src="catalog/view/theme/villacrimea/image/home1.png" alt="">Посмотреть все объекты агента</a>
                  <?php } ?>
                  
                  <?php if($phone){ ?>
                  <p class="tel" id="print4">Телефон: <a href="tel:<?php echo $phone; ?>"><?php echo $phone; ?></a></p>
                  <?php } ?>
                  
                  <p class="tel" id="print5">E-mail: <a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></p>
                  
                  <a href="#callback_agent" class="casual_button callback">Написать сообщение</a>
                  
                  <div id="callback_agent" style="display: none;">
                      <button data-fancybox-close="" class="fancybox-close-small" title="Close"><span>X</span></button>
                      <div class="call_me_back_inner">
                          <p class="title">Форма обратной связи</p>
                          <div>
                              <input type="text" id="name_agent" placeholder="Имя*">
                              <input type="text" id="phone_agent" placeholder="Телефон*">
                              <input type="text" id="email_agent" placeholder="E-mail">
                              <input type="hidden" value="<?php echo $email; ?>" id="hidden_email">
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
                              <label for="conf_politics">
                                      я согласен(согласна)<br>
                                      с <a href="#">политикой конфиденциальности</a>
                              </label>
                              <button type="submit" onclick="sendFormAgent();" class="casual_button">Отправить</button>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </div>
      
      <?php if($products){ ?>
      <div class="same_objects">
          <p class="title">Похожие объекты:</p>
          <div class="owl-carousel same_obj_slider">
            <?php foreach($products as $product){ ?>
              <div class="card">
                  <a class="img" href="<?php echo $product['href']; ?>" style="background-image: url('<?php echo $product['thumb']; ?>')"></a>
                  
                  <?php if($product['sticker']){ ?>
                  <div class="card_label">
                      <?php foreach ($product['sticker'] as $sticker) { ?>
                          <span><img src="<?php echo $sticker['image']; ?>"></span>
                      <?php } ?>
                  </div>
                   <?php } ?>
                  
                  <a class="name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                  
                  <?php if($product['filter_options']){ ?>
                  <div class="tags">
                      <?php $i == 0; ?>
                      <?php foreach($product['filter_options'] as $option){ ?>
                          <?php echo $option['name']; ?>: <span><?php echo $option['value'] . $option['postfix']; ?></span>
                          <?php $i++; ?>
                          <?php if($i == 3 ){break;} ?>
                      <?php } ?>
                  </div>
                  <?php } ?>
                  
                  <?php if ($product['price'] || $product['rub']) { ?>
                  <?php if (!$product['special']) { ?>
                  <p class="price_rub"><?php echo $product['rub']; ?></p>
                  <p class="price_usd"><?php echo $product['price']; ?></p>
                  <?php } else { ?>
                  <p class="price_rub"><?php echo $product['special']; ?></p>
                  <p class="price_usd"><sup><strike><?php echo $product['price']; ?></strike></sup></p>
                  <?php } ?>
                  <?php } ?>
                  
                  <span class="object_id">№ <?php echo $product['model']; ?></span>
              </div>
            <?php } ?>
          </div>
      </div>
      <?php } ?>
      
      <?php if($articles){ ?>
      <div class="case_like_this">
          <p class="title">Кейс похожий на объект:</p>
           <?php foreach ($articles as $article) { ?>
            <div>
                <div class="case">
                    <p class="title"><?php echo $article['name']; ?></p>
                    <?php echo $article['description']; ?>
                    <a href="<?php echo $article['href']; ?>" class="casual_button">Подробнее об этом кейсе</a>
                </div>
                <div class="realtor">
                    <div class="img" style="background-image: url('<?php echo $article['image_agent']; ?>')"></div>
                    <p><?php echo $article['agent']; ?></p>
                </div>
                <div class="description">
                    <div class="img" style="background-image: url('<?php echo $article['thumb']; ?>')"></div>
                    
                    <?php echo $article['short_description']; ?>
                </div>
            </div>
          <?php } ?>
          <a href="<?php echo $view_all_featured_cases; ?>" class="watch_cases">Смотреть все кейсы</a>
      </div>
  </div>
  <?php } ?>
  
<?php echo $footer; ?>
