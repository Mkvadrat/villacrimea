<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title;  ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>-->
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="catalog/view/theme/villacrimea/js/jquery.fancybox.min.js"></script>
<script src="catalog/view/theme/villacrimea/js/owl.carousel.min.js"></script>
<script src="catalog/view/theme/villacrimea/js/jquery.dotdotdot.js"></script>
<script src="catalog/view/theme/villacrimea/js/jquery.mmenu.all.js"></script>
<script src="catalog/view/theme/villacrimea/js/sweetalert.min.js"></script>
<script src="catalog/view/theme/villacrimea/js/printThis.js"></script>
<script src="https://cdn.rawgit.com/leafo/sticky-kit/v1.1.2/jquery.sticky-kit.min.js"></script>
<script src="http://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>

<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/nomalize.css">
<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/jquery.mmenu.all.css">
<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/sweetalert.css">
<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/owl.carousel.min.css">
<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/owl.theme.default.min.css">
<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/jquery.fancybox.min.css">
<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/stylesheet.css">
<link rel="stylesheet" href="catalog/view/theme/villacrimea/stylesheet/media.css">

<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/theme/villacrimea/js/common.js"></script>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
</head>
  <body>
  <nav id="menu">
    <ul>
      <li><a href="#">О нас</a></li>
      <li><a href="#">Услуги</a></li>
      <li><a href="#">Кейсы</a></li>
      <li><a href="#">Блог</a></li>
      <li><a href="#">Контакты</a></li>
      <li><a href="#">Отзывы на Яндексе</a></li>                    
    </ul>
  </nav>
  <div class="page">
    <header>
      <div class="header_left_side">
          <?php echo $short_descr; ?>
          <a class="mobile telephone" href="tel:88006000019">8 (800) 600-00-19</a>
          <div>
              <?php if($downloads) { ?>
                <?php foreach($downloads as $download){ ?>
                  <a class="dwnld_presentation" href="<?php echo $download['href'] ?>"><img src="catalog/view/theme/villacrimea/image/pdf.png" alt=""><?php echo $download['name'] ?></a>
                <?php } ?>
              <?php } ?>
              
              <?php echo $search; ?>
          </div>
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
          <a class="mobile mob-menu" href="#menu"><img src="catalog/view/theme/villacrimea/image/menu.png"></a>
      </div>
      <div class="logo" id="print01">
        <?php if ($logo) { ?>
          <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
        <?php } else { ?>
          <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
        <?php } ?>
      </div>
      <div class="header_right_side">
        <?php echo $contact_header; ?>
      </div>
      <a class="mobile callback mob-callback" href="#call_me_back"><img src="catalog/view/theme/villacrimea/image/tel.png"></a>
    </header>    
    <section>