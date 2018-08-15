<div class="cases">
    <p class="title"><?php echo $heading_title; ?></p>
    
    <?php echo $html; ?>
    
    <div class="slider">
        <div class="owl-carousel cases_carousel">
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
        </div>
    </div>
    <a href="#" class="watch_cases">Смотреть все кейсы</a>
</div>