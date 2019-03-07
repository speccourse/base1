
&НаСервере
Процедура СформироватьНаСервере()
	
	Макет = Отчеты.ОстаткиПартийТоваров1.ПолучитьМакет("Макет");
	ОблШапка = Макет.ПолучитьОбласть("ОблШапка");
	ОблСтрока = Макет.ПолучитьОбласть("ОблСтрока");
	ОблИтоги = Макет.ПолучитьОбласть("ОблИтоги");

	
	ТабДок.Очистить();
	ТабДок.Вывести(ОблШапка);
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	СтоимостьТоваровОстатки.Номенклатура КАК Товар,
	                      |	СтоимостьТоваровОстатки.Партия КАК Партия,
	                      |	СтоимостьТоваровОстатки.КоличествоОстаток КАК Количество,
	                      |	СтоимостьТоваровОстатки.СтоимостьОстаток КАК Стоимость
	                      |ИЗ
	                      |	РегистрНакопления.СтоимостьТоваров.Остатки КАК СтоимостьТоваровОстатки
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	Товар,
	                      |	СтоимостьТоваровОстатки.Партия.МоментВремени УБЫВ
	                      |ИТОГИ
	                      |	СУММА(Количество),
	                      |	СУММА(Стоимость)
	                      |ПО
	                      |	Товар
	                      |АВТОУПОРЯДОЧИВАНИЕ");
	Результат = Запрос.Выполнить();
	ВыборкаИтоги = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаИтоги.Следующий() Цикл
		Выборка = ВыборкаИтоги.Выбрать();
		Пока Выборка.Следующий() Цикл
			ОблСтрока.Параметры.Заполнить(Выборка);
			ТабДок.Вывести(ОблСтрока);
		КонецЦикла; 
		
	    ОблИтоги.Параметры.Заполнить(ВыборкаИтоги);
		ТабДок.Вывести(ОблИтоги);
	КонецЦикла;  
	
КонецПроцедуры

&НаКлиенте
Процедура Сформировать(Команда)
	СформироватьНаСервере();
КонецПроцедуры
