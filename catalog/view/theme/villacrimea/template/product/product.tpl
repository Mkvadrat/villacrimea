<?php echo $header; ?>
  <div class="object_page">
    
      <?php echo $content_top; ?>
      
      <div class="breadcrumbs">
          <!-- <hr> -->
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
          <!-- <hr> -->
      </div>
      
      <div class="object_title ">
          <a class="backward back"><img src="catalog/view/theme/villacrimea/image/backward.png" alt="">Назад</a>
          <h1 class="title" id="print1"><?php echo $heading_title; ?></h1>
          
          <span id="print6"><?php echo $heading_description; ?></span>
      </div>
      
      <div class="actual_object">
          <div class="left_side">
              <div class="object_photo" id="print7">
              <?php if ($popup || $images) { ?>
                <?php if ($popup) { ?>
                <div class="custom_product_photo_slider">
                    <button class="prev_slide"></button>
                    <a href="<?php echo $popup; ?>" data-fancybox="gallery" class="main_photo">
                        <img src='<?php echo $popup; ?>'>
                    </a>
                    <button class="next_slide"></button>
                </div>
                <?php } ?>
                <?php if ($images) { ?>
                <?php foreach ($images as $image) { ?>
                <a href="<?php echo $image['popup']; ?>" data-fancybox="gallery">
                    <img src="<?php echo $image['thumb']; ?>">
                </a>
                </a>
                <?php } ?>
                <?php } ?>
              <?php } ?>
              </div>
              
              <div class="card_label mobile">
                <?php if($stickers){ ?>
                  <?php foreach ($stickers as $sticker) { ?>
                      <span><img src="<?php echo $sticker['image']; ?>"></span>
                  <?php } ?>
                <?php } ?>
                
                <span class="object_id">Обьект № <?php echo $model; ?></span>
              </div>
              <div class="details mobile">
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
              <div class="specials mobile">
                  <?php echo $features; ?>
              </div>
              <?php } ?>

              <div class="object_description" id="print8">
                  <p class="title">Описание:</p>
                  <div><?php echo $description; ?></div>
              </div>

              <div class="realtor mobile">
                  <div class="img" style="background-image: url('<?php echo $image_agent; ?>')"></div>
              
                  <p class="name"><?php echo $agent_name; ?></p>
                  
                  <?php if($specialization){ ?>
                  <p class="job"><?php echo $specialization; ?></p>
                  <?php } ?>
                  
                  <?php if($category_id_object) {?>
                  <a href="<?php echo $view_all_object; ?>" class="realtor_objects"><img src="catalog/view/theme/villacrimea/image/home1.png" alt="">Посмотреть все объекты агента</a>
                  <?php } ?>
                  
                  <?php if($case_id) {?>
                    <a href="<?php echo $view_all_cases; ?>" class="cases"><img src="catalog/view/theme/villacrimea/image/case.png" alt="">Посмотреть все кейсы агента</a>
                  <?php } ?>
                
                  <?php if($phone){ ?>
                  <p class="tel">Телефон: <a href="tel:<?php echo $phone; ?>"><?php echo $phone; ?></a></p>
                  <?php } ?>
                  
                  <p class="tel">E-mail: <a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></p>
                  
                  <a href="#callback_agent" class="casual_button callback">Написать сообщение</a>
                  
                  <!-- modal was here -->
              </div>

              <div class="object_map">
                  <p class="title">Объекты рядом:</p>
                  <?php if($maps){ ?>
                    <div id="map-products-outer">
                        <div id="map-products"></div>
                    </div>
                    <script type="text/javascript">
										ymaps.ready(function () {
											var myMap = new ymaps.Map('map-products', {
												<?php foreach($maps as $product){ ?>
												<?php if($product_id == $product['product_id']){ ?>
												center: [<?php echo $product['lat_lng']; ?>],
												<?php } ?>
												<?php } ?>
												zoom: 17,
												behaviors: ['default', 'scrollZoom']
											}, {
												searchControlProvider: 'yandex#search'
											}),
											/**
											 * Создадим кластеризатор, вызвав функцию-конструктор.
											 * Список всех опций доступен в документации.
											 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Clusterer.xml#constructor-summary
											 */
												clusterer = new ymaps.Clusterer({
												/**
												 * Через кластеризатор можно указать только стили кластеров,
												 * стили для меток нужно назначать каждой метке отдельно.
												 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/option.presetStorage.xml
												 */
												preset: 'islands#invertedVioletClusterIcons',
												/**
												 * Ставим true, если хотим кластеризовать только точки с одинаковыми координатами.
												 */
												groupByCoordinates: false,
												/**
												 * Опции кластеров указываем в кластеризаторе с префиксом "cluster".
												 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/ClusterPlacemark.xml
												 */
												clusterDisableClickZoom: true,
												clusterHideIconOnBalloonOpen: false,
												geoObjectHideIconOnBalloonOpen: false
											}),
											/**
											 * Функция возвращает объект, содержащий данные метки.
											 * Поле данных clusterCaption будет отображено в списке геообъектов в балуне кластера.
											 * Поле balloonContentBody - источник данных для контента балуна.
											 * Оба поля поддерживают HTML-разметку.
											 * Список полей данных, которые используют стандартные макеты содержимого иконки метки
											 * и балуна геообъектов, можно посмотреть в документации.
											 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/GeoObject.xml
											 */
											<?php $i = 0; ?>
											<?php foreach($maps as $product){ ?>
											getPointData<?php echo $i; ?> = function () {
												return {
													balloonContentHeader: 'Объект №' + <?php echo $product['model']; ?>,
													balloonContent: '<div class="ballon"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a><br/><a href="<?php echo $product['href']; ?>"><span>Подробнее</span></a></div>',
													balloonContentFooter: '',
												};
											},
											<?php $i++; ?>
											<?php } ?>
											
											/**
											 * Функция возвращает объект, содержащий опции метки.
											 * Все опции, которые поддерживают геообъекты, можно посмотреть в документации.
											 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/GeoObject.xml
											 */
											<?php $i = 0; ?>
											<?php foreach($maps as $product){ ?> 
											getPointOptions<?php echo $i; ?> = function () {
												return {
													iconLayout : 'default#image',
													<?php if($product_id == $product['product_id']){ ?>
														iconImageHref: 'catalog/view/theme/villacrimea/image/maps/icon-main.png', // картинка иконки
													<?php }else{ ?>
														iconImageHref: 'catalog/view/theme/villacrimea/image/maps/icon.png', // картинка иконки
													<?php } ?>
													iconImageSize : [64, 64],
													preset: 'islands#violetIcon'
												};
											},
											<?php $i++; ?>
											<?php } ?>
											points = [
												<?php foreach($maps as $product){ ?>
													[<?php echo $product['lat_lng']; ?>], 
												<?php } ?>
											],
											geoObjects = [];
										  
											/**
											* Данные передаются вторым параметром в конструктор метки, опции - третьим.
											* @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Placemark.xml#constructor-summary
											*/
											var placemarks = [];
											<?php $i = 0; ?>
											<?php foreach($maps as $product){ ?>
												geoObjects[<?php echo $i; ?>] = new ymaps.Placemark(points[<?php echo $i; ?>], getPointData<?php echo $i; ?>(), getPointOptions<?php echo $i; ?>());
												placemarks.push(geoObjects[<?php echo $i; ?>]);
												<?php $i++; ?>
											<?php } ?>
										  
											/**
											* Можно менять опции кластеризатора после создания.
											*/
											clusterer.options.set({
												gridSize: 80,
												clusterDisableClickZoom: true,
												
											});
										  
											/**
											* В кластеризатор можно добавить javascript-массив меток (не геоколлекцию) или одну метку.
											* @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Clusterer.xml#add
											*/
                      myMap.behaviors.disable('scrollZoom');
											clusterer.add(placemarks);
											myMap.geoObjects.add(clusterer);             
											/**
											* Спозиционируем карту так, чтобы на ней были видны все объекты.
											*/
											/*myMap.setBounds(clusterer.getBounds(), {
												checkZoomRange: false
											});*/
										});
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
                
                <span class="object_id" id="print9">Обьект № <?php echo $model; ?></span>
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
                  
                  <?php if($category_id_object) {?>
                  <a href="<?php echo $view_all_object; ?>" class="realtor_objects"><img src="catalog/view/theme/villacrimea/image/home1.png" alt="">Посмотреть все объекты агента</a>
                  <?php } ?>
                  
                  <?php if($case_id) {?>
                    <a href="<?php echo $view_all_cases; ?>" class="cases"><img src="catalog/view/theme/villacrimea/image/case.png" alt="">Посмотреть все кейсы агента</a>
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
                              <label for="conf_politics_one">
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
                  
                  <!--<?php /*if($product['filter_options']){ ?>
                  <div class="tags">
                      <?php $i = 0; ?>
                      <?php foreach($product['filter_options'] as $option){ ?>
                          <?php echo $option['name']; ?>: <span><?php echo $option['value'] . $option['postfix']; ?></span>
                          <?php $i++; ?>
                          <?php if($i > 2) break; ?>
                      <?php } ?>
                  </div>
                  <?php }*/ ?>-->
                  
                  <?php if ($product['price'] || $product['rub']) { ?>
                  <?php if (!$product['special']) { ?>
                  <p class="price_rub"><?php echo $product['rub']; ?></p>
                  <p class="price_usd"><?php echo $product['price']; ?></p>
                  <?php } else { ?>
                  <p class="price_rub"><?php echo $product['special']; ?></p>
                  <p class="price_usd"><sup><strike><?php echo $product['price']; ?></strike></sup></p>
                  <?php } ?>
                  <?php } ?>
                  
                  <span class="object_id"><span class="hidden-xs">Обьект</span> № <?php echo $product['model']; ?></span>
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
