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
		return false;
    });

    // ORDER BUTTON
    $(".bluebox-button-order").bind("click", function() {
    	$(".bluebox-alert-wrapper").fadeOut(250);

		$(this).prop("disabled", true);
		var write_new_address_status = function(arg) {
			if(arg.success) {
				$().text();
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
});