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
            
            <span class="object_id">Обьект № <?php echo $product['model']; ?></span>
        </div>
        <?php } ?>
    </div>
    <?php } ?>
</div>

<div id="call_me_view" style="display: none;">
    <button data-fancybox-close="" class="fancybox-close-small" title="Close"><span>X</span></button>
    <div class="call_me_back_inner">
        <p class="title">Форма обратной связи</p>
        <div>
            <input type="text" id="name_view" placeholder="Имя*">
            <input type="text" id="phone_view" placeholder="Телефон*">
            <input type="text" id="email_view" placeholder="E-mail">
            <input type="text" id="datetime" placeholder="Удобное время">
            <div class="textarea">
                <textarea id="message_view" placeholder="Вопрос"></textarea>
            </div>
            <input type="checkbox" name="" id="conf_politics_datetime">
            <label for="conf_politics">
                    я согласен(согласна)<br>
                    с <a href="/privacy-policy/">политикой конфиденциальности</a>
            </label>
            <button type="submit" onclick="callMeView();" class="casual_button">Отправить</button>
        </div>
    </div>
</div>
<script>
$(function () {
    $('#datetime').datetimepicker({
        locale: 'ru'                                                    
    });
});
</script>