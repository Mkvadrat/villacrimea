<?php echo $header; ?>
  <div class="contacts_page">
    <div class="object_title">
        <p class="title"><?php echo $heading_title; ?></p>
    </div>                
    <div class="contacts_inner">
        <div class="left_side">
            <?php echo $comment; ?>
            
            <p class="sub-title">Мы на карте:</p>
            <div class="map">
              <div id="map-contacts" style="width:100%; height:100%; position: absolute;"></div>
              <?php if($geocode){ ?>
                <script type="text/javascript">
                  var myMap;
                  ymaps.ready(init);
                  
                  function init(){
                    var myCoords = [<?php echo $geocode; ?>];  
                    var myGeocoder = ymaps.geocode(myCoords);
                    myGeocoder.then(
                    function (res){
                      var firstGeoObject = res.geoObjects.get(0),
                      myMap = new ymaps.Map
                      ("map-contacts",{
                        center: firstGeoObject.geometry.getCoordinates(),
                        zoom: 17
                      });
                      var myPlacemark = new ymaps.Placemark(
                      firstGeoObject.geometry.getCoordinates(),
                      {
                        iconContent: ''
                      },
                      {
                        preset: 'twirl#blueStretchyIcon'
                      });
                        myMap.geoObjects.add(myPlacemark);
                        myMap.behaviors.disable('scrollZoom');
                        myMap.controls.add(new ymaps.control.ScaleLine()).add('typeSelector');
                    },
                    function (err){
                      alert(err.message);
                    });
                  }
                </script>
              <?php } ?>
            </div>                        
        </div>
        <div class="right_side">
            <div class="contact_details">
                <?php echo $address; ?>
            </div>
            <div class="call_me_back_inner">
              <p class="title">Форма обратной связи</p>
              <div>
                  <input type="text" id="name" placeholder="Имя*">
                  <input type="text" id="phone" placeholder="Телефон*">
                  <input type="text" id="email" placeholder="E-mail">
                  <div class="textarea">
                      <textarea id="message" onkeyup="textAreaAdjust(this);" placeholder="Вопрос"></textarea>
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
                  <button type="submit" onclick="sendContactsForm();" class="casual_button">Отправить</button>
              </div>
            </div>
        </div>
        
        <div class="realtors">
            <?php if($agent_results){ ?>
            <p class="sub-title">Наша команда:</p>
            <?php foreach($agent_results as $agent){ ?>
            <div class="realtor">
                <div class="img" style="background-image: url('<?php echo $agent['image']; ?>')"></div>
                <p class="name"><?php echo $agent['name']; ?></p>
                <p class="job"><?php echo $agent['specialization']; ?></p>
                <a href="<?php echo $agent['all_cases']; ?>" class="cases"><img src="catalog/view/theme/villacrimea/image/case.png" alt="">Посмотреть все кейсы агента</a>
                <a href="<?php echo $agent['all_object']; ?>" class="realtor_objects"><img src="catalog/view/theme/villacrimea/image/home1.png" alt="">Посмотреть все объекты агента</a>
                <p class="tel">Телефон: <a href="tel:<?php echo $agent['phone']; ?>"><?php echo $agent['phone']; ?></a></p>
                <p class="tel">E-mail: <a href="mailto:<?php echo $agent['email']; ?>"><?php echo $agent['email']; ?></a></p>
                <a href="#call_me_back_agent_<?php echo $agent['agent_id']; ?>" class="casual_button callback">Написать сообщение</a>
            </div>
            <?php } ?>
            <?php } ?>
            <br>
            <br>
            <?php echo $manager; ?>
        </div>
    </div>
  </div>
  <?php if($agent_results){ ?>
  <?php foreach($agent_results as $agent){ ?>
  <div id="call_me_back_agent_<?php echo $agent['agent_id']; ?>" style="display: none;">
      <button data-fancybox-close="" class="fancybox-close-small" title="Close"><span>X</span></button>
      <div class="call_me_back_inner">
          <p class="title">Форма обратной связи</p>
          <div>
              <input type="text" id="name_agent_<?php echo $agent['agent_id']; ?>" placeholder="Имя*">
              <input type="text" id="phone_agent_<?php echo $agent['agent_id']; ?>" placeholder="Телефон*">
              <input type="text" id="email_agent_<?php echo $agent['agent_id']; ?>" placeholder="E-mail">
              <input type="hidden" value="<?php echo $agent['email']; ?>" id="hidden_email_<?php echo $agent['agent_id']; ?>">
              <div class="textarea">
                  <textarea id="message_agent_<?php echo $agent['agent_id']; ?>" onkeyup="textAreaAdjust(this);" placeholder="Вопрос"></textarea>
                  <script>
                      function textAreaAdjust(o) {
                          o.style.height = "1px";
                          o.style.height = (5+o.scrollHeight)+"px";
                      }
                  </script>
              </div>
              
              <input type="checkbox" id="conf_politics_agent_<?php echo $agent['agent_id']; ?>">
              <label for="conf_politics_agent_<?php echo $agent['agent_id']; ?>">
                      я согласен(согласна)<br>
                      с <a href="#">политикой конфиденциальности</a>
              </label>
              <button type="submit" onclick="sendFormAgent_<?php echo $agent['agent_id']; ?>();" class="casual_button">Отправить</button>
          </div>
      </div>
  </div>
  <script type="text/javascript">
  function sendFormAgent_<?php echo $agent['agent_id']; ?>(){
      $.ajax({
          url: 'index.php?route=information/contact/sendFormAgent',
          type: 'post',
          data: {  
              'name' : $('#name_agent_<?php echo $agent['agent_id']; ?>').val(),
              'tel' : $('#phone_agent_<?php echo $agent['agent_id']; ?>').val(),
              'email' : $('#email_agent_<?php echo $agent['agent_id']; ?>').val(),
              'email_agent' : $('#hidden_email_<?php echo $agent['agent_id']; ?>').val(),
              'message' : $('#message_agent_<?php echo $agent['agent_id']; ?>').val(),
          },
          dataType: 'json',
          success: function(data) {
              swal({
                  title: data.message,
                  text: "",
                  timer: 1000,
                  showConfirmButton: false
              });
  
              $.fancybox.close();
          }
      });
  }
  </script>
  <?php } ?>
  <?php } ?>
<?php echo $footer; ?>
