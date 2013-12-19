$ (function () {
	$(".meg").click(function() {
		$(".meg-description").toggle();
		$(".oren-description").hide();
		$(".kyle-description").hide();
		$(".peter-description").hide();
	    })
	    });
$ (function () {
	$(".oren").click(function() {
		$(".oren-description").toggle();
		$(".meg-description").hide();
		$(".kyle-description").hide();
		$(".peter-description").hide();
	    })
	    });

$(function () {
	$(".peter").click(function() {
		$(".peter-description").toggle()
		$(".oren-description").hide();
		$(".kyle-description").hide();
		$(".meg-description").hide();
	    })
    });

$(function() {
	$(".kyle").click(function() {
		$(".kyle-description").toggle();
		$(".oren-description").hide();
		$(".meg-description").hide();
		$(".peter-description").hide();
	    })
    });
