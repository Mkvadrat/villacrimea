$(document).ready(function () {
    $('.seling_carousel').owlCarousel({
        items: 1,
        pullDrag: true,
        nav: true,
        navText: ['<span></span>', '<span></span>']
    });
    $('.cases_carousel').owlCarousel({
        items: 1,
        dots: false,
        pullDrag: true,
        nav: true,
        navText: ['<span></span>', '<span></span>']
    });
    $('.same_obj_slider').owlCarousel({
        items: 3,
        margin: 20,
        dots: false,
        pullDrag: true,
        nav: true,
        navText: ['<span></span>', '<span></span>']
    });
    $('.about_us_slider').owlCarousel({
        items: 1,
        dots: true,
        nav: false,
    });

    $('.cases_carousel .case p').dotdotdot({
        height: 135,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.cases_carousel .description p').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.case_with .case p').dotdotdot({
        height: 135,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.case_with .description p').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.case_like_this .case p').dotdotdot({
        height: 135,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.case_like_this .description p').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.agent_item .case p').dotdotdot({
        height: 135,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.agent_item .description p').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.blog .blogs .blogs_item .name').dotdotdot({
        height: 40,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('.blog .blogs .blogs_item p').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('section .category_page .catalog .catalog_item .name').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('section .object_page .same_objects .name').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('section .case_in_page .same_objects .name').dotdotdot({
        height: 60,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('section .blog_page .blog_item .text p').dotdotdot({
        height: 130,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('section .blog_page .blog_item .text .title').dotdotdot({
        height: 40,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('section .blog_in_page .blog_inner .right_side ul li a').dotdotdot({
        height: 40,
        ellipsis: "\u2026",
        truncate: "letter",
        watch: "letter",
    });
    $('section .about_us_page .about_inner .right_side ul li a').dotdotdot({
        height: 40,
        ellipsis: "\u2026",
        truncate: "letter",
        watch: "letter",
    });
    $('section .services_page .services_inner .right_side ul li a').dotdotdot({
        height: 40,
        ellipsis: "\u2026",
        truncate: "letter",
        watch: "letter",
    });
    $("#menu").mmenu();
    $('.callback').fancybox({
        modal: true,
    });
    $('#conf_politics').on('click', function () {
        if ($(this).is(':checked')) {
            $(this).siblings('button').addClass('checked_button');
        } else {
            $(this).siblings('button').removeClass('checked_button');
        }
    });
    $('#conf_politics_cont').on('click', function () {
        if ($(this).is(':checked')) {
            $(this).siblings('button').addClass('checked_button');
        } else {
            $(this).siblings('button').removeClass('checked_button');
        }
    });
    $('.realtor_item .realtor').hover(function () {
        $(this).mouseover(function () {
            $(this).parents('.realtor_item').css('border', '1px solid #c09d74');
        });
        $(this).mouseleave(function () {
            $(this).parents('.realtor_item').css('border', '1px solid #dbdbdb');
        });
    });
    $('.sort_filter .change_view .tab_veiw').on('click', function () {
        if ($(this).is('.active')) {
            return 0;
        } else {
            $(this).addClass('active');
            $('.sort_filter .change_view .list_veiw').removeClass('active');
            $('.list_catalog').removeClass('list_catalog').addClass('tabs_catalog');
        }
    });
    $('.sort_filter .change_view .list_veiw').on('click', function () {
        if ($(this).is('.active')) {
            return 0;
        } else {
            $(this).addClass('active');
            $('.sort_filter .change_view .tab_veiw').removeClass('active');
            $('.tabs_catalog').removeClass('tabs_catalog').addClass('list_catalog');
        }
    });
    $(".object_page .right_side .realtor").stick_in_parent();
    $(".released_rel").stick_in_parent();
    $(".contacts_page .call_me_back_inner").stick_in_parent();
    $(".text_page .call_me_back_inner").stick_in_parent();
    $(function() {
        $(window).scroll(function() {
            if($(this).scrollTop() >= 250) {
                $('.toTop').fadeIn();
            } else {
                $('.toTop').fadeOut();
            }
        });
        $('.toTop').click(function() {
            $('body,html').animate({scrollTop:0},800);
        });
    });
    
    // Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	/* Search */
	$('#search input[name=\'search\']').parent().find('button').on('click', function() {
		var url = $('base').attr('href') + 'index.php?route=product/search';

		var value = $('header #search input[name=\'search\']').val();

		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}

		location = url;
	});

	$('#search input[name=\'search\']').on('keydown', function(e) {
		if (e.keyCode == 13) {
			$('header #search input[name=\'search\']').parent().find('button').trigger('click');
		}
	});
});