<?php echo $header; ?>
	<div class="blog_page">
		
		<?php echo $content_top; ?>
		
		<?php if($news_list){ ?>
		<?php foreach($news_list as $news){ ?>
		<div class="blog_item">
			<a href="<?php echo $news['href']; ?>" class="img" style="background-image: url('<?php echo $news['thumb']; ?>')"></a>
			<div class="text">
				<a href="<?php echo $news['href']; ?>" class="title"><?php echo $news['title']; ?></a>
				<p><?php echo $news['description']; ?></p>
				<div class="bottomed">
					<a href="<?php echo $news['href']; ?>" class="casual_button">Подробнее</a>
					<span class="date"><?php echo $news['posted']; ?></span>
				</div>
			</div>
		</div>
		<?php } ?>
		<?php }else{ ?>
		<p><?php echo $text_empty; ?></p>
		<div class="buttons">
			<div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
		</div>
		<?php } ?>
		
		<?php echo $pagination; ?>
	</div>
	
<?php echo $footer; ?>