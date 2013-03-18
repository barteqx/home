$(document).ready(function() {
		$(".menuitem").hover(
			function (){
				if ($(document).width() >= 768) {
					$(this).stop(true); 
					$(this).animate({
					height: '210'
					},
					function() {
						$(this).children(".label").fadeIn("fast");
						}
					);
				}
			},
			function() {
				if ($(document).width() >= 768) {
					$(this).stop(true); 
					$(this).children(".label").fadeOut("fast",  
						function() { 
							$(this).parent(".menuitem").animate({
							height: '40'
							});
						});
				}
			}
	);
});