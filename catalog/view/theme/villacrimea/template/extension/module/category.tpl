<h1 class="title"><?php echo $heading_title; ?></h1>

<?php if($categories){ ?>
<ul class="categories">
  <?php foreach ($categories as $category) { ?>
    <?php if ($category['children']) { ?>
    <li class="dropdown"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
      <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
      <ul>
        <?php foreach ($children as $child) { ?>
        <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
        <?php } ?>
      </ul>
      <?php } ?>
    </li>
    <?php } else { ?>
    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
    <?php } ?>
  <?php } ?>
</ul>
<?php } ?>