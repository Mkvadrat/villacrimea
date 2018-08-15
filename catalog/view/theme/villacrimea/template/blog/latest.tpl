<?php echo $header; ?>

<!-- start main news -->
<div class="main-news">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<p class="title-black"><?php echo $heading_title; ?></p>

				<?php echo $content_top; ?>
				<?php if($articles){ ?>
				<ul class="list-news-objects">
					<?php foreach ($articles as $article) { ?>     
						<li>
						<div class="photo-block" style="background-image: url('<?php echo $article['thumb']; ?>');"><a href="<?php echo $article['href']; ?>"><?php echo $button_more; ?></a></div>
						<div class="description-block">
						<p class="title-black-24"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></p>
						<p class="small-p-black"><?php echo $article['description']; ?> <a href="<?php echo $article['href']; ?>"><?php echo $button_more; ?></a></p>
						<p class="date small-p-black"><?php echo $text_display; ?> <time datetime="<дата и время>"><?php echo $article["date_added"];?></time></p>
						</div>
						</li>
					<?php } ?>
				</ul>
				<?php }else{ ?>
				<ul class="list-news-objects">
					<li><?php echo $text_empty; ?></li>
				</ul>
				<?php } ?>
				
				<?php if($pagination){ ?>
					<div class="pagination-block">
						<?php echo $pagination; ?>
					</div>
				<?php } ?>
			
				<?php echo $content_bottom; ?>
			</div>
		</div>
	</div>
</div>
<!-- end main news -->

<?php echo $footer; ?>