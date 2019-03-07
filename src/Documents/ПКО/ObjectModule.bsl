
Процедура ОбработкаПроведения(Отказ, Режим)
	Движения.Взаиморасчеты.Записывать = Истина;
	Движение = Движения.Взаиморасчеты.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
	Движение.Период = Дата;
	Движение.Контрагент = Контрагент;
	Движение.Сумма = Сумма;
	
	Движения.Касса.Записывать = Истина;
	Движение = Движения.Касса.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.Сумма = Сумма;

///////////////БУХ УЧЕТ

Если Валюта.Пустая() Тогда
	Касса = ПланыСчетов.ПланСчетов.Касса;
	Курс = 1;
Иначе
	Касса = ПланыСчетов.ПланСчетов.КассаВВалюте;
	СрезПоследних = РегистрыСведений.КурсыВалют.СрезПоследних(Дата, Новый Структура("Валюта", Валюта));
	Курс = СрезПоследних[0].Курс; 
КонецЕсли; 

    Движения.РегистрБухгалтерии.Записывать = Истина;
	Проводка = Движения.РегистрБухгалтерии.Добавить();
	Проводка.Период = Дата;
	Проводка.СчетДт = Касса;
	Проводка.СчетКт = ПланыСчетов.ПланСчетов.Покупатели;
	Проводка.СубконтоКт.Контрагенты = Контрагент;
	
Если Касса.Валютный Тогда
	Проводка.ВалСуммаДт = Сумма;
	Проводка.ВалютаДт = Валюта;
КонецЕсли; 

Если КорСчет.Валютный Тогда
	Проводка.ВалСуммаКт = Сумма;
	Проводка.ВалютаКт = Валюта;	
КонецЕсли; 


	Проводка.Сумма = Сумма * Курс;
	
КонецПроцедуры
