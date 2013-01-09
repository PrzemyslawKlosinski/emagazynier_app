module ApplicationHelper

	#metoda pomocnicza do wformatowania napisu
	def caly_tytul(title)
		poczatek_tytulu = "EMagazynier"
		if(title.empty?)
			return poczatek_tytulu
		else
			return "#{poczatek_tytulu} | #{title}"
		end
	end

end
