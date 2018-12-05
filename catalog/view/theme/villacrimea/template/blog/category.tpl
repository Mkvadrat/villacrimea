<?php echo $header; ?>
    <div class="cases_page">
      
      <?php echo $content_top; ?>
      
      <?php if($categories_agent){ ?>
      <div class="realtor_category">
        <?php foreach($categories_agent as $agent){ ?>
          <div class="realtor_item">
              <a href="<?php echo $agent['view_case']; ?>" class="realtor">
                  <div class="img" style="background-image: url('<?php echo $agent['image']; ?>')"></div>
                  <p class="name"><?php echo $agent['name']; ?></p>
                  <p class="job"><?php echo $agent['specialization']; ?></p>
                  <!-- <p class="obj_count">Проданых объектов –
                      <span><?php echo $agent['count']; ?></span>
                  </p> -->
              </a>
              <a href="<?php echo $agent['view_case']; ?>" class="watch_cases">Посмотреть кейсы</a>
              <!-- <a href="<?php echo $agent['href']; ?>" class="watch_cases">Посмотреть объекты в продаже</a> -->
          </div>
        <?php } ?>
      </div>
      <?php } ?>

      <a href="<?php echo $view_all_case; ?>" class="watch_all_cases">Смотреть кейсы всех агентов <?php echo $count_case; ?></a>
      
      <?php if($articles){ ?>
      <div class="agent_cases">
        <?php foreach($articles as $article){ ?>
          <div class="agent_item">
              <div class="case">
                  <p class="title"><?php echo $article['name']; ?></p>
                  <?php echo $article['description']; ?>
                  <a href="<?php echo $article['href']; ?>" class="casual_button">Подробнее об этом кейсе</a>
              </div>
              <div class="realtor">
                  <div class="img" style="background-image: url('<?php echo $article['image_agent']; ?>')"></div>
                  <p><?php echo $article['category_name']; ?></p>
              </div>
              <div class="description">
                  <div class="img" style="background-image: url('<?php echo $article['thumb']; ?>')"></div>
                  <?php echo $article['short_description']; ?>
              </div>
          </div>
        <?php } ?>
      </div>
      <?php }else{ ?>
      <div class="have_no_items">
        <p class="center"><?php echo $text_empty; ?></p>
        <p class="center"><a href="<?php echo $continue; ?>" class="casual_button"><?php echo $button_continue; ?></a></p>
      </div>
      <?php } ?>
      
     <?php echo $pagination; ?>
  </div>
<?php echo $footer; ?>