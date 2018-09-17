<div class="agent_with_cards">
    <div class="agent">
      <?php echo $html; ?>
    </div>
    
    <?php if($products){ ?>
    <div class="cards">
        <?php foreach ($products as $product) { ?>
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
                <?php $i = 0; ?>
                <?php foreach($product['filter_options'] as $option){ ?>
                    <?php echo $option['name']; ?>: <span><?php echo $option['value'] . $option['postfix']; ?> /</span>
                    <?php $i++; ?>
                    <?php if($i > 2) break; ?>
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
    <?php } ?>
</div>