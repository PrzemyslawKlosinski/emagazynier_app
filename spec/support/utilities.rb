	#metoda pomocnicza do podstawiania tytulu (jak w helperze) 
	def caly_tytul(page_title)
		poczatek_tytulu = "EMagazynier"
		if(page_title.empty?)
			return poczatek_tytulu
		else
			return "#{poczatek_tytulu} | #{page_title}"
		end
	end