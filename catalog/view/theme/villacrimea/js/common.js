$(document).ready(function () {
    $('.seling_carousel').owlCarousel({
        items: 1,
        pullDrag: true,
        loop: true,
        nav: true,
        navText: ['<span></span>', '<span></span>'],
        autoplay: true,
        autoplayTimeout: 6000,
        autoplayHoverPause: true
    });
    $('.cases_carousel').owlCarousel({
        items: 1,
        dots: false,
        loop: true,
        pullDrag: true,
        nav: true,
        navText: ['<span></span>', '<span></span>']
    });
    $('.same_obj_slider').owlCarousel({
        responsive: {
            0: {
                items: 1
            },
            501: {
                items: 2
            },
            1025: {
                items: 3
            }
        },
        margin: 20,
        /*         loop : true,
         */
        dots: false,
        pullDrag: true,
        nav: true,
        navText: ['<span></span>', '<span></span>']
    });
    $('.about_us_slider').owlCarousel({
        items: 1,
        dots: true,
        nav: false,
        loop: true,
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
        height: ($(window).innerWidth() > 1400) ? (($(window).innerWidth() > 1900) ? 215 : 145) : 130,
        ellipsis: "\u2026",
        truncate: "word",
        watch: "word",
    });
    $('section .blog_page .blog_item .text .title').dotdotdot({
        height: ($(window).outerWidth() > 768) ? 40 : 80,
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
    $("#menu").mmenu({
        "extensions": [
            "pagedim-black"
        ]
    });
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
    $('#conf_politics_one').on('click', function () {
        if ($(this).is(':checked')) {
            $(this).siblings('button').addClass('checked_button');
        } else {
            $(this).siblings('button').removeClass('checked_button');
        }
    });
    $('#conf_politics_two').on('click', function () {
        if ($(this).is(':checked')) {
            $(this).siblings('button').addClass('checked_button');
        } else {
            $(this).siblings('button').removeClass('checked_button');
        }
    });
    $('#conf_politics_three').on('click', function () {
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
    $(".agent_with_cards .agent").stick_in_parent();
    if ($(window).outerWidth() > 1023) {
        $(".contacts_page .call_me_back_inner").stick_in_parent();
    }
    function NonOverflow () {
        $('.dropdown ul').each(function () {
            var otklon = $(this).offset().left + $(this).outerWidth();
            if (otklon > $(window).outerWidth()) {
                $(this).css('left', -(otklon - $(window).outerWidth()) - 30);
            }
        });
    };
    NonOverflow ();
    $(".text_page .call_me_back_inner").stick_in_parent();
    $(function () {
        $(window).scroll(function () {
            if ($(this).scrollTop() >= 250) {
                $('.toTop').fadeIn();
            } else {
                $('.toTop').fadeOut();
            }
        });
        $('.toTop').click(function () {
            $('body,html').animate({
                scrollTop: 0
            }, 800);
        });
    });

    // Highlight any found errors
    $('.text-danger').each(function () {
        var element = $(this).parent().parent();

        if (element.hasClass('form-group')) {
            element.addClass('has-error');
        }
    });

    /* Search */
    $('#search input[name=\'search\']').parent().find('button').on('click', function () {
        var url = $('base').attr('href') + 'index.php?route=product/search';

        var value = $('header #search input[name=\'search\']').val();

        if (value) {
            url += '&search=' + encodeURIComponent(value);
        }

        location = url;
    });

    $('#search input[name=\'search\']').on('keydown', function (e) {
        if (e.keyCode == 13) {
            $('header #search input[name=\'search\']').parent().find('button').trigger('click');
        }
    });

    jQuery('.back').click(function () {
        parent.history.back();
        return false;
    });

    $('#print').on('click', function () {
        $("#print01, #print1, #print2, #print3, #print4, #print5, #print6, #print7, #print8, #print9, #print10").printThis({
            debug: false, // show the iframe for debugging
            importCSS: true, // import page CSS
            importStyle: true, // import style tags
            printContainer: true, // grab outer container as well as the contents of the selector
            loadCSS: "catalog/view/theme/villacrimea/stylesheet/stylesheet.css", // path to additional css file - use an array [] for multiple
            pageTitle: "", // add title to print page
            removeInline: true, // remove all inline styles from print elements
            printDelay: 333, // variable print delay
            header: null, // prefix to html
            footer: null, // postfix to html
            base: false, // preserve the BASE tag, or accept a string for the URL
            formValues: true, // preserve input/form values
            canvas: true, // copy canvas elements (experimental)
            doctypeString: "...", // enter a different doctype for older markup
            removeScripts: false, // remove script tags from print content
            copyTagClasses: false // copy classes from the html & body tag
        });
    });

    $('section .object_title .backward').css('left', -($('body').outerWidth() - $('section .object_title').outerWidth()) / 2); // прижать кнопку "к списку"
    $(window).on('resize', function () {
        $('section .object_title .backward').css('left', -($('body').outerWidth() - $('section .object_title').outerWidth()) / 2); // прижать кнопку "к списку"
        NonOverflow ();
    });

    function CustomSlider() {
        var masser = [];
        $('section .object_page .object_photo a').each(function () {
            masser.push($(this));
        });
        var iterator = 1;
        $('.custom_product_photo_slider .prev_slide').on('click', function () {
            if (iterator - 1 == 0) iterator = masser.length - 1;
            else iterator--;
            var holder = masser[iterator].attr('href');
            var masserStart = masser[0].attr('href');
            masser[iterator].attr('href', masserStart).children('img').animate({
                /* 'opacity': '0.1', */
            }, 0, function () {
                $(this).attr('src', masserStart);/* .animate({
                    'opacity': '1',
                }, 50) */
            });
            masser[0].attr('href', holder).children('img').animate({
                /* 'opacity': '0.1', */
            }, 0, function () {
                $(this).attr('src', holder); /*.animate({
                    'opacity': '1', 
                }, )*/
            });
            //console.log(iterator);
        });
        $('.custom_product_photo_slider .next_slide').on('click', function() {
            //console.log(iterator);
            var holder = masser[iterator].attr('href');
            var masserStart = masser[0].attr('href');
            masser[iterator].attr('href', masserStart).children('img').animate({
                /* 'opacity': '0.1', */
            }, 0, function () {
                $(this).attr('src', masserStart);/* .animate({
                    'opacity': '1',
                }, 50) */
            });
            masser[0].attr('href', holder).children('img').animate({
                /* 'opacity': '0.1', */
            }, 0, function () {
                $(this).attr('src', holder);/* .animate({
                    'opacity': '1',
                }, 50) */
            });
            if(iterator+1 == masser.length) iterator=1; else iterator++;
            //console.log(iterator);
        });
        if (masser.length == 1) {
            $('.custom_product_photo_slider button').remove();
        }
        //console.log(masser.length);
    }
    CustomSlider();

    //добавляю класс родителю слайдера цены
    if ($('.scale').is('.scale')) {
        $('.scale').each(function() {
            $(this).parents('.list-group-item').addClass('scalable');
        });
    }
});

//Main page forms
function sendForm() {
    $.ajax({
        url: 'index.php?route=common/footer/sendForm',
        type: 'post',
        data: {
            'name': $('#name').val(),
            'tel': $('#phone').val(),
            'email': $('#email').val(),
            'message': $('#message').val(),
        },
        dataType: 'json',
        success: function (data) {
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

//Заказать подбор
function orderSelection() {
    $.ajax({
        url: 'index.php?route=common/footer/sendForm',
        type: 'post',
        data: {
            'name': $('#name_for_order').val(),
            'tel': $('#phone_for_order').val(),
            'email': $('#email_for_order').val(),
            'message': $('#message_for_order').val(),
        },
        dataType: 'json',
        success: function (data) {
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

//Product and cases page forms
function sendFormAgent() {
    $.ajax({
        url: 'index.php?route=product/product/sendFormAgent',
        type: 'post',
        data: {
            'name': $('#name_agent').val(),
            'tel': $('#phone_agent').val(),
            'email': $('#email_agent').val(),
            'email_agent': $('#hidden_email').val(),
            'message': $('#message_agent').val(),
        },
        dataType: 'json',
        success: function (data) {
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

//Contacts page forms
function sendContactsForm() {
    $.ajax({
        url: 'index.php?route=information/contact/sendContactsForm',
        type: 'post',
        data: {
            'name': $('#name').val(),
            'tel': $('#phone').val(),
            'email': $('#email').val(),
            'message': $('#message').val(),
        },
        dataType: 'json',
        success: function (data) {
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