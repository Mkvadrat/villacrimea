<?php echo $header; ?>
	<div class="blog_in_page">
		
		<?php echo $content_top; ?>
		
		<div class="object_title">
			<a class="backward back"><img src="catalog/view/theme/villacrimea/image/backward.png" alt="">К списку</a>
			<?php if($heading_title) {?>
			<p class="title"><?php echo $heading_title; ?></p>
			<?php } ?>
			
			<?php if($sub_title) {?>
			<p class="center"><?php echo $sub_title; ?></p>
			<?php } ?>
		</div>                
		<div class="blog_inner">
			<div class="left_side">
				<?php echo $description; ?>
				
				<p class="blog_date"><?php echo $posted; ?></p>
			</div>
			
			<?php echo $column_right; ?>
		</div>
	</div>
<?php echo $footer; ?>