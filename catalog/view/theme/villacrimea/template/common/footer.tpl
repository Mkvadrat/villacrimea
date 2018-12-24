        </section>
        <div class="toTop" style="display: block;"></div>
        <div id="call_me_back" style="display: none;">
            <button data-fancybox-close="" class="fancybox-close-small" title="Close"><span>X</span></button>
            <div class="call_me_back_inner">
                <p class="title">Форма обратной связи</p>
                <div>
                    <input type="text" id="name" placeholder="Имя*">
                    <input type="text" id="phone" placeholder="Телефон*">
                    <input type="text" id="email" placeholder="E-mail">
                    <div class="textarea">
                        <textarea id="message" onkeyup="textAreaAdjust(this);" placeholder="Вопрос"></textarea>
                        <script>
                            function textAreaAdjust(o) {
                                o.style.height = "1px";
                                o.style.height = (5+o.scrollHeight)+"px";
                            }
                        </script>
                    </div>
                    <input type="checkbox" name="" id="conf_politics">
                    <label for="conf_politics">
                            я согласен(согласна)<br>
                            с <a href="/privacy-policy/">политикой конфиденциальности</a>
                    </label>
                    <button type="submit" onclick="sendForm();" class="casual_button">Отправить</button>
                </div>
            </div>
        </div>
        
        <div id="order_selection" style="display: none;">
            <button data-fancybox-close="" class="fancybox-close-small" title="Close"><span>X</span></button>
            <div class="call_me_back_inner">
                <p class="title">Форма обратной связи</p>
                <div>
                    <input type="text" id="name_for_order" placeholder="Имя*">
                    <input type="text" id="phone_for_order" placeholder="Телефон*">
                    <input type="text" id="email_for_order" placeholder="E-mail">
                    <div class="textarea">
                        <textarea id="message_for_order" onkeyup="textAreaAdjust(this);" placeholder="Вопрос"></textarea>
                        <script>
                            function textAreaAdjust(o) {
                                o.style.height = "1px";
                                o.style.height = (5+o.scrollHeight)+"px";
                            }
                        </script>
                    </div>
                    <input type="checkbox" id="conf_politics_three">
                    <label for="conf_politics_three">
                            я согласен(согласна)<br>
                            с <a href="/privacy-policy/">политикой конфиденциальности</a>
                    </label>
                    <button type="submit" onclick="orderSelection();" class="casual_button">Отправить</button>
                </div>
            </div>
        </div>
        
        <footer>
            <div class="footer_left_side">
                <?php if($categories){ ?>
                <ul class="menu">
                <?php foreach ($categories as $category) { ?>
                <?php if ($category['children']) { ?>
                <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                    <div class="dropdown-menu">
                    <div class="dropdown-inner">
                        <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                        <ul class="list-unstyled">
                        <?php foreach ($children as $child) { ?>
                        <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                        <?php } ?>
                        </ul>
                        <?php } ?>
                    </div>
                    <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
                </li>
                <?php } else { ?>
                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                <?php } ?>
                <?php } ?>
                </ul>
                <?php } ?>
                
                <?php if($footer_categories){ ?>
                <ul class="categories">
                    <?php foreach($footer_categories as $category){ ?>
                        <li><a href="<?php echo $category['href'] ?>"><?php echo $category['name'] ?></a></li>
                    <?php } ?>
                </ul>
                <?php } ?>
            </div>
            
            <div class="footer_right_side">
            <?php echo $contact_footer; ?>
            </div>
            
            <?php echo $powered; ?>
        </footer>
    </div>
    <nav id="menu">
    <ul>
        <?php if($footer_categories){ ?>
            <li><span style="text-transform:uppercase;">Объекты в продаже</span>
                <ul>
                    <?php foreach($footer_categories as $category){ ?>
                    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                    <?php } ?>
                </ul>
            </li>
        <?php } ?>
        <?php foreach ($categories as $category) { ?>
            <?php if ($category['children']) { ?>
            <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                <div class="dropdown-menu">
                    <div class="dropdown-inner">
                        <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                        <ul class="list-unstyled">
                            <?php foreach ($children as $child) { ?>
                            <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                            <?php } ?>
                        </ul>
                        <?php } ?>
                    </div>
                    <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a>
                </div>
            </li>
            <?php } else { ?>
            <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
            <?php } ?>
        <?php } ?>
    </ul>
    </nav>
</body>
</html>