def insertIntoDatabase(menu_hash, restaurant_name)
	restaurant = Restaurant.find_by(name:restaurant_name)

	days = ["SEGUNDA-FEIRA", "TERÇA-FEIRA", "QUARTA-FEIRA", "QUINTA-FEIRA", "SEXTA-FEIRA", "SÁBADO", "DOMINGO"]

	date = menu_hash[:date] # date = Time.new(2015,5,4)

	entries_array = menu_hash[:entries]

	last_index = -1

	# entries_array = [["SEGUNDA-FEIRA", "Arroz/Feijão/Arroz integral", "Almôndega ao sugo", "Purê de batata", "Salada de escarola", "Opcional PVT com ervilhas", "Laranja/refresco", "Valor calórico de refeição kcal"], ["SEGUNDA-FEIRA", "Arroz/Feijão/Arroz integral", "Bife de caçarola", "Abobrinha com tomate", "Salada de acelga", "Opcional PVT à primavera", "Maçã/refresco", "Valor calórico de refeição kcal"], ["TERÇA-FEIRA", "Arroz/Feijão/Arroz integral", "Frango com requeijão", "Chuchu refogado", "Salada de almeirão", "Opcional PVT com moyashi", "Banana/refresco", "Valor calórico de refeição kcal"], ["TERÇA-FEIRA", "Arroz/Feijão/Arroz integral", "Filé de peixe à escabeche", "Legumes mistos", "Salada de alface", "Opcional PVT à escabeche", "Goiabinha/refresco", "Valor calórico de refeição kcal"], ["QUARTA-FEIRA", "Arroz/Feijão Preto/arroz integral", "Bife de contrafilé ao molho vinagrete", "Macarrão ao alho e óleo", "Salada de catalonha", "Opcional PVT com chuchu", "Mexerica/refresco", "Valor calórico de refeição kcal"], ["QUARTA-FEIRA", "Arroz/Feijão/Arroz integral", "Filé de frango grelhado", "Caponata de berinjela", "Salada de almeirão", "Opcional PVT caipira", "Caqui/refresco", "Valor calórico de refeição kcal"], ["QUINTA-FEIRA", "Arroz/Feijão/Arroz integral", "Empanado de frango", "Escarola refogada", "Salada de beterraba", "Opcional PVT com mandioquinha", "Bananinha/refresco", "Valor calórico de refeição kcal"], ["QUINTA-FEIRA", "Arroz/Feijão/Arroz integral", "Carne ao molho de especiarias", "Mandioca sauté", "Salada de alface", "Opcional PVT agridoce", "Caqui/refresco", "Valor calórico de refeição kcal"], ["SEXTA-FEIRA", "Arroz/Feijão preto/Arroz integral", "Iscas de carne à napolitana", "Batata doce corada", "Salada de mostarda", "Opcional PVT com azeitona", "Caqui/refresco", "Valor calórico de refeição kcal"], ["SEXTA-FEIRA", "Arroz/Feijão preto/Arroz integral", "Linguiça acebolada", "Farofa de ovos", "Salada de catalonha", "Opcional PVT com brócolis", "Laranja/refresco", "Valor calórico de refeição kcal"], ["SÁBADO", "Arroz/Feijão/Arroz integral", "Carne assada ao molho roti", "Cenoura com passas", "Salada de acelga", "Opcional PVT com vagem", "Maçã/refresco", "Valor calórico de refeição kcal"], ["DOMINGO", "Arroz/Arroz integral", "Filé de frango à aurora", "Batata palha", "Alho poró à grega", "Salada de alface com tomate cereja", "Opcional PVT à aurora", "Pavê de chocolate/mexerica/refresco", "Valor calórico de refeição kcal"]]

	entries_array.each do |entry_array|
		meal = Meal.find_or_create_by(
			main_course:entry_array[1],
			meat:entry_array[2],
			second_course:entry_array[3],
			salad:entry_array[4],
			optional:entry_array[5],
			desert:entry_array[6],
			)

		index = days.index(entry_array[0])
		period = 'lunch'
		if last_index == index
			period = 'dinner'
		end
		last_index = index

		if index == nil
			p entry_array[0]
		end

		meal_date = (date+(60*60*24*index))

		entry = restaurant.menu_entries.create(meal_date:meal_date, period:period, meal:meal)
	end
end