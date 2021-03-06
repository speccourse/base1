Процедура РассчитатьЗаписи(Регистратор, ПериодРегистрации) Экспорт
	
	НаборЗаписей = РегистрыРасчета.ЖурналНачислений.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписей.Прочитать(); 
	
	СписокПриоритетов = ПолучитьСписокПриоритетов(Регистратор, "РегистрРасчета.ЖурналНачислений");
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЖурналНачисленийДанныеГрафика.НомерСтроки КАК НомерСтроки,
	|	ЖурналНачисленийДанныеГрафика.Сторно КАК Сторно,
	|	ЖурналНачисленийДанныеГрафика.Параметр КАК Параметр,
	|	ЖурналНачисленийДанныеГрафика.ПризнакПериодДействия КАК ПризнакПериодДействия,
	|	ЖурналНачисленийДанныеГрафика.ПризнакФактическийПериодДействия КАК ПризнакФактическийПериодДействия,
	|	ЖурналНачисленийДанныеГрафика.ПризнакБазовыйПериод КАК ПризнакБазовыйПериод,
	|	ЖурналНачисленийДанныеГрафика.ПризнакПериодРегистрации КАК ПризнакПериодРегистрации,
	|	ЖурналНачисленийДанныеГрафика.ВидРасчета.УчитываетОтработанныеДни КАК ВидРасчетаУчитываетОтработанныеДни,
	|	ЖурналНачисленийДанныеГрафика.ВидРасчета.СпособРасчета КАК СпособРасчета,
	|	ДанныеТабеляОбороты.КолДнейОборот КАК КолДнейПоТабелю,
	|	ЖурналНачисленийДанныеГрафика.КолЧасовФактическийПериодДействия КАК КолЧасовФактическийПериодДействия
	|ПОМЕСТИТЬ ДанныеГрафика
	|ИЗ
	|	РегистрРасчета.ЖурналНачислений.ДанныеГрафика(
	|			Регистратор = &Регистратор
	|				И ПериодРегистрации = &ПериодРегистрации) КАК ЖурналНачисленийДанныеГрафика
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ДанныеТабеля.Обороты(&НачалоМесяца, &КонецМесяца, , ) КАК ДанныеТабеляОбороты
	|		ПО ЖурналНачисленийДанныеГрафика.Сотрудник = ДанныеТабеляОбороты.Сотрудник";
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	Запрос.УстановитьПараметр("ПериодРегистрации", ПериодРегистрации);
	Запрос.УстановитьПараметр("НачалоМесяца", НачалоМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("КонецМесяца", КонецМесяца(ПериодРегистрации));
	МассивИзмерений = Новый Массив(2);
	МассивИзмерений [0] = "Сотрудник";
	МассивИзмерений [1] = "Подразделение";
	Запрос.УстановитьПараметр("МассивИзмерений", МассивИзмерений); 
	
	Запрос.Выполнить();
	
	Для каждого Приоритет Из СписокПриоритетов Цикл
		
		Запрос.Текст = "ВЫБРАТЬ
		|	ДанныеГрафика.НомерСтроки КАК НомерСтроки,
		|	ДанныеГрафика.Сторно КАК Сторно,
		|	ДанныеГрафика.Параметр КАК Параметр,
		|	ДанныеГрафика.ПризнакПериодДействия КАК ПризнакПериодДействия,
		|	ДанныеГрафика.ПризнакФактическийПериодДействия КАК ПризнакФактическийПериодДействия,
		|	ДанныеГрафика.КолЧасовФактическийПериодДействия КАК КолЧасовФактическийПериодДействия,
		|	ДанныеГрафика.ПризнакБазовыйПериод КАК ПризнакБазовыйПериод,
		|	ДанныеГрафика.ПризнакПериодРегистрации КАК ПризнакПериодРегистрации,
		|	ДанныеГрафика.ВидРасчетаУчитываетОтработанныеДни КАК ВидРасчетаУчитываетОтработанныеДни,
		|	ДанныеГрафика.СпособРасчета КАК СпособРасчета,
		|	ЕСТЬNULL(ЖурналНачисленийБазаЖурналНачислений.СуммаБаза, 0) КАК СуммаБаза,
		|	ЕСТЬNULL(ЖурналНачисленийБазаЖурналНачислений.ОтработаноДнейБаза, 0) КАК ОтработаноДнейБаза,
		|	ДанныеГрафика.КолДнейПоТабелю КАК КолДнейПоТабелю
		|ИЗ
		|	ДанныеГрафика КАК ДанныеГрафика
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ЖурналНачислений.БазаЖурналНачислений(
		|				&МассивИзмерений,
		|				&МассивИзмерений,
		|				,
		|				Регистратор = &Регистратор
		|					И ПериодРегистрации = &ПериодРегистрации
		|					И ВидРасчета.Приоритет = &Приоритет) КАК ЖурналНачисленийБазаЖурналНачислений
		|		ПО ДанныеГрафика.НомерСтроки = ЖурналНачисленийБазаЖурналНачислений.НомерСтроки";
		Запрос.УстановитьПараметр("Приоритет", Приоритет); 
		РезультатЗапроса = Запрос.Выполнить();
		
		
		Выборка = РезультатЗапроса.Выбрать();
		СтруктураПоиска = Новый Структура("НомерСтроки",);
		
		Для каждого Запись Из НаборЗаписей Цикл
			
			СтруктураПоиска.НомерСтроки = Запись.НомерСтроки;
			
			Если НЕ Выборка.НайтиСледующий(СтруктураПоиска) Тогда
				Запись.Сумма = 0;
				Запись.ОтработаноДней = 0;
			Иначе
				
				База = Выборка.СуммаБаза;
				ФактДней = Выборка.ПризнакФактическийПериодДействия;
				НормаДней = Выборка.ПризнакПериодДействия;
				ДнейВБазе =  Выборка.ОтработаноДнейБаза;
				УчитываетОтработанныеДни = Выборка.ВидРасчетаУчитываетОтработанныеДни;
				КолДнейПоТабелю = Выборка.КолДнейПоТабелю;
				СпособРасчета = Выборка.СпособРасчета;
				ФактЧасов =Выборка.КолЧасовФактическийПериодДействия;
				
				Если СпособРасчета = Перечисления.СпособыРасчета.ФиксированнойСуммой Тогда
					Запись.Сумма = Запись.Параметр;	
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.Процентом Тогда 
					Запись.Сумма = База * Запись.Параметр / 100;
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ЗаОтработанныеДни Тогда 			
					Запись.Сумма = ФактДней * Запись.Параметр;
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ЗаОтработанныеЧасы Тогда 			
					Запись.Сумма = ФактЧасов * Запись.Параметр;
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ПоТабелю Тогда 			
					Запись.Сумма = КолДнейПоТабелю * Запись.Параметр;
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ЗаМесяц Тогда 
					Если НормаДней = 0 Тогда
						Запись.Сумма = 0;
					Иначе
						Запись.Сумма = ФактДней / НормаДней * Запись.Параметр;	
					КонецЕсли; 
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ПоСреднему Тогда 
					Запись.Сумма = ФактДней / ДнейВБазе * База * Запись.Параметр / 100;
				КонецЕсли;
				
				Если УчитываетОтработанныеДни Тогда 	
					Запись.ОтработаноДней = ФактДней;
				КонецЕсли;
				
				Если Запись.Сторно Тогда
					Запись.Сумма = -Запись.Сумма;
					Запись.ОтработаноДней = -Запись.ОтработаноДней;
				КонецЕсли; 
			КонецЕсли; 
			
		КонецЦикла; 
		
		НаборЗаписей.Записать(,,ЛОЖЬ);
	КонецЦикла; 
	
	РассчитатьДопНачисления(Регистратор, ПериодРегистрации);
КонецПроцедуры

Процедура РассчитатьДопНачисления(Регистратор, ПериодРегистрации)
	НаборЗаписей = РегистрыРасчета.ДопНачисления.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписей.Прочитать(); 
	
	СписокПриоритетов = ПолучитьСписокПриоритетов(Регистратор, "РегистрРасчета.ДопНачисления");
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ДопНачисления.НомерСтроки КАК НомерСтроки,
	               |	ДопНачисления.ВидРасчета.СпособРасчета КАК СпособРасчета,
	               |	ДопНачисления.ВидРасчета.Приоритет КАК Приоритет,
	               |	ДопНачисления.Сторно КАК Сторно,
	               |	ДопНачисления.Параметр КАК Параметр,
	               |	ДанныеТабеляОбороты.КолДнейОборот КАК КолДнейОборот
	               |ПОМЕСТИТЬ ДопНачисления
	               |ИЗ
	               |	РегистрРасчета.ДопНачисления КАК ДопНачисления
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ДанныеТабеля.Обороты(&НачалоМесяца, &КонецМесяца, , ) КАК ДанныеТабеляОбороты
	               |		ПО ДопНачисления.Сотрудник = ДанныеТабеляОбороты.Сотрудник
	               |ГДЕ
	               |	ДопНачисления.Регистратор = &Регистратор
	               |	И ДопНачисления.ПериодРегистрации = &ПериодРегистрации
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	НомерСтроки,
	               |	Приоритет";
	
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	Запрос.УстановитьПараметр("ПериодРегистрации", ПериодРегистрации);
	МассивИзмерений = Новый Массив(2);
	МассивИзмерений [0] = "Сотрудник";
	МассивИзмерений [1] = "Подразделение";
	Запрос.УстановитьПараметр("МассивИзмерений", МассивИзмерений); 
	Запрос.УстановитьПараметр("НачалоМесяца", НачалоМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("КонецМесяца", КонецМесяца(ПериодРегистрации));

	
	Запрос.Выполнить();
	
	Для каждого Приоритет Из СписокПриоритетов Цикл
		
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДопНачисления.НомерСтроки КАК НомерСтроки,
		|	ДопНачисления.СпособРасчета КАК СпособРасчета,
		|	ДопНачисления.Приоритет КАК Приоритет,
		|	ДопНачисления.Параметр КАК Параметр,
		|	ДопНачисления.Сторно КАК Сторно,
		|	ЕСТЬNULL(ДопНачисленияБазаДопНачисления.СуммаБаза, 0) + ЕСТЬNULL(ДопНачисленияБазаЖурналНачислений.СуммаБаза, 0) КАК База,
        |	ДопНачисления.КолДнейОборот КАК КолДнейОборот
		|ИЗ
		|	ДопНачисления КАК ДопНачисления
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ДопНачисления.БазаДопНачисления(
		|				&МассивИзмерений,
		|				&МассивИзмерений,
		|				,
		|				Регистратор = &Регистратор
		|					И ПериодРегистрации = &ПериодРегистрации
		|					И ВидРасчета.Приоритет = &Приоритет) КАК ДопНачисленияБазаДопНачисления
		|		ПО ДопНачисления.НомерСтроки = ДопНачисленияБазаДопНачисления.НомерСтроки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ДопНачисления.БазаЖурналНачислений(
		|				&МассивИзмерений,
		|				&МассивИзмерений,
		|				,
		|				Регистратор = &Регистратор
		|					И ПериодРегистрации = &ПериодРегистрации
		|					И ВидРасчета.Приоритет = &Приоритет) КАК ДопНачисленияБазаЖурналНачислений
		|		ПО ДопНачисления.НомерСтроки = ДопНачисленияБазаЖурналНачислений.НомерСтроки
		|ГДЕ
		|	ДопНачисления.Приоритет = &Приоритет";
		
		Запрос.УстановитьПараметр("Приоритет", Приоритет); 
		РезультатЗапроса = Запрос.Выполнить();
		
		Выборка = РезультатЗапроса.Выбрать();
		СтруктураПоиска = Новый Структура("НомерСтроки",);
		
		Для каждого Запись Из НаборЗаписей Цикл
			
			СтруктураПоиска.НомерСтроки = Запись.НомерСтроки;
			
			Если НЕ Выборка.НайтиСледующий(СтруктураПоиска) Тогда
				Запись.Сумма = 0;
			Иначе
				
				База = Выборка.База;
				СпособРасчета = Выборка.СпособРасчета;
				КолДнейПоТабелю = Выборка.КолДнейОборот;
				
				Если СпособРасчета = Перечисления.СпособыРасчета.ФиксированнойСуммой Тогда
					Запись.Сумма = Запись.Параметр;	
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ПоТабелю Тогда 			
					Запись.Сумма = КолДнейПоТабелю * Запись.Параметр;
				ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.Процентом Тогда 
					Запись.Сумма = База * Запись.Параметр / 100;
				КонецЕсли;
				
				Если Запись.Сторно Тогда
					Запись.Сумма = -Запись.Сумма;
				КонецЕсли; 
			КонецЕсли; 
			
		КонецЦикла; 
		
		НаборЗаписей.Записать(,,ЛОЖЬ);
	КонецЦикла; 
	
КонецПроцедуры



Функция ПолучитьСписокПриоритетов(Регистратор, ИмяРегистра)
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЖурналНачислений.ВидРасчета.Приоритет КАК ВидРасчетаПриоритет
	|ИЗ
	|	РегистрРасчета.ЖурналНачислений КАК ЖурналНачислений
	|ГДЕ
	|	ЖурналНачислений.Регистратор = &Регистратор
	|
	|УПОРЯДОЧИТЬ ПО
	|	ВидРасчетаПриоритет";
	
	Если ИмяРегистра <> "РегистрРасчета.ЖурналНачислений" Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрРасчета.ЖурналНачислений", ИмяРегистра);
	КонецЕсли; 
	
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("ВидРасчетаПриоритет");
	
КонецФункции


//Не используем
Процедура РассчитатьЗаписи1(Регистратор) Экспорт
	
	НаборЗаписей = РегистрыРасчета.ЖурналНачислений.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписей.Прочитать(); 
	
	Для каждого Запись Из НаборЗаписей Цикл
		
		Если Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладСуммой Тогда
			Запись.Сумма = Запись.Параметр;	
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ПремияПроцентом Тогда 
			
			МассивРесурсов = Новый Массив(1);
			МассивРесурсов[0] = "ЖурналНачислений.Сумма";
			
			СтруктураИзмерений = Новый Структура();
			СтруктураИзмерений.Вставить("Сотрудник", "ЖурналНачислений.Сотрудник");
			
			ТЗ_База = Запись.ПолучитьБазу(МассивРесурсов, СтруктураИзмерений);
			
			База = ТЗ_База[0].Сумма;
			
			Запись.Сумма = База * Запись.Параметр / 100;
			
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладПоДням Тогда 
			
			ТЗ_ФактДней = Запись.ПолучитьДанныеГрафика(ВидПериодаРегистраРасчета.ФактическийПериодДействия);
			ФактДней = ТЗ_ФактДней[0].Признак;
			
			Запись.Сумма = ФактДней * Запись.Параметр;
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладЗаМесяц Тогда 
			
			ТЗ_ФактДней = Запись.ПолучитьДанныеГрафика(ВидПериодаРегистраРасчета.ФактическийПериодДействия);
			ФактДней = ТЗ_ФактДней[0].Признак;
			ТЗ_НормаДней = Запись.ПолучитьДанныеГрафика(ВидПериодаРегистраРасчета.ПериодДействия);
			НормаДней = ТЗ_НормаДней[0].Признак;
			
			Если НормаДней = 0 Тогда
				Запись.Сумма = 0;
			Иначе
				Запись.Сумма = ФактДней / НормаДней * Запись.Параметр;	
			КонецЕсли; 
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.Больничный Тогда 
			#Область база
			МассивРесурсов = Новый Массив(2);
			МассивРесурсов[0] = "ЖурналНачислений.Сумма";
			МассивРесурсов[1] = "ЖурналНачислений.ОтработаноДней";
			
			СтруктураИзмерений = Новый Структура();
			СтруктураИзмерений.Вставить("Сотрудник", "ЖурналНачислений.Сотрудник");
			
			ТЗ_База = Запись.ПолучитьБазу(МассивРесурсов, СтруктураИзмерений);
			
			База = ТЗ_База[0].Сумма;
			ДнейВБазе = ТЗ_База[0].ОтработаноДней;
			#КонецОбласти 
			
			ТЗ_ФактДней = Запись.ПолучитьДанныеГрафика(ВидПериодаРегистраРасчета.ФактическийПериодДействия);
			ФактДней = ТЗ_ФактДней[0].Признак;
			
			//НЕПРАВИЛЬНО
			//ТЗ_ДнейВБазе = Запись.ПолучитьДанныеГрафика(ВидПериодаРегистраРасчета.БазовыйПериод);
			//ДнейВБазе = ТЗ_ДнейВБазе[0].Признак;
			
			Запись.Сумма = ФактДней / ДнейВБазе * База * Запись.Параметр / 100;
			
		КонецЕсли;
		
		Если Запись.ВидРасчета.УчитываетОтработанныеДни Тогда 
			ТЗ_ФактДней = Запись.ПолучитьДанныеГрафика(ВидПериодаРегистраРасчета.ФактическийПериодДействия);
			ФактДней = ТЗ_ФактДней[0].Признак;
			
			Запись.ОтработаноДней = ФактДней;
		КонецЕсли;
		
		Если Запись.Сторно Тогда
			Запись.Сумма = -Запись.Сумма;
			Запись.ОтработаноДней = -Запись.ОтработаноДней;
		КонецЕсли; 
		
	КонецЦикла; 
	
	НаборЗаписей.Записать();
КонецПроцедуры

Процедура РассчитатьЗаписи2(Регистратор) Экспорт
	
	НаборЗаписей = РегистрыРасчета.ЖурналНачислений.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписей.Прочитать(); 
	
	Отбор = Новый Структура();
	Отбор.Вставить("Регистратор", Регистратор);
	
	ТЗ_ФактДней = РегистрыРасчета.ЖурналНачислений.ПолучитьДанныеГрафика(Отбор, ВидПериодаРегистраРасчета.ФактическийПериодДействия);
	ТЗ_НормаДней = РегистрыРасчета.ЖурналНачислений.ПолучитьДанныеГрафика(Отбор, ВидПериодаРегистраРасчета.ПериодДействия);
	
	МассивРесурсов = Новый Массив(2);
	МассивРесурсов[0] = "ЖурналНачислений.Сумма";
	МассивРесурсов[1] = "ЖурналНачислений.ОтработаноДней";
	
	СтруктураИзмерений = Новый Структура();
	СтруктураИзмерений.Вставить("Сотрудник", "ЖурналНачислений.Сотрудник");
	
	ТЗ_База = РегистрыРасчета.ЖурналНачислений.ПолучитьБазу(Отбор, МассивРесурсов, СтруктураИзмерений);
	
	Для каждого Запись Из НаборЗаписей Цикл
		
		Индекс = НаборЗаписей.Индекс(Запись);
		База = ТЗ_База[Индекс].Сумма;
		ФактДней = ТЗ_ФактДней[Индекс].Признак;
		НормаДней = ТЗ_НормаДней[Индекс].Признак;
		ДнейВБазе = ТЗ_База[Индекс].ОтработаноДней;
		
		
		Если Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладСуммой Тогда
			Запись.Сумма = Запись.Параметр;	
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ПремияПроцентом Тогда 
			Запись.Сумма = База * Запись.Параметр / 100;
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладПоДням Тогда 			
			Запись.Сумма = ФактДней * Запись.Параметр;
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладЗаМесяц Тогда 
			Если НормаДней = 0 Тогда
				Запись.Сумма = 0;
			Иначе
				Запись.Сумма = ФактДней / НормаДней * Запись.Параметр;	
			КонецЕсли; 
		ИначеЕсли Запись.ВидРасчета = ПланыВидовРасчета.Начисления.Больничный Тогда 
			Запись.Сумма = ФактДней / ДнейВБазе * База * Запись.Параметр / 100;
		КонецЕсли;
		
		Если Запись.ВидРасчета.УчитываетОтработанныеДни Тогда 	
			Запись.ОтработаноДней = ФактДней;
		КонецЕсли;
		
		Если Запись.Сторно Тогда
			Запись.Сумма = -Запись.Сумма;
			Запись.ОтработаноДней = -Запись.ОтработаноДней;
		КонецЕсли; 
		
	КонецЦикла; 
	
	НаборЗаписей.Записать();
КонецПроцедуры

Процедура РассчитатьЗаписи3(Регистратор, ПериодРегистрации) Экспорт
	
	НаборЗаписей = РегистрыРасчета.ЖурналНачислений.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписей.Прочитать(); 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЖурналНачисленийДанныеГрафика.НомерСтроки КАК НомерСтроки,
	|	ЖурналНачисленийДанныеГрафика.Сторно КАК Сторно,
	|	ЖурналНачисленийДанныеГрафика.Параметр КАК Параметр,
	|	ЖурналНачисленийДанныеГрафика.ПризнакПериодДействия КАК ПризнакПериодДействия,
	|	ЖурналНачисленийДанныеГрафика.ПризнакФактическийПериодДействия КАК ПризнакФактическийПериодДействия,
	|	ЖурналНачисленийДанныеГрафика.ПризнакБазовыйПериод КАК ПризнакБазовыйПериод,
	|	ЖурналНачисленийДанныеГрафика.ПризнакПериодРегистрации КАК ПризнакПериодРегистрации,
	|	ЖурналНачисленийДанныеГрафика.ВидРасчета.УчитываетОтработанныеДни КАК ВидРасчетаУчитываетОтработанныеДни,
	|	ЖурналНачисленийДанныеГрафика.ВидРасчета.СпособРасчета КАК СпособРасчета,
	|	ЕСТЬNULL(ЖурналНачисленийБазаЖурналНачислений.СуммаБаза, 0) КАК СуммаБаза,
	|	ЕСТЬNULL(ЖурналНачисленийБазаЖурналНачислений.ОтработаноДнейБаза, 0) КАК ОтработаноДнейБаза,
	|	ДанныеТабеляОбороты.КолДнейОборот КАК КолДнейПоТабелю
	|ИЗ
	|	РегистрРасчета.ЖурналНачислений.ДанныеГрафика(
	|			Регистратор = &Регистратор
	|				И ПериодРегистрации = &ПериодРегистрации) КАК ЖурналНачисленийДанныеГрафика
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ЖурналНачислений.БазаЖурналНачислений(
	|				&МассивИзмерений,
	|				&МассивИзмерений,
	|				,
	|				Регистратор = &Регистратор
	|					И ПериодРегистрации = &ПериодРегистрации) КАК ЖурналНачисленийБазаЖурналНачислений
	|		ПО ЖурналНачисленийДанныеГрафика.НомерСтроки = ЖурналНачисленийБазаЖурналНачислений.НомерСтроки
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ДанныеТабеля.Обороты(&НачалоМесяца, &КонецМесяца, , ) КАК ДанныеТабеляОбороты
	|		ПО ЖурналНачисленийДанныеГрафика.Сотрудник = ДанныеТабеляОбороты.Сотрудник
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	Запрос.УстановитьПараметр("ПериодРегистрации", ПериодРегистрации);
	Запрос.УстановитьПараметр("НачалоМесяца", НачалоМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("КонецМесяца", КонецМесяца(ПериодРегистрации));
	МассивИзмерений = Новый Массив(2);
	МассивИзмерений [0] = "Сотрудник";
	МассивИзмерений [1] = "Подразделение";
	Запрос.УстановитьПараметр("МассивИзмерений", МассивИзмерений); 
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	СтруктураПоиска = Новый Структура("НомерСтроки",);
	
	Для каждого Запись Из НаборЗаписей Цикл
		
		СтруктураПоиска.НомерСтроки = Запись.НомерСтроки;
		
		Если НЕ Выборка.НайтиСледующий(СтруктураПоиска) Тогда
			Запись.Сумма = 0;
			Запись.ОтработаноДней = 0;
		Иначе
			
			База = Выборка.СуммаБаза;
			ФактДней = Выборка.ПризнакФактическийПериодДействия;
			НормаДней = Выборка.ПризнакПериодДействия;
			ДнейВБазе =  Выборка.ОтработаноДнейБаза;
			УчитываетОтработанныеДни = Выборка.ВидРасчетаУчитываетОтработанныеДни;
			КолДнейПоТабелю = Выборка.КолДнейПоТабелю;
			СпособРасчета = Выборка.СпособРасчета;
			
			Если СпособРасчета = Перечисления.СпособыРасчета.ФиксированнойСуммой Тогда
				Запись.Сумма = Запись.Параметр;	
			ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.Процентом Тогда 
				Запись.Сумма = База * Запись.Параметр / 100;
			ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ЗаОтработанныеДни Тогда 			
				Запись.Сумма = ФактДней * Запись.Параметр;
			ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ПоТабелю Тогда 			
				Запись.Сумма = КолДнейПоТабелю * Запись.Параметр;
			ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ЗаМесяц Тогда 
				Если НормаДней = 0 Тогда
					Запись.Сумма = 0;
				Иначе
					Запись.Сумма = ФактДней / НормаДней * Запись.Параметр;	
				КонецЕсли; 
			ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ПоСреднему Тогда 
				Запись.Сумма = ФактДней / ДнейВБазе * База * Запись.Параметр / 100;
			КонецЕсли;
			
			Если УчитываетОтработанныеДни Тогда 	
				Запись.ОтработаноДней = ФактДней;
			КонецЕсли;
			
			Если Запись.Сторно Тогда
				Запись.Сумма = -Запись.Сумма;
				Запись.ОтработаноДней = -Запись.ОтработаноДней;
			КонецЕсли; 
		КонецЕсли; 
		
	КонецЦикла; 
	
	НаборЗаписей.Записать();
КонецПроцедуры
