    <footer>
        <div class="footer_left_side">
            
            <?php if($categories){ ?>
            <ul class="menu">
            <?php foreach ($categories as $category) { ?>
              <?php if ($category['children']) { ?>
              <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                <div class="dropdown-menu">
                  <div class="dropdown-inner">
                    <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                    <ul class="list-unstyled">
                      <?php foreach ($children as $child) { ?>
                      <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                      <?php } ?>
                    </ul>
                    <?php } ?>
                  </div>
                  <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
              </li>
              <?php } else { ?>
              <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
              <?php } ?>
            <?php } ?>
            </ul>
            <?php } ?>
            
            <?php if($footer_categories){ ?>
            <ul class="categories">
                <?php foreach($footer_categories as $category){ ?>
                    <li><a href="<?php echo $category['href'] ?>"><?php echo $category['name'] ?></a></li>
                <?php } ?>
            </ul>
            <?php } ?>
            
        </div>
        
        <div class="footer_right_side">
           <?php echo $contact_footer; ?>
        </div>
        
        <?php echo $powered; ?>
    </footer>
</body>
</html>