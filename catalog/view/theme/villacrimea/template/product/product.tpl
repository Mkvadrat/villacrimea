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
      <div class="object_title">
          <a class="backward back"><img src="catalog/view/theme/villacrimea/image/backward.png" alt="">К списку</a>
          <p class="title"><?php echo $heading_title; ?></p>
          
          <?php echo $heading_description; ?>
      </div>
      <div class="actual_object">
          <div class="left_side">
              <div class="object_photo">
              <?php if ($thumb || $images) { ?>
                <?php if ($thumb) { ?>
                <a href="<?php echo $popup; ?>" data-fancybox="gallery" class="main_photo" style="background-image: url('<?php echo $popup; ?>');"></a>
                <?php } ?>
                <?php if ($images) { ?>
                <?php foreach ($images as $image) { ?>
                <a href="<?php echo $image['popup']; ?>" data-fancybox="gallery" style="background-image: url('<?php echo $image['thumb']; ?>');"></a>
                <?php } ?>
                <?php } ?>
              <?php } ?>
              </div>
              
              <div class="object_description">
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
                                balloonContent: '<div class="ballon"><img src="<?php echo $product['image']; ?>" class="ll"/><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?><br><span>Подробнее</span></a><img class="close-button" onclick="myMap.balloon.close()" src="catalog/view/theme/mexica/image/maps/close.png"/></div>' // сдесь содержимое балуна в формате html, все стили в css
                              }, {
                                iconLayout: 'default#image',
                                <?php if($product_id == $product['product_id']){ ?>
                                  iconImageHref: 'catalog/view/theme/mexica/image/maps/icon-main.png', // картинка иконки
                                <?php }else{ ?>
                                  iconImageHref: 'catalog/view/theme/mexica/image/maps/icon.png', // картинка иконки
                                <?php } ?>
                                iconImageSize: [64, 64], // размер иконки
                                iconImageOffset: [-32, -64], // позиция иконки
                                balloonContentSize: [270, 99], // размер нашего кастомного балуна в пикселях
                                balloonLayout: "default#imageWithContent", // указываем что содержимое балуна кастомная херь
                                balloonImageHref: 'catalog/view/theme/mexica/image/maps/baloon2.png', // Картинка заднего фона балуна
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
                  <a href="#"><img src="./image/pdf1.png" alt="">Сохранить PDF</a>
                  <a href="#"><img src="./image/print.png" alt="">Напечатать страницу</a>
              </div>
              
              <div class="card_label">
                <?php if($stickers){ ?>
                  <?php foreach ($stickers as $sticker) { ?>
                      <span><img src="<?php echo $sticker['image']; ?>"></span>
                  <?php } ?>
                <?php } ?>
                
                <span class="object_id">№ <?php echo $model; ?></span>
              </div>
              
              <div class="details">
                  <p class="title">Детали:</p>
                  <?php if ($price || $rub) { ?>
                  <?php if (!$special) { ?>
                  <p>Цена: <span><?php echo $rub; ?> / <?php echo $price; ?></span></p>
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
                  <div class="img" style="background-image: url('./image/elena.png')"></div>
                  <p class="name">Коцеблюк Елена</p>
                  <p class="job">Исполнительный директор</p>
                  <a href="#" class="cases"><img src="./image/case.png" alt="">Посмотреть все кейсы агента</a>
                  <a href="#" class="realtor_objects"><img src="./image/home1.png" alt="">Посмотреть все объекты агента</a>
                  <p class="tel">Телефон: <a href="tel:+79788718100">+79788718100</a></p>
                  <p class="tel">E-mail: <a href="mailto:villa-crimea@mail.ru">villa-crimea@mail.ru</a></p>
                  <a href="#" class="casual_button">Написать сообщение</a>
              </div>
          </div>
      </div>
      <div class="same_objects">
          <p class="title">Похожие объекты:</p>
          <div class="owl-carousel same_obj_slider">
              <div class="card">
                  <a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
                  <div class="card_label">
                      <span class="fast_label">срочный</span>
                  </div>
                  <a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
                  <div class="tags">
                      <span>Алушта / 3 комн. / 300 м. кв.</span>
                  </div>
                  <p class="price_rub">183 094 106 руб.</p>
                  <p class="price_usd">2 900 000 $</p>
                  <span class="object_id">№ 514</span>
              </div>
              <div class="card">
                  <a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
                  <div class="card_label">
                      <span class="fast_label">срочный</span>
                  </div>
                  <a class="name" href="#">Продажа виллы в закрытом коттеджном поселке Продажа виллы в закрытом коттеджном поселке Продажа виллы в закрытом коттеджном поселке</a>
                  <div class="tags">
                      <span>Алушта / 3 комн. / 300 м. кв.</span>
                  </div>
                  <p class="price_rub">183 094 106 руб.</p>
                  <p class="price_usd">2 900 000 $</p>
                  <span class="object_id">№ 514</span>
              </div>
              <div class="card">
                  <a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
                  <div class="card_label">
                      <span class="fast_label">срочный</span>
                  </div>
                  <a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
                  <div class="tags">
                      <span>Алушта / 3 комн. / 300 м. кв.</span>
                  </div>
                  <p class="price_rub">183 094 106 руб.</p>
                  <p class="price_usd">2 900 000 $</p>
                  <span class="object_id">№ 514</span>
              </div>
              <div class="card">
                  <a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
                  <div class="card_label">
                      <span class="fast_label">срочный</span>
                  </div>
                  <a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
                  <div class="tags">
                      <span>Алушта / 3 комн. / 300 м. кв.</span>
                  </div>
                  <p class="price_rub">183 094 106 руб.</p>
                  <p class="price_usd">2 900 000 $</p>
                  <span class="object_id">№ 514</span>
              </div>
              <div class="card">
                  <a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
                  <div class="card_label">
                      <span class="fast_label">срочный</span>
                  </div>
                  <a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
                  <div class="tags">
                      <span>Алушта / 3 комн. / 300 м. кв.</span>
                  </div>
                  <p class="price_rub">183 094 106 руб.</p>
                  <p class="price_usd">2 900 000 $</p>
                  <span class="object_id">№ 514</span>
              </div>
              <div class="card">
                  <a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
                  <div class="card_label">
                      <span class="fast_label">срочный</span>
                  </div>
                  <a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
                  <div class="tags">
                      <span>Алушта / 3 комн. / 300 м. кв.</span>
                  </div>
                  <p class="price_rub">183 094 106 руб.</p>
                  <p class="price_usd">2 900 000 $</p>
                  <span class="object_id">№ 514</span>
              </div>
          </div>
      </div>
      <div class="case_like_this">
          <p class="title">Кейс похожий на объект:</p>
          <div>
              <div class="case">
                  <p class="title">Отличная сделка в Ялте за 22000000 р.</p>
                  <p>Вилла полностью готова к комфортному проживанию! Расположение в живописном месте, с лучшими видовыми характеристиками: море, горы, скалы "Адалары" и потрясающий вид на Аю-Даг. Самый большой и видовой участок в поселке, выполнен ландшафтный дизайн, высажены плодовые деревья и пальмы. Вилла состоит из двух этажей: 1 этаж: кухня - гостиная с выходом на террасу, кабинет и 2 с/у, хозяйственная комната. Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг. Также есть отдельный уютный гостевой домик с кухней-гостиной, сауной и ванной комнатой. Гараж для машин. Все коммуникации, телевидение и интернет! Закрытая охраняемая территория! Торг!</p>
                  <a href="#" class="casual_button">Подробнее об этом кейсе</a>
              </div>
              <div class="realtor">
                  <div class="img" style="background-image: url('./image/elena.png')"></div>
                  <p>Коцеблюк Елена</p>
              </div>
              <div class="description">
                  <div class="img" style="background-image: url('./image/2.jpg')"></div>
                  <p>Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и... гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг.</p>
              </div>
          </div>
          <a href="#" class="watch_cases">Смотреть все кейсы</a>
      </div>
  </div>
  
  <script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('.back').click(function(){
		parent.history.back();
		return false;
	});
});
</script>
<?php echo $footer; ?>
