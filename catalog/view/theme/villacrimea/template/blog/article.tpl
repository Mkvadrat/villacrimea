<?php echo $header; ?>
	<div class="case_in_page">
		<div class="object_title">
			<a class="backward back"><img src="catalog/view/theme/villacrimea/image/backward.png" alt="">К списку</a>
			<p class="title"><?php echo $heading_title; ?></p>
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
						
						<a href="<?php echo $view_all_cases; ?>" class="cases"><img src="catalog/view/theme/villacrimea/image/case.png" alt="">Посмотреть все кейсы агента</a>
						<a href="<?php echo $view_all_object; ?>" class="realtor_objects"><img src="catalog/view/theme/villacrimea/image/home1.png" alt="">Посмотреть все объекты агента</a>
						
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
						
						<script type="text/javascript">
							function sendFormAgent(){
								$.ajax({
									url: 'index.php?route=product/product/sendFormAgent',
									type: 'post',
									data: {  
										'name' : $('#name_agent').val(),
										'tel' : $('#phone_agent').val(),
										'email' : $('#email_agent').val(),
										'email_agent' : $('#hidden_email').val(),
										'message' : $('#message_agent').val(),
									},
									dataType: 'json',
									success: function(data) {
										swal({
											title: data.message,
											text: "",
											timer: 1000,
											showConfirmButton: false
										});
							
										$.fancybox.close();
									}
								});
							}
						</script>
						
					</div>
					
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
							<?php $i == 0; ?>
							<?php foreach($filter_options as $option){ ?>
								<span><?php echo $option['name']; ?>: <?php echo $option['value'] . $option['postfix']; ?></span>
								<?php $i++; ?>
								<?php if($i == 3 ){break;} ?>
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
				</div>
			</div>
		</div>
		<div class="cases">
			<p class="title">Похожие кейсы:</p>
			<div class="slider">
				<div class="owl-carousel cases_carousel">
					<div>
						<div class="case">
							<p class="title">Отличная сделка в Ялте за 22000000 р.</p>
							<p>Вилла полностью готова к комфортному проживанию! Расположение в живописном месте, с лучшими видовыми характеристиками: море, горы, скалы "Адалары" и потрясающий вид на Аю-Даг. Самый большой и видовой участок в поселке, выполнен ландшафтный дизайн, высажены плодовые деревья и пальмы. Вилла состоит из двух этажей: 1 этаж: кухня - гостиная с выходом на террасу, кабинет и 2 с/у, хозяйственная комната. Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг. Также есть отдельный уютный гостевой домик с кухней-гостиной, сауной и ванной комнатой. Гараж для машин. Все коммуникации, телевидение и интернет! Закрытая охраняемая территория! Торг!</p>
							<a href="#" class="casual_button">Подробнее об этом кейсе</a>
						</div>
						<div class="realtor">
								<div class="img" style="background-image: url('./image/elena.png')"></div>
							<p>Коцеблюк Елена</p>
						</div>
						<div class="description">
							<div class="img" style="background-image: url('./image/2.jpg')"></div>
							<p>Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и... гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг.</p>
						</div>
					</div>
					<div>
						<div class="case">
							<p class="title">Отличная сделка в Ялте за 22000000 р.</p>
							<p>Вилла полностью готова к комфортному проживанию! Расположение в живописном месте, с лучшими видовыми характеристиками: море, горы, скалы "Адалары" и потрясающий вид на Аю-Даг. Самый большой и видовой участок в поселке, выполнен ландшафтный дизайн, высажены плодовые деревья и пальмы. Вилла состоит из двух этажей: 1 этаж: кухня - гостиная с выходом на террасу, кабинет и 2 с/у, хозяйственная комната. Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг. Также есть отдельный уютный гостевой домик с кухней-гостиной, сауной и ванной комнатой. Гараж для машин. Все коммуникации, телевидение и интернет! Закрытая охраняемая территория! Торг!</p>
							<a href="#" class="casual_button">Подробнее об этом кейсе</a>
						</div>
						<div class="realtor">
								<div class="img" style="background-image: url('./image/elena.png')"></div>
							<p>Коцеблюк Елена</p>
						</div>
						<div class="description">
							<div class="img" style="background-image: url('./image/2.jpg')"></div>
							<p>Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и... гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг.</p>
						</div>
					</div>
					<div>
						<div class="case">
							<p class="title">Отличная сделка в Ялте за 22000000 р.</p>
							<p>Вилла полностью готова к комфортному проживанию! Расположение в живописном месте, с лучшими видовыми характеристиками: море, горы, скалы "Адалары" и потрясающий вид на Аю-Даг. Самый большой и видовой участок в поселке, выполнен ландшафтный дизайн, высажены плодовые деревья и пальмы. Вилла состоит из двух этажей: 1 этаж: кухня - гостиная с выходом на террасу, кабинет и 2 с/у, хозяйственная комната. Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг. Также есть отдельный уютный гостевой домик с кухней-гостиной, сауной и ванной комнатой. Гараж для машин. Все коммуникации, телевидение и интернет! Закрытая охраняемая территория! Торг!</p>
							<a href="#" class="casual_button">Подробнее об этом кейсе</a>
						</div>
						<div class="realtor">
								<div class="img" style="background-image: url('./image/elena.png')"></div>
							<p>Коцеблюк Елена</p>
						</div>
						<div class="description">
							<div class="img" style="background-image: url('./image/2.jpg')"></div>
							<p>Есть действующий камин 2 этаж: хозяйская спальня с шикарной ванной комнатой и гардеробом, детская и... гостевая спальни со своими ванными комнатами и огромная видовая терраса с видом на море и Аю-Даг.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="same_objects">
			<p class="title">Похожие объекты:</p>
			<div class="owl-carousel same_obj_slider">
				<div class="card">
					<a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
					<div class="card_label">
						<span class="fast_label">срочный</span>
					</div>
					<a class="name" href="#">Продажа виллы в закрытом коттеджном поселке Продажа виллы в закрытом коттеджном поселкеs</a>
					<div class="tags">
						<span>Алушта / 3 комн. / 300 м. кв.</span>
					</div>
					<p class="price_rub">183 094 106 руб.</p>
					<p class="price_usd">2 900 000 $</p>
					<span class="object_id">№ 514</span>
				</div>
				<div class="card">
					<a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
					<div class="card_label">
						<span class="fast_label">срочный</span>
					</div>
					<a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
					<div class="tags">
						<span>Алушта / 3 комн. / 300 м. кв.</span>
					</div>
					<p class="price_rub">183 094 106 руб.</p>
					<p class="price_usd">2 900 000 $</p>
					<span class="object_id">№ 514</span>
				</div>
				<div class="card">
					<a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
					<div class="card_label">
						<span class="fast_label">срочный</span>
					</div>
					<a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
					<div class="tags">
						<span>Алушта / 3 комн. / 300 м. кв.</span>
					</div>
					<p class="price_rub">183 094 106 руб.</p>
					<p class="price_usd">2 900 000 $</p>
					<span class="object_id">№ 514</span>
				</div>
				<div class="card">
					<a class="img" href="#" style="background-image: url(./image/1.jpg)"></a>
					<div class="card_label">
						<span class="fast_label">срочный</span>
					</div>
					<a class="name" href="#">Продажа виллы в закрытом коттеджном поселке</a>
					<div class="tags">
						<span>Алушта / 3 комн. / 300 м. кв.</span>
					</div>
					<p class="price_rub">183 094 106 руб.</p>
					<p class="price_usd">2 900 000 $</p>
					<span class="object_id">№ 514</span>
				</div>
			</div>
		</div>
	</div>
<?php echo $footer; ?>