<div class="right_side">
	<div class="agent">
		<div class="img" style="background-image: url('/image/catalog/persons/elenacopy.png');"></div>
		<p class="name">Коцеблюк Елена</p>
		<p>Решили купить недвижимость в Крыму?<br>
Сделайте заявку на подбор недвижимости в Крыму прямо сейчас и получите сопровождение сделки в подарок.</p>
		<a class="casual_button callback" href="#order_selection">Заказать подбор</a>
	</div>
	<div class="released_rel">
		<p class="title"><?php echo $show_title; ?></p>
		
		<ul>
			<?php foreach ($news as $news_item) { ?>
			<li><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['title']; ?></a></li>
			<?php } ?>
		</ul>
	</div>
</div>