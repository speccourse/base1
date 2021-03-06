
&НаСервере
Процедура СгруппироватьТЧНаСервере()
	ТЗ = Объект.Товары.Выгрузить();
	ТЗ.Свернуть("Номенклатура", "Количество");
	Объект.Товары.Загрузить(ТЗ);
КонецПроцедуры

&НаКлиенте
Процедура СгруппироватьТЧ(Команда)        
	СгруппироватьТЧНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	Товар = Элементы.Товары.ТекущиеДанные.Номенклатура;
	Элементы.Товары.ТекущиеДанные.Цена = ПолучитьЦену(Товар);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьЦену(Товар)
	//Возврат Товар.ЦенаПродажи;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|	ВЫБРАТЬ
	|	ЦенаПродажи
	|ИЗ
	|	Справочник.Номенклатура
	|ГДЕ
	|	Ссылка = &АБВ";
	
	Запрос.УстановитьПараметр("АБВ", Товар); 
	РезультатЗапроса = Запрос.Выполнить();

	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	КонецЕсли; 
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.ЦенаПродажи;
	
КонецФункции

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	РассчитатьСумму(Элементы.Товары.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	РассчитатьСумму(Элементы.Товары.ТекущиеДанные);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьСумму(Стр)
	Стр.Сумма = Стр.Цена * Стр.Количество;
КонецПроцедуры