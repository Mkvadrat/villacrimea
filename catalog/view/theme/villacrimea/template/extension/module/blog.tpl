<div class="right_side">
	<p class="title">Читайте так же:</p>
	
	<ul>
		<?php foreach ($news as $news_item) { ?>
		<li><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['title']; ?></a></li>
		<?php } ?>
	</ul>
</div>