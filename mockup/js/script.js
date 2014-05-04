// ENTER ITEM NAME
function __inputItemBlur() {
	$("input[name=bluebox-item-description]").blur(function() {
		__arrayItemList = [];
		$("input[name=bluebox-item-description]").each(function() {
			__arrayItemList.push($(this).val());
		});
		$(".bluebox-list-joined").text(__arrayItemList.join(", "));
	});
}

$(document).ready(function() {
    $(".selectpicker").selectpicker();

	// SHIP TO
    $(".bluebox-shipto").bind("change", function(e, ui) {
    	var optionSelected = $("option:selected", this);
        var valueSelected = this.value;
		$(".bluebox-feedback-numboxes").text($(".bluebox-numboxes option:selected").text());
		$(".bluebox-feedback-shipto").text($(".bluebox-shipto option:selected").text());

        if(valueSelected == "9999") {
         	$(".bluebox-newaddress").css("opacity", 0).slideDown(500).animate({opacity: 1}, {queue: false, duration: 250});
        } else {
         	$(".bluebox-newaddress").css("opacity", 1).slideUp(500).animate({opacity: 0}, {queue: false, duration: 250});
        }
    });

    // NAV MENU
    $(".bluebox-nav-lowermenu li").bind("click", function() {
		$(this).addClass("bluebox-active").siblings().removeClass("bluebox-active");
    });

    // ORDER BUTTON
    $(".bluebox-button-order").bind("click", function() {
		// Get Box items data
		__json_order_data = [
		    {numBoxes   : parseInt($(".bluebox-numboxes option:selected").text().split(" ")[0])}
		,   {shipToName : $(".bluebox-shipto option:selected").text()}
		,   {streetAddr1: $("input[name=bluebox-street-1]").val()}
		,   {streetAddr2: $("input[name=bluebox-street-2]").val()}
		,   {city       : $("input[name=bluebox-city]").val()}
		,   {state      : $("select[name=bluebox-state] option:selected").val()}
		,   {zipCode    : $("input[name=bluebox-zip]").val()}
		];

    	$(".bluebox-alert-wrapper").fadeOut(250);
		$(this).prop("disabled", true);
		var write_new_address_status = function(arg) {
			if(arg.success) {
				$(".bluebox-order-data").slideUp(function() {
					$(".bluebox-alert-success").fadeIn(250);
					$(".bluebox-alert-danger").fadeOut(250);
				});
			} else {
				$(".bluebox-alert-success").fadeOut(250);
				$(".bluebox-alert-danger").fadeIn(250);
				$(this).prop("disabled", false);
			}
	    };

		write_new_address_status({success: true});
		return false;
	});

    // SHIP BUTTON
    $(".bluebox-button-ship").bind("click", function() {
		// Get Box items data
		__item_descriptions = [];
		$("input[name=bluebox-item-description]").each(function() {
		    __item_descriptions.push($(this).val());
		});
		__json_ship_data = [
		    {boxName : $("input[name=bluebox-boxname]").val()}
		,   {boxValue: $("input[name=bluebox-value]").val()}
		,   {boxItems: __item_descriptions.join(", ")}
		];

    	$(".bluebox-alert-wrapper").fadeOut(250);
		$(this).prop("disabled", true);

		var write_new_address_status = function(arg) {
			if(arg.success) {
				$(".bluebox-order-data").slideUp(function() {
					$(".bluebox-alert-success").fadeIn(250);
					$(".bluebox-alert-danger").fadeOut(250);
				});
			} else {
				$(".bluebox-alert-success").fadeOut(250);
				$(".bluebox-alert-danger").fadeIn(250);
				$(this).prop("disabled", false);
			}
	    };

		write_new_address_status({success: true});
		return false;
	});

	// ENTER BOX NAME
	$("input[name=bluebox-boxname]").blur(function() {
		$(".bluebox-feedback-boxname").text($(this).val());
	});
	__inputItemBlur();

	// ADD ITEM BUTTON
    $(".bluebox-button-additem").click(function(e){
        e.preventDefault();
        __newItem = $('<div class="bluebox-itemlist-spacer">&nbsp;</div><input autocomplete="off" class="span3" name="bluebox-item-description" type="text" placeholder="optional"/>');
        $(".bluebox-itemlist:last").after(__newItem);
		__inputItemBlur();
		$("input[name=bluebox-item-description]:last").focus();
    });

	if($("input[name=bluebox-boxname]").length > 0) {
		$("input[name=bluebox-boxname]").focus();
	}
});