<table width="100%" cellpadding="10">
    <tbody>
        <tr>
            <td style="width:20mm"><a href="<?php echo $href;  ?>"><img src="<?php echo $thumb;  ?>" height="20mm" alt="<?php echo $heading_title;  ?>"></a></td>
            <td valign="middle" style="width:20mm">№ <?php echo $model;  ?></td>
            <td valign="middle" style="width:70mm"><a href="<?php echo $href;  ?>"><?php echo $heading_title;  ?></a></td>
            <td valign="middle" style="font-weight:bold; width:60mm">
                <?php if ($price || $rub) { ?>
                    <?php if (!$special) { ?>
                    <strong><?php echo $price; ?></strong><br>
                    <strong><?php echo $rub; ?></strong>
                    <?php } else { ?>
                    <span class="price-new"><?php echo $special; ?></span> <sup><strike><?php echo $price; ?></strike></sup>
                    <?php } ?>
                <?php } ?>
            </td>
        </tr>
    </tbody>
</table>