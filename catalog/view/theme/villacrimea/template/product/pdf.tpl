<style>
    @font-face {
        font-family: "GothamPro";
        src: url("/catalog/view/theme/villacrimea/stylesheet/fonts/GothaProReg.otf") format("opentype");
    }
    @font-face {
        font-family: "GothamPro_Bol";
        src: url("/catalog/view/theme/villacrimea/stylesheet/fonts/GothaProBol.otf") format("opentype");
    }
    @font-face {
        font-family: "GothamPro_Med";
        src: url("/catalog/view/theme/villacrimea/stylesheet/fonts/GothaProMed.otf") format("opentype");
    }
    @font-face {
        font-family: "Ubuntu";
        src: url("/catalog/view/theme/villacrimea/stylesheet/fonts/Ubuntu.ttf") format("opentype");
    }
    body {
        margin: 2em;
        font-family: "GothamPro";
        font-size: 18px;
        color: #000;
    }
    .logo a,
    .logo,
    .object_photo {
        width: 100%;
        display: inline-block;
        float: left;
    }
    .logo a {
        border-bottom: 1mm solid #000;
    }
    img {
        width: 17%;
        float: left;
        margin-left: 1.5%;
        margin-right: 1.5%;
        margin-bottom: 3%;
        margin: 0 1.5% 1.5%;
    }
    .logo img {
        width: 50mm
    }
    .main_photo img {
        width: 70%;
        display: block;
        float: none;
        margin: 0 auto;
    }
    .right_side {
        width: 100%;
        display: block;
        float: none;
    }
    .details,
    .object_description {
        margin-bottom: 10mm;
    }
    .title {
        font-size: 36px;
        line-height: 36px;
        font-weight: bolder;
    }
    .object_id {
        font-family: "GothamPro_Bol";
        text-shadow: 1px 0 0 #000;
    }
    .details p {
        font-size: 16px;
    }
    .details p span {
        font-family: "GothamPro_Med";
    }
    .details .title {
        font-family: "Ubuntu";
        font-size: 24px;
        margin: 0;
        font-weight: normal;
    }
</style>

<p class="title" id="print1"><?php echo $heading_title; ?></p>

<div class="object_photo" id="print7">
    <?php if ($popup) { ?>
        <img style="width: 750px;" src="<?php echo $popup; ?>">
    <?php } ?>
</div>

<div class="object_description" id="print8">
    <p class="title">Описание:</p>
    <?php echo $description; ?>
</div>
<span class="object_id" id="print9">№ <?php echo $model; ?></span>

<div class="details" id="print10">
    <p class="title">Детали:</p>
    <?php if ($price || $rub) { ?>
    <?php if (!$special) { ?>
    <p>Цена: <span><?php echo $rub; ?> / <?php echo $price; ?></span></p>
    <?php } else { ?>
    <p>Цена: <span><?php echo $special; ?></span><sup><strike><?php echo $price; ?></strike></sup></p>
    <?php } ?>
    <?php } ?>
    
    <?php if($uniq_options){ ?>
    <?php if($product_options){ ?>
      <?php foreach($product_options as $option){ ?>
      <?php if($option['product_option_value']){ ?>
        <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <p><?php echo $option['name']; ?>: <span><?php echo $option_value['name']; ?></span></p>
        <?php } ?>
      <?php }else{ ?>
          <p><?php echo $option['name']; ?>: <span><?php echo $option['value']; ?></span></p>
      <?php } ?>
      <?php } ?>
    <?php } ?>	
  <?php }else{ ?>
    <?php if($filter_options){ ?>
      <?php foreach($filter_options as $option){ ?>
        <p><?php echo $option['name']; ?>: <span><?php echo $option['value']; ?></span></p>
      <?php } ?>
    <?php } ?>
  <?php } ?>
</div>

<p class="name" id="print2"><?php echo $agent_name; ?></p>

<?php if($specialization){ ?>
<p class="job" id="print3"><?php echo $specialization; ?></p>
<?php } ?>

<?php if($phone){ ?>
<p class="tel" id="print4">Телефон: <a href="tel:<?php echo $phone; ?>"><?php echo $phone; ?></a></p>
<?php } ?>

<p class="tel" id="print5">E-mail: <a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></p>