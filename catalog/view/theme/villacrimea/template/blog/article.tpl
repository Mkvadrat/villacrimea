<?php echo $header; ?>

	<!-- start main news in -->

	<div class="main-news-in">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<p class="title-black"><?php echo $heading_title; ?></p>
			
					<?php echo $content_top; ?>

					<article class="article-block-wrapper">
						<?php if($prev){ ?>
							<a href="<?php echo $prev; ?>" class="prev-article"><?php echo $text_prev; ?></a>
						<?php } ?>
						<?php if($next){ ?>
							<a href="<?php echo $next; ?>" class="next-article"><?php echo $text_next; ?></a>
						<?php } ?>
						
						<div class="article-block">	
							<?php echo $description; ?>
						</div>
					</article>

					<?php echo $content_bottom; ?>
				</div>
			</div>
		</div>
	</div>

	<!-- end main news in -->
		
<?php echo $footer; ?>