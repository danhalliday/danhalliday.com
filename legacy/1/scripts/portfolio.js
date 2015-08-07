$(document).ready( function () {
	portfolio.initialise();
});

$(window).load( function () {
	portfolio.reveal();
});

var portfolio = {

	container: null,
	articles: null,
	filters: null,

	initialise: function () {
		this.container = $('#portfolio');
		this.articles = this.container.find('article');
		this.filters = $('nav a');
		this._setupIsotope();
		this._setupClicks();
		this._setupFilters();
	},

	reveal: function () {
		$('#loading').fadeOut(2500, 'easeInOutQuint');
	},

	_setupIsotope: function () {
		this.container.isotope({
			animationEngine: 'best-available',
			animationOptions: {
				duration: 1200,
				easing: 'easeInOutQuint',
				queue: false
			},
			itemSelector: "article",
			masonry: {
				columnWidth : 160
			}
		});
	},

	_setupClicks: function () {
		this.articles.click(function(){
			$('#portfolio article').not($(this)).removeClass('expanded');
			$(this).toggleClass('expanded');
			$('#portfolio').isotope('reLayout');
		});
	},

	_setupFilters: function () {
		this.filters.click( function () {
			$('nav a').not($(this)).removeClass('selected');
			$(this).addClass('selected');
			//$('article').addClass('full');
			$('article').removeClass('expanded');
			$('#portfolio').isotope({ filter: $(this).attr('filter') });
			$('#cancelfilters a').show();
			return false;
		});
		$('#cancelfilters a').click( function () {
			$(this).removeClass('selected').hide();
			//$('article').removeClass('full');
			$('#portfolio').isotope('reLayout');
		});
	}

};