<div class="slider">
    <div class="owl-carousel seling_carousel">
      <?php foreach($banners as $banner) { ?>
        <div style="background-image: url('<?php echo $banner['image']; ?>')">
            <div class="seling_carousel_info">
                <p><?php echo $banner['title']; ?></p>
                <div>
                    <span><?php echo $banner['price']; ?></span>
                </div>
                <a class="casual_button" href="<?php echo $banner['link']; ?>">Подробнее</a>
            </div>
        </div>
        <?php } ?>
    </div>
</div>
