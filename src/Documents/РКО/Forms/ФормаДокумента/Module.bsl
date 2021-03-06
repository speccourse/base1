
&НаСервереБезКонтекста
функция ПослеЗаписиНаСервере(Ссылка)
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КассаОстатки.СуммаОстаток
		|ИЗ
		|	РегистрНакопления.Касса.Остатки(&МоментВремени, ) КАК КассаОстатки
		|ГДЕ
		|	КассаОстатки.СуммаОстаток < 0";
	
	Запрос.УстановитьПараметр("МоментВремени", Новый Граница(Ссылка.МоментВремени(), ВидГраницы.Включая) );
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		Возврат -Выборка.СуммаОстаток;
	Иначе
		Возврат 0;
	КонецЕсли; 

	
КонецФункции

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Результат = ПослеЗаписиНаСервере(Объект.Ссылка);
	Если Результат > 0 Тогда
		ПоказатьПредупреждение(, "Денег в кассе минус " + Результат);
	КонецЕсли; 
КонецПроцедуры

