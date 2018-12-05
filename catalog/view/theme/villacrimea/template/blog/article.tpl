<?php echo $header; ?>
	<div class="case_in_page">
		
		<?php echo $content_top; ?>
		 
		<div class="object_title">
			<a class="backward back"><img src="catalog/view/theme/villacrimea/image/backward.png" alt="">Назад</a>
			<h1 class="title"><?php echo $heading_title; ?></h1>
			<p class="center"></p>
		</div>                
		<div class="case_inner">
			<div class="left_side">
				<?php echo $description; ?>
			</div>
			<div class="right_side">
				
				<?php if($detail){ ?>
				<div class="details">
					<?php echo $detail; ?>
				</div>
				<?php } ?>
				
				<div class="released_rel">
					<div class="realtor">
						<div class="img" style="background-image: url('<?php echo $image_agent; ?>')"></div>
						<p class="name"><?php echo $agent_name; ?></p>
						
						<?php if($specialization){ ?>
						<p class="job"><?php echo $specialization; ?></p>
						<?php } ?>
						
						<a href="<?php echo $view_all_object; ?>" class="realtor_objects"><img src="catalog/view/theme/villacrimea/image/home1.png" alt="">Посмотреть все объекты агента</a>
						<a href="<?php echo $view_all_cases; ?>" class="cases"><img src="catalog/view/theme/villacrimea/image/case.png" alt="">Посмотреть все кейсы агента</a>

						<?php if($phone){ ?>
						<p class="tel">Телефон: <a href="tel:<?php echo $phone; ?>"><?php echo $phone; ?></a></p>
						<?php } ?>
						
						<?php if($email){ ?>
						<p class="tel">E-mail: <a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></p>
						<?php } ?>
						
						<a href="#callback_agent" class="casual_button callback">Написать сообщение</a>
						
						<div id="callback_agent" style="display: none;">
							<button data-fancybox-close="" class="fancybox-close-small" title="Close"><span>X</span></button>
							<div class="call_me_back_inner">
								<p class="title">Форма обратной связи</p>
								<div>
									<input type="text" id="name_agent" placeholder="Имя*">
									<input type="text" id="phone_agent" placeholder="Телефон*">
									<input type="text" id="email_agent" placeholder="E-mail">
									<input type="hidden" value="<?php echo $email; ?>" id="hidden_email">
									<div class="textarea">
										<textarea id="message_agent" onkeyup="textAreaAdjust(this);" placeholder="Вопрос"></textarea>
										<script>
											function textAreaAdjust(o) {
												o.style.height = "1px";
												o.style.height = (5+o.scrollHeight)+"px";
											}
										</script>
									</div>
									<input type="checkbox" name="" id="conf_politics_one">
									<label for="conf_politics">
											я согласен(согласна)<br>
											с <a href="#">политикой конфиденциальности</a>
									</label>
									<button type="submit" onclick="sendFormAgent();" class="casual_button">Отправить</button>
								</div>
							</div>
						</div>						
					</div>
					
					<?php if($product_case){ ?>
					<div class="card">
						<a class="img" href="<?php echo $product_href; ?>" style="background-image: url('<?php echo $product_image; ?>')"></a>
						<div class="card_label">
							<?php if($product_stickers){ ?>
							  <?php foreach ($product_stickers as $sticker) { ?>
								  <span><img src="<?php echo $sticker['image']; ?>"></span>
							  <?php } ?>
							<?php } ?>
						</div>
						<a class="name" href="<?php echo $product_href; ?>"><?php echo $product_name; ?></a>
						
						<?php if($filter_options){ ?>
						<div class="tags">
							<?php $i = 0; ?>
							<?php foreach($filter_options as $option){ ?>
								<span><?php echo $option['name']; ?>: <?php echo $option['value'] . $option['postfix']; ?></span>
								<?php $i++; ?>
								<?php if($i > 2) break; ?>
							<?php } ?>
						</div>
						<?php } ?>
						
						<?php if ($price || $rub) { ?>
						<?php if (!$special) { ?>
						<p>Цена: <span><?php echo $rub; ?> / <?php echo $price; ?></span></p>
						<?php } else { ?>
						<p>Цена: <span><?php echo $special; ?></span><sup><strike><?php echo $price; ?></strike></sup></p>
						<?php } ?>
						<?php } ?>
						
						<span class="object_id">№ <?php echo $product_model; ?></span>
					</div>
					<?php } ?>
				</div>
			</div>
		</div>
		
		<?php if($articles){ ?>
		<div class="cases">
			<p class="title">Похожие кейсы:</p>
			<div class="slider">
				<div class="owl-carousel cases_carousel">
					<?php foreach($articles as $article) {?>
					<div>
						<div class="case">
							<p class="title"><?php echo $article['name']; ?></p>
							<?php echo $article['description'] ?>
							<a href="<?php echo $article['href'] ?>" class="casual_button">Подробнее об этом кейсе</a>
						</div>
						<div class="realtor">
								<div class="img" style="background-image: url('<?php echo $article['image_agent'] ?>')"></div>
							<p><?php echo $article['agent'] ?></p>
						</div>
						<div class="description">
							<div class="img" style="background-image: url('<?php echo $article['thumb'] ?>')"></div>
							<?php echo $article['short_description'] ?>
						</div>
					</div>
					<?php } ?>
				</div>
			</div>
		</div>
		<?php } ?>
		
		<?php if($products){ ?>
		<div class="same_objects">
			<p class="title">Похожие объекты:</p>
			<div class="owl-carousel same_obj_slider">
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
						<?php $i == 0; ?>
						<?php foreach($product['filter_options'] as $option){ ?>
							<?php echo $option['name']; ?>: <span><?php echo $option['value'] . $option['postfix']; ?></span>
							<?php $i++; ?>
							<?php if($i == 3 ){break;} ?>
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
		</div>
		<?php } ?>
	</div>
<?php echo $footer; ?>