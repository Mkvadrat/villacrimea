<?php echo $header; ?>
  <div class="about_us_page">
      
      <?php echo $content_top; ?>
    
      <div class="object_title">
          <p class="title"><?php echo $heading_title; ?></p>
          
          <?php if($sub_title){ ?>
          <p class="center"><?php echo $sub_title; ?></p>
          <?php } ?>
      </div>                
      <div class="about_inner">
          <div class="left_side">
            <?php echo $description; ?>
          </div>

          <?php echo $column_right; ?>
      </div>
  </div>
<?php echo $footer; ?>