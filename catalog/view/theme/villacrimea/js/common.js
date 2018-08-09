$(document).ready(function () {
    $('.seling_carousel').owlCarousel({
        items : 1,
        pullDrag : true,
        nav : true,
        navText : [ '<span></span>' , '<span></span>' ]
    });
    $('.cases_carousel').owlCarousel({
        items : 1,
        dots : false,
        pullDrag : true,
        nav : true,
        navText : [ '<span></span>' , '<span></span>' ]
    });
    $('.cases_carousel .case p').dotdotdot({
        height : 135,
        ellipsis : "\u2026",
        truncate : "word",
        watch: "word",
    });
    $('.cases_carousel .description p').dotdotdot({
        height : 60,
        ellipsis : "\u2026",
        truncate : "word",
        watch: "word",
    });
    $('.blog .blogs .blogs_item .name').dotdotdot({
        height : 40,
        ellipsis : "\u2026",
        truncate : "word",
        watch: "word",
    });
    $('.blog .blogs .blogs_item p').dotdotdot({
        height : 60,
        ellipsis : "\u2026",
        truncate : "word",
        watch: "word",
    });
    $("#menu").mmenu();
    $('.callback').fancybox({
        modal : true,
    });
    $('#conf_politics').on('click', function() {
        if($(this).is(':checked')) {
            $(this).siblings('button').addClass('checked_button');
        } else {
            $(this).siblings('button').removeClass('checked_button');
        }
    });
    $('.realtor_item .realtor').hover(function() {
        $(this).mouseover(function() {
            $(this).parents('.realtor_item').css('border', '2px solid #c09d74');
        });
        $(this).mouseleave(function() {
            $(this).parents('.realtor_item').css('border', '1px solid #dbdbdb');
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