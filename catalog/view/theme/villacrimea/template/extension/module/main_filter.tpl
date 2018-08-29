<h1 class="title"><?php echo $heading_title; ?></h1>

<?php if($categories){ ?>
<ul class="categories">
    <?php foreach($categories as $category){ ?>
        <li><a href="<?php echo $category['href'] ?>"><?php echo $category['name'] ?></a></li>
    <?php } ?>
</ul>
<?php } ?>

<div class="choise">
    <div>
        
        <?php if($filter_categories){ ?>
        <select name="filter_categories" id="type">
            <?php foreach($filter_categories as $category){ ?>
            <option value="<?php echo $category['href'] ?>"><?php echo $category['name'] ?></option>
            <?php } ?>
        </select>
        <?php } ?>
        
        <?php if($regions){ ?>
        <select name="regions" id="region">
            <?php foreach($regions as $region){ ?>
            <option value="<?php echo $region['href'] ?>"><?php echo $region['name'] ?></option>
            <?php } ?>
        </select>
        <?php } ?>
        
        <select class="price_from" name="price_from" id="price_from">
            <?php foreach($price_from_rub as $price){ ?>
            <option value="<?php echo $price['price']; ?>"><?php echo $price['price']; ?></option>
            <?php } ?>
        </select>
        
        <select class="price_to" name="price_to" id="price_to">
            <?php foreach($price_to_rub as $price){ ?>
            <option value="<?php echo $price['price']; ?>"><?php echo $price['price']; ?></option>
            <?php } ?>
            </select>
        </select>

        <select class="currency" name="currency" id="value">
            <option value="RUB">RUB</option>
            <option value="USD">USD</option>
        </select>
        
        <button type="submit" onclick="SendForm(); return true;">Показать</button>
    </div>
</div>

<script>
$(document).ready(function() {
    $( ".currency" ).change(function() {
        if($( ".currency" ).val() == "USD"){
            var i = 0;
            var j = 0;
            var price_from_usd = [];
            var price_to_usd   = [];
            
            <?php foreach($price_from_usd as $price_from){ ?>
                price_from_usd[i] = ['<?php echo $price_from['price']; ?>'];
                i++;
            <?php } ?>
            
            <?php foreach($price_to_usd as $price_to){ ?>
                price_to_usd[j] = ['<?php echo $price_to['price']; ?>'];
                j++;
            <?php } ?>
            
            $.each($('.price_from option'), function(item, file) {
                $(this).val(price_from_usd[item]).text(price_from_usd[item]);
            });
            
            $.each($('.price_to option'), function(item, file) {
                $(this).val(price_to_usd[item]).text(price_to_usd[item]);
            });
        }else{
            var i = 0;
            var j = 0;
            var price_from_rub = [];
            var price_to_rub   = [];
            
            <?php foreach($price_from_rub as $price_from){ ?>
                price_from_rub[i] = ['<?php echo $price_from['price']; ?>'];
                i++;
            <?php } ?>
            
            <?php foreach($price_to_rub as $price_to){ ?>
                price_to_rub[j] = ['<?php echo $price_to['price']; ?>'];
                j++;
            <?php } ?>
            
            $.each($('.price_from option'), function(item, file) {
                $(this).val(price_from_rub[item]).text(price_from_rub[item]);
            });
            
            $.each($('.price_to option'), function(item, file) {
                $(this).val(price_to_rub[item]).text(price_to_rub[item]);
            });
        }
    });
});

function SendForm(){
    var data = {
		'filter_categories' : $('#type').val(),
        'regions' : $('#region').val(),
        'price_from' : $('#price_from').val(),
        'price_to' : $('#price_to').val(),
        'currency' : $('#value').val(),
	};
	$.ajax({
		url:'index.php?route=extension/module/main_filter/getFilter',
		data:data,
		type:'POST',
		success:function(data){
			location.href = 'index.php?route=product/category&path=' + data.category_id + '&filter_ocfilter=p:' + data.price_from + '-' + data.price_to + ';' + data.regions + '&currencys=' + data.currency;
		}
	});
}
</script>