<div class="promo_block">
    <div class="text">
        <?php echo $html; ?>
        
        <?php if($main_download_presentation){ ?>
        <?php foreach($main_download_presentation as $main){?>
          <a href="<?php echo $main['href']; ?>" class="dwnld_presentation"><img src="catalog/view/theme/villacrimea/image/pdf.png" alt=""><?php echo $main['name']; ?></a>
        <?php } ?>
        <?php } ?>
        
        <?php if($second_download_presentation){ ?>
        <ul class="categories">
          <?php foreach($second_download_presentation as $second){?>
            <li><a href="<?php echo $second['href']; ?>"><?php echo $second['name']; ?></a></li>
          <?php } ?>
        </ul>
        <?php } ?>
    </div>
    
    <img src="<?php echo $image; ?>" alt="<?php echo $heading_title; ?>">
</div>