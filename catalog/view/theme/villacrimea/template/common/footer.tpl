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
				<div class="anketa__block">
					<div class="anketa__img"><a href="https://www.rncb.ru/fizicheskkim-litsam/ipoteka/novostroyka/?TO_ONLINEANKETA=Y" target="_blank"><img src="/image/catalog/rnkb.png" alt="РНКБ" width="49"/></a></div>					
					<div class="anketa__text">
					<p><?php echo $text_anketa_text ?></p>
					<p><a href="https://www.rncb.ru/fizicheskkim-litsam/ipoteka/novostroyka/?TO_ONLINEANKETA=Y" target="_blank"><?php echo $text_anketa_link ?></a></p>
					</div>
				</div>
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
    
    <!-- {literal} -->
        <script type='text/javascript'>
        window['liv'+'eT'+'ex'] = true,
        window['live'+'Te'+'xID'] = 146893,
        window['liv'+'eT'+'e'+'x'+'_'+'o'+'bject'] = true;
        (function() {
        var t = document['c'+'rea'+'teEle'+'ment']('script');
        t.type ='text/javascript';
        t.async = true;
        t.src = '//cs15.livet'+'ex.ru/js/'+'c'+'lient.js';
        var c = document['ge'+'tElements'+'ByTagN'+'ame']('script')[0];
        if ( c ) c['pare'+'nt'+'Node']['ins'+'ertB'+'efore'](t, c);
        else document['docum'+'entEle'+'ment']['fi'+'rstCh'+'il'+'d']['appe'+'n'+'dChi'+'l'+'d'](t);
        })();
        </script>
    <!-- {/literal} -->
    
    <!-- Yandex.Metrika counter -->
    <script type="text/javascript">
        (function (d, w, c) {
            (w[c] = w[c] || []).push(function() {
                try {
                    w.yaCounter32173209 = new Ya.Metrika({
                        id:32173209,
                        clickmap:true,
                        trackLinks:true,
                        accurateTrackBounce:true,
                        webvisor:true,
                        trackHash:true,
                        ut:"noindex"
                    });
                } catch(e) { }
            });
    
            var n = d.getElementsByTagName("script")[0],
                s = d.createElement("script"),
                f = function () { n.parentNode.insertBefore(s, n); };
            s.type = "text/javascript";
            s.async = true;
            s.src = "https://mc.yandex.ru/metrika/watch.js";
    
            if (w.opera == "[object Opera]") {
                d.addEventListener("DOMContentLoaded", f, false);
            } else { f(); }
        })(document, window, "yandex_metrika_callbacks");
    </script>
    <noscript><div><img src="https://mc.yandex.ru/watch/32173209?ut=noindex" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
    <!-- /Yandex.Metrika counter -->

</body>
</html>