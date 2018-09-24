<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-affiliate" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($error_success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle "></i> <?php echo $error_success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="" method="post" enctype="multipart/form-data" id="form-affiliate" class="form-horizontal col-sm-6">

          <div class="form-group">
            <label class="col-sm-6 control-label" for="active"><?php echo $options_lang['active']; ?></label>
            <div class="col-sm-6">
              <select name="active" id="active" class="form-control">
                <?php if ($active) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-image"><?php echo $options_lang['image']; ?></label>
            <div class="col-sm-6">
              <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?=$thumb;?>" alt="" title="" data-placeholder="<?=$placeholder;?>"/></a>
              <input type="hidden" name="image" value="<?php echo $options['image']; ?>" id="input-image"/>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="zoom"><?php echo $options_lang['zoom']; ?></label>
            <div class="col-sm-6">
              <select name="zoom" id="zoom" class="form-control">
                <option value="0.1"<?=($options['zoom'] == '0.1')?' selected="seleted"':'';?>>0.1</option>
                <option value="0.2"<?=($options['zoom'] == '0.2')?' selected="seleted"':'';?>>0.2</option>
                <option value="0.3"<?=($options['zoom'] == '0.3')?' selected="seleted"':'';?>>0.3</option>
                <option value="0.4"<?=($options['zoom'] == '0.4')?' selected="seleted"':'';?>>0.4</option>
                <option value="0.5"<?=($options['zoom'] == '0.5')?' selected="seleted"':'';?>>0.5</option>
                <option value="0.6"<?=($options['zoom'] == '0.6')?' selected="seleted"':'';?>>0.6</option>
                <option value="0.7"<?=($options['zoom'] == '0.7')?' selected="seleted"':'';?>>0.7</option>
                <option value="0.8"<?=($options['zoom'] == '0.8')?' selected="seleted"':'';?>>0.8</option>
                <option value="0.9"<?=($options['zoom'] == '0.9')?' selected="seleted"':'';?>>0.9</option>
                <option value="1.0"<?=($options['zoom'] == '1.0')?' selected="seleted"':'';?>>1.0</option>
                <option value="1.1"<?=($options['zoom'] == '1.1')?' selected="seleted"':'';?>>1.1</option>
                <option value="1.2"<?=($options['zoom'] == '1.2')?' selected="seleted"':'';?>>1.2</option>
                <option value="1.3"<?=($options['zoom'] == '1.3')?' selected="seleted"':'';?>>1.3</option>
                <option value="1.4"<?=($options['zoom'] == '1.4')?' selected="seleted"':'';?>>1.4</option>
                <option value="1.5"<?=($options['zoom'] == '1.5')?' selected="seleted"':'';?>>1.5</option>
                <option value="1.6"<?=($options['zoom'] == '1.6')?' selected="seleted"':'';?>>1.6</option>
                <option value="1.7"<?=($options['zoom'] == '1.7')?' selected="seleted"':'';?>>1.7</option>
                <option value="1.8"<?=($options['zoom'] == '1.8')?' selected="seleted"':'';?>>1.8</option>
                <option value="1.9"<?=($options['zoom'] == '1.9')?' selected="seleted"':'';?>>1.9</option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="pos_x_center"><?php echo $options_lang['pos_x_center']; ?></label>
            <div class="col-sm-6">
              <select name="pos_x_center" id="pos_x_center" class="form-control">
                <?php if ($options['pos_x_center']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group pos_x">
            <label class="col-sm-6 control-label" for="pos_x"><?php echo $options_lang['pos_x']; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pos_x" id="pos_x" class="form-control" value="<?=$options['pos_x'];?>">
            </div>px
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="pos_x_center"><?php echo $options_lang['pos_y_center']; ?></label>
            <div class="col-sm-6">
              <select name="pos_y_center" id="pos_y_center" class="form-control">
                <?php if ($options['pos_y_center']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group pos_y">
            <label class="col-sm-6 control-label" for="pos_y"><?php echo $options_lang['pos_y']; ?></label>
            <div class="col-sm-5">
              <input type="text" name="pos_y" id="pos_y" class="form-control" value="<?=$options['pos_y'];?>">
            </div>px
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="opacity"><?php echo $options_lang['opacity']; ?></label>
            <div class="col-sm-6">
              <select name="opacity" id="opacity" class="form-control">
                <option value="0.1"<?=($options['opacity'] == '0.1')?' selected="seleted"':'';?>>0.1</option>
                <option value="0.2"<?=($options['opacity'] == '0.2')?' selected="seleted"':'';?>>0.2</option>
                <option value="0.3"<?=($options['opacity'] == '0.3')?' selected="seleted"':'';?>>0.3</option>
                <option value="0.4"<?=($options['opacity'] == '0.4')?' selected="seleted"':'';?>>0.4</option>
                <option value="0.5"<?=($options['opacity'] == '0.5')?' selected="seleted"':'';?>>0.5</option>
                <option value="0.6"<?=($options['opacity'] == '0.6')?' selected="seleted"':'';?>>0.6</option>
                <option value="0.7"<?=($options['opacity'] == '0.7')?' selected="seleted"':'';?>>0.7</option>
                <option value="0.8"<?=($options['opacity'] == '0.8')?' selected="seleted"':'';?>>0.8</option>
                <option value="0.9"<?=($options['opacity'] == '0.9')?' selected="seleted"':'';?>>0.9</option>
                <option value="1.0"<?=($options['opacity'] == '1.0')?' selected="seleted"':'';?>>1.0</option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="category_image"><?php echo $options_lang['category_image']; ?></label>
            <div class="col-sm-6">
              <select name="category_image" id="category_image" class="form-control">
                <?php if ($options['category_image']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="product_thumb"><?php echo $options_lang['product_thumb']; ?></label>
            <div class="col-sm-6">
              <select name="product_thumb" id="product_thumb" class="form-control">
                <?php if ($options['product_thumb']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="product_popup"><?php echo $options_lang['product_popup']; ?></label>
            <div class="col-sm-6">
              <select name="product_popup" id="product_popup" class="form-control">
                <?php if ($options['product_popup']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="product_list"><?php echo $options_lang['product_list']; ?></label>
            <div class="col-sm-6">
              <select name="product_list" id="product_list" class="form-control">
                <?php if ($options['product_list']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-6 control-label" for="product_banner">Banner</label>
            <div class="col-sm-6">
              <select name="product_banner" id="product_banner" class="form-control">
                <?php if ($options['product_banner']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-6 control-label" for="product_additional"><?php echo $options_lang['product_additional']; ?></label>
            <div class="col-sm-6">
              <select name="product_additional" id="product_additional" class="form-control">
                <?php if ($options['product_additional']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="product_related"><?php echo $options_lang['product_related']; ?></label>
            <div class="col-sm-6">
              <select name="product_related" id="product_related" class="form-control">
                <?php if ($options['product_related']) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>


        <div class="col-sm-6">
          <div class="image-test">
            <img src="/image/<?=$options['image'];?>" alt="watermark" />
          </div>
        </div>

        <style>
          .image-test{
            min-height: 100px;
            background: #EEE;
            margin: 15px;
            border-radius: 3px;
            border: 1px solid #CCC;
            position: relative;
            overflow: hidden;
          }
          .image-test img{
            position: absolute;
          }
        </style>

        <script>
          var imgh = 0;
          var imgw = 0;
          function recalc()
          {
            if(!imgw) imgw = $('.image-test img').width();
            if(!imgh) imgh = $('.image-test img').height();
            var zoom = $('select[name=zoom]').val();
            var pos_x = parseInt($('input[name="pos_x"]').val());
            var pos_x_center = parseInt($('select[name="pos_x_center"]').val());
            var pos_y = parseInt($('input[name="pos_y"]').val());
            var pos_y_center = parseInt($('select[name="pos_y_center"]').val());
            var opacity = $('select[name=opacity]').val();
            var width = imgw * zoom;
            var height = imgh * zoom;

            if(pos_x_center == 1)
            {
              $('.pos_x').slideUp(200);
            }
            else
            {
              $('.pos_x').slideDown(200);
            }

            if(pos_y_center == 1)
            {
              $('.pos_y').slideUp(200);
            }
            else
            {
              $('.pos_y').slideDown(200);
            }

            options = {
                'opacity': opacity,
                'width': width + "px",
                'height': height + "px"
              };
            if(pos_x >= 0)
            {
              $('.image-test img').css('right', 'inherit');
              options.left = pos_x + 'px';
            }
            else if(!pos_x_center)
            {
              $('.image-test img').css('left', 'inherit');
              options.right = (-1*pos_x) + 'px';
            }

            if(pos_y >= 0)
            {
              $('.image-test img').css('bottom', 'inherit');
              options.top = pos_y + 'px';
            }
            else if(!pos_y_center)
            {
              $('.image-test img').css('top', 'inherit');
              options.bottom = (-1*pos_y) + 'px';
            }

            if(pos_x_center)
            {
              $('.image-test img').css('right', 'inherit');
              options.left = (parseInt($('.image-test').width()) / 2 - width / 2);
            }

            if(pos_y_center)
            {
              $('.image-test img').css('bottom', 'inherit');
              options.top = (parseInt($('.image-test').height()) / 2 - height / 2);
            }

            console.log(options);

            $('.image-test img').animate(options, 500);

          }

          var imgo = $('.image-test img').attr('src');
          function test_image()
          {
            if( ("/image/" + $('input[name=image]').val()) != imgo)
            {
              $('.image-test img').attr('src', "/image/" + $('input[name=image]').val());
              $('.image-test img').css({ width: 'auto', height: 'auto' });
              setTimeout(function(){
                imgw = $('.image-test img').width();
                imgh = $('.image-test img').height();
                imgo = "/image/" + $('input[name=image]').val();
                recalc();
              },500);
            }
          }

          function start()
          {
            var width = $('.image-test').width();
            height = width - 100;
            if(width > 500){
              width = height = 500;
            }
            $('.image-test').animate({'height': (height) + 'px', 'width': (width) + 'px'},0);
            recalc();
            $('select, input').change(function(){ recalc(); });
            $('input').keyup(function(){ recalc(); });
            setInterval("test_image();", 200);
          }


          $(document).ready(function(){
            setTimeout('start();', 600);
          });
        </script>

      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>