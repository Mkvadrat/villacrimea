<style>
    * {
        all : initial;
    }
    body {
        margin: 2em;
        font-family: "GothamPro";
        font-size: 1em;
        color: #000;
    }
    .details,
    .object_description {
        margin-bottom: 10mm;
    }
    .title {
        font-size: 2em;
        font-weight: bold;
    }
    .object_id {
        font-weight: bold;
        font-family: "GothamPro_Bol";
        text-shadow: 1mm 0 0 #000;
    }
    .details p {
        font-size: 1em;
    }
    .details p span {
        font-family: "GothamPro_Med";
    }
    .details .title {
        font-family: "Ubuntu";
        font-size: 1.5em;
        margin: 20px 0;
        padding: 20px 0;
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
    <?php if($slider_filter_options){ ?>
      <?php foreach($slider_filter_options as $slider_option){ ?>
        <p><?php echo $slider_option['name']; ?>: <span><?php echo $slider_option['value']; ?> <?php echo $slider_option['postfix']; ?></span></p>
      <?php } ?>
    <?php } ?>
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