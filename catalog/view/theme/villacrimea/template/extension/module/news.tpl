<div class="blog">
	<p class="title"><?php echo $heading_title; ?></p>
	
	<?php echo $html; ?>
	
	<div class="blogs">
		<?php foreach ($news as $news_item) { ?>
		<div class="blogs_item">
			<a href="<?php echo $news_item['href']; ?>" class="img" style="background-image: url('<?php echo $news_item['thumb']; ?>')"></a>
			<div>
				<a href="<?php echo $news_item['href']; ?>" class="name"><?php echo $news_item['title']; ?></a>
				
				<?php echo $news_item['description']; ?>				
			</div>
		</div>
		<?php } ?>
	</div>
	
	<a href="<?php echo $news_list; ?>" class="more_blogs">Перейти в раздел блог</a>
</div>
