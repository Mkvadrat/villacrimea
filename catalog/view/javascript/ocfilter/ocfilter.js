// https://codepen.io/martinAnsty/pen/BCotE
Math.easeIn = function (val, min, max, strength) {
	val /= max;

	return (max - 1) * Math.pow(val, strength) + min;
};

(function($) {
		var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');
				
        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
	};
	
	var filter_ocfilter = getUrlParameter('filter_ocfilter');
	
	$(document).on('change', "select[name='currencys']", function() {
		ocfilter.currencys_update();
	});
	
  function setSlider(_, target) {
    var
      that = this,
      $element = $(target),
      min = parseFloat($element.data().rangeMin),
      max = parseFloat($element.data().rangeMax),
      decimals = 0,
      elementMin,
      elementMax,
      controlMin,
      controlMax,
      _options = {
        behaviour: 'drag-tap',
        connect: true,
        range: {
          'min': min,
          'max': max
        },
      };

    // Logarithmic scale
    if ($element.data().optionId == 'p' && (max - min) > 100) {
      _options['pips'] = {
        mode: 'range',
    		density: 4
    	};

      var _i = 25, _strength = 3.5;

      if ((max - min) < 100) {
        _strength = 2;
      }

      for (; _i < 100; _i += 25) {
        _options['range'][_i + '%'] = Math.ceil(Math.easeIn(((max - min) / 100 * _i), min, max, _strength));
      }
    } else {
      _options['pips'] = {
        mode: 'count',
        values: 3,
    		density: 4
    	};
    }

    if (max && min != max) {
      _options['start'] = [ parseFloat($element.data().startMin), parseFloat($element.data().startMax) ];
    } else {
      _options['start'] = parseFloat($element.data().startMin);
    }

    // Decimal
    if (/\./.test($element.data().rangeMin) || /\./.test($element.data().rangeMax)) {
      decimals = Math.max(
        $element.data().rangeMin.toString().replace(/^\d+?\./, '').length,
        $element.data().rangeMax.toString().replace(/^\d+?\./, '').length
      );
    }

    _options['format'] = {
  	  to: function (value) {
  		  return parseFloat(value).toFixed(decimals);
  	  },
  	  from: function (value) {
  		  return parseFloat(value).toFixed(decimals);
  	  }
  	};

  	noUiSlider.create($element.get(0), _options);

    if ($element.data().elementMin && $($element.data().elementMin).length) {
      elementMin = $($element.data().elementMin);
    }

    if ($element.data().elementMax && $($element.data().elementMax).length) {
      elementMax = $($element.data().elementMax);
    }

    $element.get(0).noUiSlider.on('slide', function(values, handle, noformat) {
      if (typeof values[0] != 'undefined') {
        if (elementMin) {
          elementMin.html(parseFloat(values[0]).toLocaleString('ru'));
        }

        if ($element.data().controlMin && $($element.data().controlMin).length) {
          $($element.data().controlMin).val(parseFloat(noformat[0].toFixed(decimals)).toLocaleString('ru')); //Установка значений для input
        }
      }

      if (typeof values[1] != 'undefined') {
        if (elementMax) {
          elementMax.html(parseFloat(values[1]).toLocaleString('ru'));
        }

        if ($element.data().controlMax && $($element.data().controlMax).length) {
          $($element.data().controlMax).val(parseFloat(noformat[1].toFixed(decimals)).toLocaleString('ru')); //Установка значений для input
        }
      }
    });

    $element.get(0).noUiSlider.on('change', function(_, __, values, tap, positions) {
			
      that.params.remove.call(that, $element.data().optionId);

      if ((positions[1] - positions[0]) < 100) {
        that.params.set.call(that, $element.data().optionId, values[0].toFixed(decimals) + '-' + values[1].toFixed(decimals));
      }

      that.update($element);
    });

    if ($element.data().controlMin) {
      that.$element.on('change', $element.data().controlMin, function(e) {
        if (this.value == '') {
          return false;
        }

        if (this.value < min || this.value > max) {
          this.value = min;
        }

        $element.get(0).noUiSlider.set([this.value.split(' ').join(''), null]); //удаление пробелов при маске
      });
    }

    if ($element.data().controlMax) {
      that.$element.on('change', $element.data().controlMax, function(e) {
        if (this.value == '') {
          return false;
        }

        if (this.value < min || this.value > max) {
          this.value = max;
        }

        $element.get(0).noUiSlider.set([null, this.value.split(' ').join('')]); //удаление пробелов при маске
      });
    }
  };

  var ocfilter = {
    timers: {},
    values: {},
    options: {},
    init: function(options) {
      this.options = $.extend({}, options);

      this.$element = $('#ocfilter');

      this.$fields = $('.option-values input', this.$element);

      this.$target = $('.ocf-target', this.$element);
			
      this.$values = $('label', this.$element);
			
			this.$summ = $('.input-sm', this.$element); 

      var that = this;

      this.$values.each(function() {
        that.values[$(this).attr('id')] = this;
      });
			
			//Автозаполнение
			this.$target.bind('keydown', function(e){
        var
          $element = $(this),
          $buttonTarget = $element.closest('label');
					
					var valopt = [];
					$('.value-target').each(function() {
						valopt.push($(this).val());
					});
	
					if ($element.val().length >= 0) {
						that.atocom($element, $buttonTarget);
					}else if ($element.val().length > 0) {
						that.options.php.params = $('.value-target:first').val();
					}else if (filter_ocfilter) {
						that.options.php.params = filter_ocfilter;
					}else{
						$element.nextAll(":hidden").first().val("");
						that.options.php.params = $element.nextAll(":hidden").first().val();
						$element.closest('.ocf-option-values').find('label.ocf-selected').removeClass('ocf-selected');
					}

					if (event.keyCode == 13 && $element.val().length > 0) {
						that.options.php.params = valopt.join(';');
					}else if ($element.val().length > 0) {
						that.options.php.params = $('.value-target:first').val();
					}else if (filter_ocfilter) {
						that.options.php.params = filter_ocfilter;
					}else {
						$element.nextAll(":hidden").first().val("");
						that.options.php.params = $element.nextAll(":hidden").first().val();
						$element.closest('.ocf-option-values').find('label.ocf-selected').removeClass('ocf-selected');
					}
				
					that.update($buttonTarget);
			});
			//Автозаполнение

      this.$target.on('change', function(e) {
        e.preventDefault();

        var
          $element = $(this),
          $buttonTarget = $element.closest('label'),
          $dropdown = $element.closest('.dropdown');

				if (!$element.is(':text')) {
					that.options.php.params = $element.val();
				}
				
        if ($element.is(':radio')) {
          $element.closest('.ocf-option-values').find('label.ocf-selected').removeClass('ocf-selected');
        }
				
				if (!$element.is(':text')) {
					$buttonTarget.toggleClass('ocf-selected', $element.prop('checked'));
	
					that.update($buttonTarget);
				}
      });
			
      this.$element.on('click.ocf', '.dropdown-menu', function(e) {
        $(this).closest('.dropdown').one('hide.bs.dropdown', function(e) {
          return false;
        });
      });
						
      this.$element.on('click.ocf', '.disabled, [disabled]', function(e) {		
        e.stopPropagation();
        e.preventDefault();
      });

      var hovered = false;

      this.$element.on({
        'mouseenter': function(e) {
          hovered = true;
        },
        'mouseleave': function(e) {
          hovered = false;

          $('[aria-describedby="' + $(this).attr('id') + '"]').popover('toggle');
        }
      }, '.popover').on('hide.bs.popover', '[aria-describedby^="popover"]', function(e) {
        setTimeout(function(element) {
          $(element).show();
        }, 0, e.target);

        if (hovered) {
          e.preventDefault();
        }
      });

      this.$element.find('.dropdown').on('hide.bs.dropdown', function(e) {
        that.$element.find('[aria-describedby^="popover"]').popover('hide');
      });

      if (this.options.php.manualPrice) {
        /*$('[data-toggle="popover-price"]').popover({
          content: function() {
            return '' +
              '<div class="form-inline">' +
                '<div class="form-group">' +
                  '<input name="price[min]" value="' + $('#price-from').text() + '" type="text" class="form-control input-sm" id="min-price-value" />' +
                '</div>' +
                '<div class="form-group">-</div>' +
                '<div class="form-group">' +
                  '<input name="price[max]" value="' + $('#price-to').text() + '" type="text" class="form-control input-sm" id="max-price-value" />' +
                '</div>' +
              '</div>';
          },
          html: true,
          delay: { 'show': 700, 'hide': 500 },
          placement: 'top',
          container: '#ocfilter',
          title: 'Указать цену',
          trigger: 'hover'
        });*/
				
				this.$summ.bind('keyup', function(e){
					var
						$element = $(this),
						$buttonTarget = $element.closest('.summ'),
						min_price = $('input[name=\'price[min]\']').val().split(' ').join(''),
						max_price = $('input[name=\'price[max]\']').val().split(' ').join('');

					//if (event.keyCode == 13 && $('input[name=\'price[min]\']').val().length >= 0 && $('input[name=\'price[min]\']').val().length > 0) {
						that.options.php.params = 'p:' + min_price + '-' + max_price;
						that.update($buttonTarget);
						
						var data = {
							'change_currencys' : $("select[name='currencys']").val(),
							'path' : $("input[name='path']").val(),
							'filter_ocfilter' : filter_ocfilter
						};
							
						$.ajax({
							url: 'index.php?route=extension/module/ocfilter/setCurrencys',
							data: data, 
							success: function(json) {
								var get_min = min_price ? parseFloat(min_price).toLocaleString('ru') : json.sliders.min.toLocaleString('ru');
								var get_max = max_price ? parseFloat(max_price).toLocaleString('ru') : json.sliders.max.toLocaleString('ru');
								
								$('#price-from').html('<span id="price-from">' + get_min + '</span>');
								$('#price-to').html('<span id="price-to">' + get_max + '</span>');
							}
						});
							
						$('#ocfilter .scale').removeAttr('disabled');
					//}
				});
      }

      // Set sliders
      $('#ocfilter .scale').each($.proxy(setSlider, this));
    },
		
		atocom: function($target, $buttonTarget){
			var that = this;

			$($target).autocomplete({
				'source': function(request, response) {
					if (encodeURIComponent(request) != 0) {
						$.ajax({
							url: 'index.php?route=extension/module/ocfilter/autocomplete&option_id=' + $target.attr('data-value-id') + '&filter_name=' +  encodeURIComponent(request) + '&filter_ocfilter=' + encodeURIComponent(filter_ocfilter) + '&path=' + $("input[name='path']").val(),
							dataType: 'json',
							success: function(json) {
								response($.map(json, function(item) {
									return {
										option_id: item.option_id,
										label: item.name,
										value: item.params,
										id: item.id
									};
								}));
							}
						});
					}
				},
				'focus': function( event ) {
					$($target).val(event.label);
					return false;
				},
				'select': function( event ) {
					$($target).val(event.label);
					//console.log($target.nextAll(":hidden").first());
					$buttonTarget.attr('id', 'v-' + event.id);

					$buttonTarget.toggleClass('ocf-selected', $target.nextAll(":hidden").first().val());

					if(filter_ocfilter){
						$target.nextAll(":hidden").first().val(filter_ocfilter + ';' + event.value);
						
						that.options.php.params = $target.nextAll(":hidden").first().val();
					}else{
						$target.nextAll(":hidden").first().val(event.value);
						
						var valopt = [];
						
						$('.value-target').each(function() {
							valopt.push($(this).val());
						});

						that.options.php.params = valopt.join(';');
					}

					that.update($buttonTarget);

					return false;
				},
			});
		},
		
		currencys_update: function(){		
			var data = {
				'change_currencys' : $("select[name='currencys']").val(),
				'path' : $("input[name='path']").val(),
				'filter_ocfilter' : filter_ocfilter
			};
				
			$.ajax({
				url: 'index.php?route=extension/module/ocfilter/setCurrencys',
				data: data, 
				success: function(json) {
					var get_min = json.sliders.min_price_get ? json.sliders.min_price_get : json.sliders.min;
					var get_max = json.sliders.max_price_get ? json.sliders.max_price_get : json.sliders.max;
					$('#price-from').html('<span id="price-from">' + json.sliders.min.toLocaleString('ru') + '</span>');
					$('#price-to').html('<span id="price-to">' + json.sliders.max.toLocaleString('ru') + '</span>');
					$('input[name=\'price[min]\']').val(get_min.toLocaleString('ru'));
					$('input[name=\'price[max]\']').val(get_max.toLocaleString('ru'));
					$('.symbol_right').html('<span class="symbol_right">'+json.currencys+'</span>');
				
					//var updateSlider = document.getElementById('scale-price');
					function updateSliderRange(min, max) {
							var
								$element = document.getElementById('scale-price'),
								min = parseFloat(min),
								max = parseFloat(max),
								decimals = 0,
								_options = {
									behaviour: 'drag-tap',
									connect: true,
									range: {
										'min': min,
										'max': max
									}
								};
					
							// Logarithmic scale
							if ((max - min) > 100) {
								_options['pips'] = {
									mode: 'range',
									density: 4
								};
					
								var _i = 25, _strength = 3.5;
					
								if ((max - min) < 100) {
									_strength = 2;
								}
					
								for (; _i < 100; _i += 25) {
									_options['range'][_i + '%'] = Math.ceil(Math.easeIn(((max - min) / 100 * _i), min, max, _strength));
								}
							} else {
								_options['pips'] = {
									mode: 'count',
									values: 3,
									density: 4
								};
							}
							
							_options['format'] = {
								to: function (value) {
									return parseFloat(value).toFixed(decimals);
								},
								from: function (value) {
									return parseFloat(value).toFixed(decimals);
								}
							};
	
							$element.noUiSlider.updateOptions(_options);
					}

					updateSliderRange(json.sliders.min, json.sliders.max);
				}
			});
		},

    update: function(scrollTarget) {
      var
        that = this,
        isSlider = scrollTarget.hasClass('scale'),
        data = {
          path: this.options.php.path,
					currencys: $( "[name=currencys]" ).val(),
          option_id: scrollTarget.data().optionId
        };
				
			//console.log(data);
      if (this.options.php.params) {
        data[this.options.php.index] = this.options.php.params;
      }

      this.preload();

      $.get('index.php?route=extension/module/ocfilter/callback', data, function(json) {
        /* Start update */
        for (var i in json.values) {
          var value = json.values[i],
            target = $(that.values['v-' + i]),
            total = value.t,
            selected = value.s,
            params = value.p;
						
					//
          if (target.length > 0) {
            if (target.is('label')) {
              if (total === 0 && !selected) {
                target.addClass('disabled').removeClass('ocf-selected').find('input').attr('disabled', true).prop('checked', false);
              } else {
                target.removeClass('disabled').find('input').removeAttr('disabled');
              }

              $('input', target).val(params);

              if (that.options.php.showCounter) {
                $('small', target).text(total);
              }
            } else {
              target.prop('disabled', (total === 0)).val(params);
            }
          }
        }

        if (json.total === 0) {
          $('#ocfilter-button button').removeAttr('onclick').addClass('disabled').text(that.options.text.select);

          if (typeof scrollTarget != 'undefined' && scrollTarget.hasClass('scale')) {
            $('#ocfilter .scale').removeAttr('disabled');
          }
        } else {
          if (that.options.php.searchButton || isSlider) {
            $('#ocfilter-button button').attr('onclick', 'location = \'' + json.href + '\'').removeClass('disabled').text(json.text_total);

            //$('#ocfilter .scale').removeAttr('disabled');
          } else {
            window.location = json.href;

            return;
          }
        }

        that.$fields.filter('.enabled').removeAttr('disabled');

        if (typeof scrollTarget != 'undefined') {
          that.scroll(scrollTarget);
        }
				
        if (isSlider) {
          scrollTarget.removeAttr('disabled');
        }

        if (!$.isPlainObject(json.sliders) || $.isEmptyObject(json.sliders)) {
          return;
        }
				
				if($('.scale[data-option-id]').length > 1)
        for (var option_id in json.sliders) {
					if ($('.scale[data-option-id="' + option_id + '"]').length > 0) {
						var
							$element = $('.scale[data-option-id="' + option_id + '"]').removeAttr('disabled'),
							slider = $element.get(0).noUiSlider,
							hasParam = that.params.has.call(that, option_id),
							min = parseFloat(json.sliders[option_id]['min']),
							max = parseFloat(json.sliders[option_id]['max']),
							min_value = min,
							max_value = max,
							set = slider.get();
						
						
						if (!$.isArray(set)) {
							set = [set, set];
						}
	
						if (hasParam) {
							if (set[1] <= max) {
								max_value = set[1];
							}
	
							if (set[0] >= min) {
								min_value = set[0];
							}
						}
	
						if (min != max) {
							slider.destroy();
	
							$element.data({
								startMin: min_value,
								startMax: max_value,
								rangeMin: min,
								rangeMax: max
							});
	
							if ($element.data().controlMin && $($element.data().controlMin).length) {
								$($element.data().controlMin).val(min_value.toLocaleString('ru'));
							}
	
							if ($element.data().controlMax && $($element.data().controlMax).length) {
								$($element.data().controlMax).val(max_value.toLocaleString('ru'));
							}
	
							if ($element.data().elementMin && $($element.data().elementMin).length) {
								$($element.data().elementMin).html(min_value.toLocaleString('ru'));
							}
	
							if ($element.data().elementMax && $($element.data().elementMax).length) {
								$($element.data().elementMax).html(max_value.toLocaleString('ru'));
							}
	
							setSlider.call(that, 0, $element.get(0));
						} else {
							$element.attr('disabled', 'disabled');
						}
					}
        }
        /* End update */
      }, 'json');
    },

    params: {
      decode: function() {
        var params = {};
        if (this.options.php.params) {
          var matches = this.options.php.params.split(';');
          for (var i = 0; i < matches.length; i++) {
            var parts = matches[i].split(':');
            params[parts[0]] = typeof parts[1] != 'undefined' ? parts[1].split(',') : [];
          }
        }
        this.options.php.params = params;
      },

      encode: function() {
        var params = [];
        if (this.options.php.params) {
          for (i in this.options.php.params) {
            params.push(i + ':' + (typeof this.options.php.params[i] == 'object' ? this.options.php.params[i].join(',') : this.options.php.params[i]));
          }
        }
        this.options.php.params = params.join(';');
      },

      set: function(option_id, value_id) {
        this.params.decode.call(this);
        if (typeof this.options.php.params[option_id] != 'undefined') {
          this.options.php.params[option_id].push(value_id);
        } else {
          this.options.php.params[option_id] = [value_id];
        }
        this.params.encode.call(this);
      },

      has: function(option_id) {
        this.params.decode.call(this);

        var has = (typeof this.options.php.params[option_id] != 'undefined');

        this.params.encode.call(this);

        return has;
      },

      remove: function(option_id, value_id) {
        this.params.decode.call(this);
        if (typeof this.options.php.params[option_id] != 'undefined') {
          if (this.options.php.params[option_id].length === 1 || !value_id) {
            delete this.options.php.params[option_id];
          } else {
            this.options.php.params[option_id].splice(ocfilter.options.php.params[option_id].indexOf(value_id), 1);
          }
        }
        this.params.encode.call(this);
      }
    },

    preload: function() {
      if ($('.ocfilter-option-popover').length) {
        $('.ocfilter-option-popover button').button('loading');
      }
		
      this.$element.find('.scale').attr('disabled', 'disabled');
      setTimeout(function(that) {
        that.$values.addClass('disabled').find('small').text('0');
      }, 10, this);
    },

    scroll: function(target) {
      var that = this;

      if (target.find('input:checked').length < 1 && target.parent().find('input:checked').length > 0) {
        target = target.parent().find('input:checked:first').parent();
      }

      if (that.options.mobile && target.is('label')) {
        target = target.find('input');
      }

      if (target.is(':hidden')) {
        target = target.parents(':visible:first');
      }

      this.$element
        .find('[aria-describedby^="popover"]')
        .not('[data-toggle="popover-price"]')
        .not(target)
        .popover('destroy');

      if (!target.attr('aria-describedby')) {
        var options = {
          placement: that.options.mobile ? 'bottom' : 'bottom',
          selector: that.options.mobile ? '> input' : false,
          delay: { 'show': 400, 'hide': 600 },
          content: function() {
            return $('#ocfilter-button').html();
          },
          container: that.$element,
          trigger: 'hover',
          html: true
        };

        target.popover(options).popover('show');

        $('#' + target.attr('aria-describedby')).addClass('ocfilter-option-popover');
      } else {
        $('#' + target.attr('aria-describedby') + ' button').replaceWith($('#ocfilter-button').html());
      }
    }
  };

  /* IE6+ */
  if (Object.create === undefined) {
    Object.create = function(object) {
      function f() {};
      f.prototype = object;
      return new f();
    };
  }

  $.fn.ocfilter = function(options) {
    return this.each(function() {
      var $element = $(this);

      if ($element.data('ocfilter')) {
        return $element.data('ocfilter');
      }

      $element.data('ocfilter', Object.create(ocfilter).init(options, $element));
    });
  };
})(jQuery);