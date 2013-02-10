# encoding: utf-8
module ApplicationHelper

	#metoda pomocnicza do wformatowania napisu
	def caly_tytul(title)
		poczatek_tytulu = "eMagazyn"
		if(title.empty?)
			return poczatek_tytulu
		else
			return "#{poczatek_tytulu} | #{title}"
		end
	end

	# enable i18n in will_paginate
	# include WillPaginate::ViewHelpers
	def will_paginate_with_i18n(collection = nil, options = {})
		# will_paginate collection, options.merge(:previous_label => I18n.t(:previous), :next_label => I18n.t(:next))
		will_paginate collection, options.merge(:previous_label => 'poprzednia strona', :next_label => 'następna strona')
	end

end
